import 'package:flutter/material.dart';

class EventFormController {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  final FocusNode eventFocusNode = FocusNode();
  final FocusNode artistFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  void dispose() {
    eventNameController.dispose();
    artistController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();

    eventFocusNode.dispose();
    artistFocusNode.dispose();
    descriptionFocusNode.dispose();
  }
}