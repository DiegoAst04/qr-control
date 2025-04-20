import 'package:flutter/material.dart';
import '../theme/colors.dart';

//   _____                _  ______
//  |  ___|              | | | ___ \
//  | |____   _____ _ __ | |_| |_/ / _____  __
//  |  __\ \ / / _ \ '_ \| __| ___ \/ _ \ \/ /
//  | |___\ V /  __/ | | | |_| |_/ / (_) >  <
//  \____/ \_/ \___|_| |_|\__\____/ \___/_/\_\

class EventBox extends StatefulWidget {
  final String artist;
  final DateTime date;
  final String place;
  final GestureTapCallback? onTap;

  const EventBox ({
    super.key,
    required this.artist,
    required this.date,
    required this.place,
    this.onTap
  });

  @override
  EventBoxState createState() => EventBoxState();
}
class EventBoxState extends State<EventBox> {
  int _getWeekDay() {
    return widget.date.weekday - 1;
  }
  int _getDate() {
    return widget.date.day;
  }
  int _getMonth() {
    return widget.date.month - 1;
  }

  static const List<String> weekDays = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];
  static const List<String> months = [
    'enero',
    'febrero',
    'marzo',
    'abril',
    'mayo',
    'junio',
    'julio',
    'agosto',
    'setiembre',
    'octubre',
    'noviembre',
    'diciembre'
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryDark,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${weekDays[_getWeekDay()]} ${_getDate()} de ${months[_getMonth()]}",
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w100,
                        color: AppColors.primaryText
                      ),
                    ),
                    Text(
                      widget.artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryText,
                      ),
                    ),
                    Text(
                      widget.place,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: AppColors.secondaryText
                      ),
                    ),
                  ]
                )
              )
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red
                      ),
                    ),
                    child: const Text(
                      "[Imagen]",
                      style: TextStyle(
                        color: AppColors.secondaryText
                      ),
                    ),
                  )
                ]
              )
            )
          ],
        )
      )
    );
  }
}