import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return BorderSide(color: AppColors.secondaryColor);
          }
          return BorderSide(color: AppColors.secondaryText);
        }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.secondaryColor;
          }
          return AppColors.secondaryText;
        }),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 12, vertical: 10)
        )
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Icon(icon),
          Text(
            label,
            style: const TextStyle(fontFamily: 'Poppins'),
          )
        ],
      )
    );
  }
}