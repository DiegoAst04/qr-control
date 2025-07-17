import 'package:flutter/material.dart';
import '../theme/colors.dart';

//   _____ _            ______
//  /  ___| |           | ___ \
//  \ `--.| |_ ___ _ __ | |_/ / __ ___   __ _ _ __ ___  ___ ___
//   `--. \ __/ _ \ '_ \|  __/ '__/ _ \ / _` | '__/ _ \/ __/ __|
//  /\__/ / ||  __/ |_) | |  | | | (_) | (_| | | |  __/\__ \__ \
//  \____/ \__\___| .__/\_|  |_|  \___/ \__, |_|  \___||___/___/
//                | |                    __/ |
//                |_|                   |___/

class StepProgress extends StatefulWidget {

  final double currentStep;
  final double steps;
  final Size size;

  const StepProgress({
    super.key,
    required this.currentStep,
    required this.steps,
    required this.size
  });

  @override
  StepProgressState createState() => StepProgressState();
}

class StepProgressState extends State<StepProgress> {
  late double widthProgress;

  @override
  void initState() {
    super.initState();
    widthProgress = (widget.size.width - 40) / widget.steps;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 4,
        width: widget.size.width,
        decoration: BoxDecoration(
          color: AppColors.primaryText,
          borderRadius: BorderRadius.circular(2)
        ),
        child: Stack(
          children: [
            AnimatedContainer(
              width: widthProgress * (widget.currentStep + 1),
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8)
              ),
            ),
          ],
        ),
      ),
    );
  }
}