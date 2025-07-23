import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/widgets.dart';
import '../../models/models.dart';
import '../../theme/colors.dart';
import 'event_form_controller.dart';
import 'dart:io';

Widget buildPage1(
    EventFormController controller,
    ValueNotifier<String?> imagePathNotifier,
    void Function(VoidCallback) setState
    ) {
  return GestureDetector(
    child: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Column(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                const Text(
                  "Artista(s)",
                  style: TextStyle(
                      fontSize: 14.0
                  ),
                ),
                ...controller.artists.asMap().entries.map((entry) {
                  final i = entry.key;
                  final artist = entry.value;
                  return Row(
                    children: [
                      Expanded(
                        child: FormTextBox(
                          hintText: artist.hintText,
                          prefixIcon: Icons.music_note_rounded,
                          controller: artist.controller,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                        )
                      ),
                      if (controller.artists.length > 1)
                      IconButton(
                        onPressed: () {
                          final removed = controller.artists[i];
                          setState(() {
                            controller.artists.removeAt(i);
                          });
                          removed.controller.dispose();
                        },
                        icon: Icon(Icons.close_rounded)
                      ),
                    ],
                  );
                }),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        controller.addArtist();
                      });
                    },
                    icon: Icon(Icons.add),
                    label: Text("Añadir artista"),
                  ),
                ),
              ]
            ),
            FormTextBox(
              label: "Descripción",
              hintText: "Este evento bla bla",
              prefixIcon: Icons.insert_comment_rounded,
              controller: controller.descriptionController,
              textCapitalization: TextCapitalization.sentences,
              focusNode: controller.descriptionFocusNode,
            ),
            GestureDetector(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Banner",
                    style: TextStyle(
                      fontSize: 14.0
                    ),
                  ),
                  ValueListenableBuilder<String?>(
                    valueListenable: imagePathNotifier,
                    builder: (context, imagePath, _) {
                      return AspectRatio(
                        aspectRatio: 2,
                        child: imagePath == null
                        ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.secondaryDark,
                              width: 2
                            )
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_rounded,
                                size: 50,
                                color: AppColors.secondaryText
                              ),
                              Text(
                                "2 : 1",
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 16
                                ),
                              )
                            ],
                          ),
                        )
                        : Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: FileImage(File(controller.bannerPath!)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery
                );
                if (image != null) {
                  controller.bannerPath = image.path;
                  imagePathNotifier.value = image.path;
                }
              },
            )
          ]
        )
      ]
    )
  );
}

Widget buildPage2(EventFormController controller, BuildContext context) {
  void updateDateTime() {
    final date = controller.selectedDate;
    final time = controller.selectedTime;

    if (date != null && time != null) {
      controller.eventDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute
      );
    }
  }

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
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

    if (pickedDate != null) {
      controller.dateController.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      controller.selectedDate = pickedDate;
      updateDateTime();
    }
  }

  Future<void> selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now()
    );

    if(pickedTime != null) {
      DateTime parsedTime =
          DateTime(1, 1, 1, pickedTime.hour, pickedTime.minute);
      controller.timeController.text = DateFormat('H:mm').format(parsedTime);
      controller.selectedTime = pickedTime;
      updateDateTime();
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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.zones.length + 1,
              itemBuilder: (context, i) {
                if (i == controller.zones.length) {
                  return Center(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          controller.zones.add(ZoneData());
                        });
                      },
                      child: Text("Añadir")
                    ),
                  );
                }

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
              }
            ),
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