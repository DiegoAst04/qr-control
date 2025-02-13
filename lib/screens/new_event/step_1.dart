import 'package:flutter/material.dart';
import '../../components/widgets.dart';

class NewEvent1Screen extends StatefulWidget {
  const NewEvent1Screen({Key? key}) : super(key: key);

  @override
  State<NewEvent1Screen> createState() => _NewEvent1ScreenState();
}

class _NewEvent1ScreenState extends State<NewEvent1Screen> {
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
                      label: "Nombre del evento",
                      hintText: "Festival de bla bla",
                      prefixIcon: Icons.local_activity_rounded,
                    ),
                    MiTextBox(
                      label: "Artista(s)",
                      hintText: "Los Macarrones",
                      prefixIcon: Icons.music_note_rounded,
                    ),
                    MiTextBox(
                      label: "Descripción",
                      hintText: "Este evento bla bla",
                      prefixIcon: Icons.insert_comment_rounded,
                    )
                  ]
                )
              )
            ),
            MiButton(
              onPressed: _nada,
              text: "Siguiente",
            )
          ]
        )
      )
    );
  }
}