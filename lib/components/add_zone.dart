import 'package:flutter/material.dart';
import 'widgets.dart';

class ZoneCard extends StatelessWidget {
  final TextEditingController zoneNameController;
  final TextEditingController priceController;
  final TextEditingController capacityController;
  final bool showDeleteButton;
  final VoidCallback onDelete;
  final void Function(String)? onChanged;

  const ZoneCard({
    super.key,
    required this.zoneNameController,
    required this.priceController,
    required this.capacityController,
    this.showDeleteButton = true,
    required this.onDelete,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        FormTextBox(
          label: "Zona",
          hintText: "General",
          controller: zoneNameController,
          prefixIcon: Icons.groups_3_rounded,
        ),
        Row(
          spacing: 8,
          children: [
            Flexible(
              flex: 1,
              child: FormTextBox(
                label: "Aforo",
                hintText: "200",
                controller: capacityController,
                prefixIcon: Icons.people_rounded,
                onChanged: onChanged,
                keyboardType: TextInputType.number,
              ),
            ),
            Flexible(
              flex: 1,
              child: FormTextBox(
                label: "Precio",
                hintText: "50",
                controller: priceController,
                prefixIcon: Icons.attach_money_rounded,
                onChanged: onChanged,
                keyboardType: TextInputType.number,
              ),
            ),
            if (showDeleteButton)
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_rounded)
              ),
          ],
        )
      ],
    );
  }
}