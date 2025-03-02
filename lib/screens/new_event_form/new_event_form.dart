import 'package:flutter/material.dart';
import '../../components/widgets.dart';
import 'event_form_controller.dart';
import 'event_form_pages.dart';

class NewEventForm extends StatefulWidget {
  const NewEventForm({
    super.key
  });

  @override
  _NewEventFormState createState() => _NewEventFormState();
}

class _NewEventFormState extends State<NewEventForm> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo Evento")
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: StepProgress(
              currentStep: _currentPage,
              steps: 4
            )
          ),

          Expanded(
            child: Form(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  buildPage1(_formController),
                  buildPage2(_formController, context),
                  buildPage3(),
                  buildPage4(_formController)
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: Text("Anterior"),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease
                    );
                  },
                ),
                ElevatedButton(
                  child: Text("Siguiente"),
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}