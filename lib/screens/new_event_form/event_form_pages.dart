import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_control/components/invitation.dart';
import '../../components/widgets.dart';
import '../../theme/colors.dart';
import 'event_form_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

Widget buildPage1(
    EventFormController controller,
    ValueNotifier<String?> imagePathNotifier
    ) {
  return GestureDetector(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 20,
        children: [
          FormTextBox(
            label: "Nombre del evento",
            hintText: "Festival de bla bla",
            prefixIcon: Icons.local_activity_rounded,
            controller: controller.eventNameController,
            textCapitalization: TextCapitalization.sentences,
            focusNode: controller.eventFocusNode,
            textInputAction: TextInputAction.next,
          ),
          FormTextBox(
            label: "Artista(s)",
            hintText: "Los Macarrones",
            prefixIcon: Icons.music_note_rounded,
            controller: controller.artistController,
            textCapitalization: TextCapitalization.words,
            focusNode: controller.artistFocusNode,
            textInputAction: TextInputAction.next,
          ),
          FormTextBox(
            label: "Descripción",
            hintText: "Este evento bla bla",
            prefixIcon: Icons.insert_comment_rounded,
            controller: controller.descriptionController,
            textCapitalization: TextCapitalization.sentences,
            focusNode: controller.descriptionFocusNode,
          ),
          FormTextBox(
            label: "Banner",
            hintText: "Selecciona una imagen",
            prefixIcon: Icons.image_rounded,
            readOnly: true,
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery
              );
              if (image!=null) {
                controller.bannerPath = image.path;
                imagePathNotifier.value = image.path;
              }
            },
          ),

          ValueListenableBuilder<String?>(
            valueListenable: imagePathNotifier,
            builder: (context, imagePath, _) {
              if (imagePath == null) return const SizedBox.shrink();
              return Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: FileImage(File(controller.bannerPath!)),
                    fit: BoxFit.cover,
                  ),
                ),
              );
              /* TODO: Revisar cómo funciona, también se puede usar (responsiveness):
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(imagePath),
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ); */
            },
          ),
        ]
      )
    )
  );
}

Widget buildPage2(EventFormController controller, BuildContext context) {
  Future<void> selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day
      ),
      lastDate: DateTime(
        DateTime.now().year + 15,
        DateTime.december,
        31
      )
    );

    if (selectedDate != null) {
      controller.dateController.text =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    }
  }

  Future<void> selectTime() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now()
    );

    if(selectedTime != null) {
      DateTime parsedTime =
          DateTime(1, 1, 1, selectedTime.hour, selectedTime.minute);
      String formattedTime = DateFormat('H:mm').format(parsedTime);
      controller.timeController.text = formattedTime;
    }
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 20,
      children: [
        FormTextBox(
          label: "Fecha",
          hintText: "--/--/--",
          prefixIcon: Icons.calendar_month_rounded,
          controller: controller.dateController,
          readOnly: true,
          onTap: selectDate
        ),
        FormTextBox(
          label: "Hora",
          hintText: "-- : --",
          prefixIcon: Icons.access_time_rounded,
          controller: controller.timeController,
          readOnly: true,
          onTap: selectTime
        ),
        FormTextBox(
          label: "Ubicación",
          hintText: "Selecciona en el mapa",
          prefixIcon: Icons.location_on_rounded,
        )
      ]
    )
  );
}

Widget buildPage3(EventFormController controller) {
  return StatefulBuilder(
    builder: (context, setState) {
      List<int> getTotals() {
        List<int> sum = [0, 0];
        for (int i = 0; i < controller.zones.length; i++) {
          sum[0] += controller.zones[i].capacityController.text.isNotEmpty
              ? int.parse(controller.zones[i].capacityController.text)
              : 0;
          sum[1] += controller.zones[i].priceController.text.isNotEmpty
              ? int.parse(controller.zones[i].priceController.text)
                * int.parse(controller.zones[i].capacityController.text)
              : 0;
        }
        return sum;
      }
      final List<int> totals = getTotals();

      return Column(
        children: [
          Expanded(
            child:
              Column(
                children: [
                  ...List.generate(controller.zones.length, (i) {
                    final zone = controller.zones[i];
                    return ZoneCard(
                      key: ValueKey(zone.id),
                      zoneNameController: zone.zoneNameController,
                      capacityController: zone.capacityController,
                      priceController: zone.priceController,
                      showDeleteButton: i != 0,
                      onChanged: (_) => setState(() {}),
                      onDelete: () {
                        setState(() {
                          controller.zones.removeAt(i);
                        });
                      },
                    );
                  }),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        controller.zones.add(ZoneData());

                      });
                    },
                    child: Text("Añadir")
                  )
                ]
              )
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryDark,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Aforo total"),
                      Text("${totals[0]}")
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Ganancia potencial"),
                      Text("${totals[1]}")
                    ]
                  )
                ]
              )
            )
          )
        ]
      );
    }
  );
}

Widget buildPage4(EventFormController controller) {
  final PageController pageController = PageController(initialPage: 0);

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        const Text(
          "Así se verán tus widgets",
          style: TextStyle(
            fontWeight: FontWeight.w600
          ),
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            children: [
              Invitation(
                bannerPath: controller.bannerPath!,
                artist: controller.artistController.text,
                eventName: controller.eventNameController.text,
                date: controller.dateController.text,
                time: controller.timeController.text
              ),
              EventBox(
                artist: controller.artistController.text,
                date: DateTime.now(),
                place: "Estadio La Molina"
              )
            ]
          ),
        ),
      ],
    ),
  );
}