import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../components/widgets.dart';
import 'event_form_controller.dart';
import 'event_form_pages.dart';

class NewEventFormScreen extends StatefulWidget {
  const NewEventFormScreen({
    super.key
  });

  @override
  NewEventFormState createState() => NewEventFormState();
}

class NewEventFormState extends State<NewEventFormScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final EventFormController _formController = EventFormController();
  final ValueNotifier<String?> _imagePathNotifier = ValueNotifier(null);
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    Future<void> createEvent() async {
      if (_formController.eventDateTime == null) {
        throw Exception("No se ha seleccionado una fecha");
      }

      final artistas = [
        _formController.artistController.text.trim(),
        ..._formController.artists
            .map((controller) => controller.controller.text.trim())
            .where((text) => text.isNotEmpty)
      ];

      // TODO: Conectar con Google Cloud D:
      //String? bannerUrl;
      // if (_formController.bannerPath != null) {
      //   final file = File(_formController.bannerPath!);
      //   final ref = FirebaseStorage.instance
      //       .ref()
      //       .child('banners/${DateTime.now().millisecondsSinceEpoch}.jpg');
      //   await ref.putFile(file);
      //   bannerUrl = await ref.getDownloadURL();
      // }
      await FirebaseFirestore.instance.collection("event").add({
        "name": _formController.eventNameController.text.trim(),
        "artists": artistas,
        //"description": description,
        "dateTime": Timestamp.fromDate(_formController.eventDateTime!),
        //"bannerUrl": bannerUrl,
        'createdAt': Timestamp.now(),
      });
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => {
        FocusScope.of(context).unfocus()
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Nuevo Evento")
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepProgress(
                size: size,
                currentStep: _currentPage,
                steps: 4
              ),

              Expanded(
                child: Form(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      buildPage1(_formController, _imagePathNotifier, setState),
                      buildPage2(_formController, context),
                      buildPage3(_formController),
                      buildPage4(_formController)
                    ]
                  )
                )
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage > 0)
                      Button(
                        prefixIcon: Icons.chevron_left,
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease
                          );
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    Button(
                      text: _currentPage == 3 ? "Crear Evento" : "Siguiente",
                      onPressed: () async {
                        if (_currentPage < 3) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease
                          );
                          FocusScope.of(context).unfocus();
                        } else {
                          try {
                            await createEvent();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Evento creado exitosamente")
                              )
                            );
                            //Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Error: $e")
                              )
                            );
                          }
                        }
                      }
                    ),
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}