import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'dart:math';

class EventFormController {
  // Page 1
  final TextEditingController eventNameController = TextEditingController();
  List<ArtistInput> artists = [];
  final List<String> hintArtists = [
    "Los Macarrones",
    "Salchiconeros",
    "Los Gatos Voladores",
    "Los Hijos del WiFi",
    "Modo Avión",
    "Pilotos sin alas",
    "Astronautas de Kinder",
    "Tsunami de Cereal",
    "Narcóticos Anónimos",
    "Mamá perdí el juicio",

  ];
  void addArtist() {
    final randomHint = hintArtists[Random().nextInt(hintArtists.length)];
    artists.add(ArtistInput(
      controller: TextEditingController(),
      hintText: randomHint
    ));
  }

  final TextEditingController descriptionController = TextEditingController();

  // Page 2
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  List<ZoneData> zones = [ZoneData()];
  String? bannerPath = '';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateTime? eventDateTime;

  // FocusNodes
  final FocusNode eventFocusNode = FocusNode();
  final FocusNode artistFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  void dispose() {
    eventNameController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();

    eventFocusNode.dispose();
    artistFocusNode.dispose();
    descriptionFocusNode.dispose();
  }

  EventFormController() {
    addArtist();
  }
}