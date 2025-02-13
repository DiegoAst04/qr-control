import 'package:flutter/material.dart';
import '../../components/widgets.dart';

class NewEvent2Screen extends StatefulWidget {
  const NewEvent2Screen({Key? key}) : super(key: key);

  @override
  State<NewEvent2Screen> createState() => _NewEvent2ScreenState();
}

class _NewEvent2ScreenState extends State<NewEvent2Screen> {
  void _nada() {
    debugPrint("si");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo Evento"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                fit: FlexFit.loose,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 20,
                      children: [
                        MiTextBox(
                          label: "Fecha",
                          hintText: "--/--/--",
                          prefixIcon: Icons.calendar_month_rounded,
                        ),
                        MiTextBox(
                          label: "Hora",
                          hintText: "-- : --",
                          prefixIcon: Icons.access_time_rounded,
                        ),
                        MiTextBox(
                          label: "Ubicación",
                          hintText: "Selecciona en el mapa",
                          prefixIcon: Icons.location_on_rounded,
                        )
                      ]
                    )
                )
            ),
            MiButton(
              text: "Siguiente",
              onPressed: _nada
            )
          ]
        )
      )
    );
  }
}