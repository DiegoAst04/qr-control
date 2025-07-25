import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../components/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis tickets")
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              const Text(
                "Enero",
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 20,
                ),
              ),
              EventBox(
                bannerPath: "",
                artist: "Twenty One Pilots: The Clancy World Tour",
                date: "19/01/25",
                location: "Estadio Bicentenario La Florida",
              ),
              EventBox(
                bannerPath: "",
                artist: "Chayanne",
                date: "13/05/2004",
                location: "Estadio Nacional"
              )
            ]
          )
        )
      )
    );
  }
}