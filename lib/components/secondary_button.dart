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
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: AppColors.secondaryText,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        foregroundColor: AppColors.secondaryText,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10)
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