import 'package:flutter/material.dart';
import '../components/widgets.dart';
import '../theme/colors.dart';
import 'home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confPasswordController = TextEditingController();

  final nameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confPasswordFocusNode = FocusNode();
  String _password = "";

  @override
  void initState() {
    super.initState();
    passwordController.addListener((){
      setState(() {
        _password = passwordController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Text(
                "Crea una cuenta",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 16,
                children: [
                  FormTextBox(
                    label: "Nombre(s)",
                    hintText: "Brad",
                    controller: nameController,
                    textCapitalization: TextCapitalization.words,
                    focusNode: nameFocusNode,
                    prefixIcon: Icons.person_rounded,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(lastNameFocusNode);
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  FormTextBox(
                    label: "Apellido(s)",
                    hintText: "Pitt",
                    controller: lastNameController,
                    textCapitalization: TextCapitalization.words,
                    focusNode: lastNameFocusNode,
                    prefixIcon: Icons.person_rounded,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(emailFocusNode);
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  FormTextBox(
                    label: "Email",
                    hintText: "myemail@example.com",
                    controller: emailController,
                    focusNode: emailFocusNode,
                    prefixIcon: Icons.alternate_email_rounded,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  Column(
                    spacing: 8,
                    children: [
                      FormTextBox(
                        label: "Contraseña",
                        hintText: "****************",
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        prefixIcon: Icons.key_rounded,
                        suffixIcon: Icons.visibility,
                        isPassword: true,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(confPasswordFocusNode);
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      Visibility(
                        visible: _password.isNotEmpty,
                        child: PasswordSafeBar(password: _password,)
                      )
                    ]
                  ),
                  FormTextBox(
                    label: "Confirmar Contraseña",
                    hintText: "****************",
                    controller: confPasswordController,
                    focusNode: confPasswordFocusNode,
                    prefixIcon: Icons.key_rounded,
                    suffixIcon: Icons.visibility,
                    isPassword: true,
                  ),
                  MiButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen()
                        )
                      );
                    },
                    text: "Registrarse",
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
                  )
                ]
              )
            ]
          )
        )
      )
    );
  }
}