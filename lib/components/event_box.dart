import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/colors.dart';
import 'dart:io';

//   _____                _  ______
//  |  ___|              | | | ___ \
//  | |____   _____ _ __ | |_| |_/ / _____  __
//  |  __\ \ / / _ \ '_ \| __| ___ \/ _ \ \/ /
//  | |___\ V /  __/ | | | |_| |_/ / (_) >  <
//  \____/ \_/ \___|_| |_|\__\____/ \___/_/\_\

class EventBox extends StatefulWidget {
  final String bannerPath;
  final String artist;
  final String location;
  final String date;
  final GestureTapCallback? onTap;

  const EventBox ({
    super.key,
    required this.bannerPath,
    required this.artist,
    required this.location,
    required this.date,
    this.onTap
  });

  @override
  EventBoxState createState() => EventBoxState();
}
class EventBoxState extends State<EventBox> {
  String buildDate() {
    if (widget.date.isEmpty) return "[vacío]";
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(widget.date);
    String todo = DateFormat('MMMMEEEEd', 'es').format(parsedDate);
    return todo[0].toUpperCase() + todo.substring(1);
  }

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
                      buildDate(),
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
                      widget.location,
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
                      image: DecorationImage(
                        image: FileImage(File(widget.bannerPath)),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(12)
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