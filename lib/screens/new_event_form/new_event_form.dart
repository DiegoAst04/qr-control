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
  double _currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                currentStep: _currentPage,
                steps: 4
              ),

              Expanded(
                child: Form(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      buildPage1(_formController),
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
                    Button(
                      prefixIcon: Icons.chevron_left,
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease
                        );
                      },
                    ),
                    Button(
                      text: "Siguiente",
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease
                        );
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