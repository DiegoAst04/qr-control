import 'package:flutter/material.dart';
import 'package:qr_control/components/widgets.dart';
import 'package:qr_control/screens/screens.dart';
import 'package:qr_control/theme/colors.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("¡Bienvenido!"),
        //centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            spacing: 24,
            children: [
              const Image(image: AssetImage('assets/images/welcome_image.png')),
              Column(
                spacing: 16,
                children: [
                  Button(
                    text: "Inicia sesión",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen()
                        )
                      );
                    }
                  ),
                  Button(
                    text: "Regístrate",
                    color: AppColors.secondaryColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen()
                        )
                      );
                    }
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  spacing: 8,
                  children: <Widget> [
                    Expanded(
                      child: Divider(
                        color: AppColors.secondaryText,
                        thickness: 0.4,
                      )
                    ),
                    Text(
                      "o usando",
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.secondaryText,
                        thickness: 0.4,
                      )
                    )
                  ]
                )
              ),
            ]
          ),
        )
      )
    );
  }
}