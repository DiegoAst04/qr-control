import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_control/components/invitation.dart';
import '../../components/widgets.dart';
import '../../theme/colors.dart';
import 'event_form_controller.dart';

Widget buildPage1(EventFormController controller) {
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
          )
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

Widget buildPage3() {
  return Container();
}

Widget buildPage4(EventFormController controller) {

  String buildTitle() {
    if (controller.artistController.text.isEmpty
      && controller.eventNameController.text.isEmpty) {
      return "[vacío]";
    }
    if (controller.artistController.text.isEmpty) {
      return controller.eventNameController.text;
    }
    return "${controller.artistController.text}: ${controller.eventNameController.text}";
  }

  String buildDate() {
    if (controller.dateController.text.isEmpty) {
      return "[vacío]";
    }
    try {
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(controller.dateController.text);
      String todo = DateFormat('yMMMMEEEEd', 'es').format(parsedDate);
      return todo[0].toUpperCase() + todo.substring(1);
    }
    catch (e) {
      return "[formato inválido]";
    }
  }

  String buildTime() {
    if (controller.timeController.text.isNotEmpty) {
      DateTime parsedTime = DateFormat('h:mm').parse(controller.timeController.text);
      String time = DateFormat('jm', 'es').format(parsedTime);
      return time;
    }
    return "[vacío]";
  }

  return Center(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.secondaryDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Color(0xFF7A7A7A)
          )
      ),
      child: Column(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.red,
          ),
          Text(
            buildTitle(),
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
          Row(
            spacing: 8,
            children: [
              const Icon(
                Icons.calendar_month_rounded,
                color: AppColors.primaryText,
              ),
              Text(
                buildDate(),
                style: const TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: 'Poppins'
                ),
              )
            ],
          ),
          Row(
            spacing: 8,
            children: [
              const Icon(
                Icons.access_time_rounded,
                color: AppColors.primaryText,
              ),
              Text(
                buildTime(),
                style: const TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: 'Poppins'
                ),
              )
            ],
          ),
          const Row(
            spacing: 8,
            children: [
              Icon(
                Icons.place_rounded,
                color: AppColors.primaryText,
              ),
              Text(
                "Estadio Nacional, Lima, Perú",
                style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: 'Poppins'
                ),
              )
            ]
          ),
        ),
      ],
    ),
  );
}