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

  StepProgress({
    super.key,
    required this.currentStep,
    required this.steps
  });

  @override
  _StepProgressState createState() => _StepProgressState();
}

class _StepProgressState extends State<StepProgress> {
  double widthProgress = 0;

  @override
  void initState() {
    _onSizeWidget();
    super.initState();
  }

  void _onSizeWidget() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.size is Size) {
        Size size = context.size!;
        setState(() {
          widthProgress = size.width / widget.steps ;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 4,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primaryText,
            borderRadius: BorderRadius.circular(2)
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                width: widthProgress * (widget.currentStep + 1),
                duration: Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8)
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}