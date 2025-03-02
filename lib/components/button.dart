import 'package:flutter/material.dart';
import '../theme/colors.dart';

//  ______       _   _
//  | ___ \     | | | |
//  | |_/ /_   _| |_| |_ ___  _ __
//  | ___ \ | | | __| __/ _ \| '_ \
//  | |_/ / |_| | |_| || (_) | | | |
//  \____/ \__,_|\__|\__\___/|_| |_|

class MiButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const MiButton({
    super.key,
    required this.text,
    this.onPressed
  });

  @override
  _MiButtonState createState() => _MiButtonState();
}

class _MiButtonState extends State<MiButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 20,
                  ),
                )
            )
        )
    );
  }
}