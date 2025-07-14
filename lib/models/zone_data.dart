import 'package:flutter/material.dart';

class ZoneData {
  final Key id;
  final TextEditingController zoneNameController;
  final TextEditingController capacityController;
  final TextEditingController priceController;

  ZoneData()
      : id = UniqueKey(),
        zoneNameController = TextEditingController(),
        capacityController = TextEditingController(),
        priceController = TextEditingController();
}