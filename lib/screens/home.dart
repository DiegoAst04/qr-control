import 'package:flutter/material.dart';
import 'package:qr_control/theme/colors.dart';

import '../components/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _nada() {
    debugPrint("si");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis tickets"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                "Enero",
                style: TextStyle(
                  color: AppColors.primaryText
                ),
              ),
              EventBox(
                artist: "Twenty One Pilots: The Clancy World Tour",
                date: DateTime(2025, 1, 19, 21),
                place: "Estadio Bicentenario La Florida",
              ),
              EventBox(
                artist: "Chayanne",
                date: DateTime(2025, 7, 21, 21),
                place: "Estadio Nacional"
              )
            ]
          )
        )
      )
    );
  }
}