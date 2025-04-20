import 'package:flutter/material.dart';
import '../theme/colors.dart';

//  ______       _   _
//  | ___ \     | | | |
//  | |_/ /_   _| |_| |_ ___  _ __
//  | ___ \ | | | __| __/ _ \| '_ \
//  | |_/ / |_| | |_| || (_) | | | |
//  \____/ \__,_|\__|\__\___/|_| |_|

class Button extends StatefulWidget {
  final String? text;
  final VoidCallback? onPressed;
  final IconData? prefixIcon;

  const Button({
    super.key,
    this.text,
    this.onPressed,
    this.prefixIcon
  });

  @override
  ButtonState createState() => ButtonState();
}

class ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        iconColor: AppColors.primaryText,
        iconSize: 20
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            if (widget.prefixIcon != null)
              Icon(widget.prefixIcon),
            if (widget.text != null)
              Text(
                widget.text!,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 20,
                ),
              ),
          ],
        )
      )
    );
  }
}