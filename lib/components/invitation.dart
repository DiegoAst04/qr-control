import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/colors.dart';
import 'widgets.dart';
import 'dart:io';

//   _____             _        _
//  |_   _|         (_) |      | | (_)
//    | | _ ____   ___| |_ __ _| |_ _  ___  _ __
//    | || '_ \ \ / / | __/ _` | __| |/ _ \| '_ \
//   _| || | | \ V /| | || (_| | |_| | (_) | | | |
//   \___/_| |_|\_/ |_|\__\__,_|\__|_|\___/|_| |_|

class Invitation extends StatefulWidget {
  final String bannerPath;
  final List<String> artists;
  final String eventName;
  final String date;
  final String time;
  final VoidCallbackAction? onTap;

  const Invitation({
    super.key,
    required this.bannerPath,
    required this.artists,
    required this.eventName,
    required this.date,
    required this.time,
    this.onTap
  });

  @override
  InvitationState createState() => InvitationState();
}

class InvitationState extends State<Invitation> {

  String buildTitle() {
    final artists = widget.artists;
    final eventName = widget.eventName.trim();
    if (artists.isEmpty && eventName.isEmpty) return "[vacío]";
    if (eventName.isEmpty) return artists.join(', ');
    if (artists.length != 1) return eventName;
    return "${artists.single.trim()}: $eventName";
  }

  String buildDate() {
    if (widget.date.isEmpty) return "[vacío]";
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(widget.date);
    String todo = DateFormat('yMMMMEEEEd', 'es').format(parsedDate);
    return todo[0].toUpperCase() + todo.substring(1);
  }

  String buildTime() {
    if (widget.time.isNotEmpty) return widget.time;
    return "[vacío]";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.secondaryDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: const Color(0xFF7A7A7A)  //TODO: por definir
        )
      ),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.bannerPath.isNotEmpty)
            AspectRatio(
              aspectRatio: 2,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(widget.bannerPath)),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(14)
                ),
              ),
            ),
          Text(
            buildTitle(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          if (widget.artists.length > 1 && widget.eventName.trim().isNotEmpty)
            Text(widget.artists.join(', ')),
          Row(
            spacing: 8,
            children: [
              const Icon(
                Icons.calendar_month_rounded,
                color: AppColors.primaryText,
              ),
              Text(
                buildDate(),
                style: const TextStyle(
                  color: AppColors.primaryText,
                ),
              )
            ],
          ),
          Row(
            spacing: 8,
            children: [
              const Icon(
                Icons.access_time_rounded,
                color: AppColors.primaryText,
              ),
              Text(
                buildTime(),
                style: const TextStyle(
                  color: AppColors.primaryText,
                ),
              )
            ],
          ),
          const Row(
            spacing: 8,
            children: [
              Icon(
                Icons.place_rounded,
                color: AppColors.primaryText,
              ),
              Text(
                "Estadio Nacional, Lima, Perú",
                style: TextStyle(
                  color: AppColors.primaryText,
                ),
              )
            ],
          ),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(14)
            ),
          ),
          const Button(
            text: "Mostrar QR",
            prefixIcon: Icons.qr_code_rounded,
          ),
        ],
      ),
    );
  }
}