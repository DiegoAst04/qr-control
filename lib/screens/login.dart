import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import '../components/widgets.dart';
import '../theme/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  //final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _nada() {
    debugPrint("si");
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
                "¡Bienvenido!",
                style: Theme.of(context).textTheme.displayLarge
              ),
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 16,
                  children: [
                    FormTextBox(
                      label: "Email",
                      hintText: "myemail@example.com",
                      controller: emailController,
                      focusNode: emailFocusNode,
                      prefixIcon: Icons.mail_rounded,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: 4,
                      children: [
                        FormTextBox(
                          label: "Contraseña",
                          hintText: "****************",
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          prefixIcon: Icons.key_rounded,
                          suffixIcon: Icons.visibility_rounded,
                          isPassword: true,
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Olvidé mi contraseña ",
                            style: const TextStyle(
                              color: AppColors.accentedText,
                              fontSize: 14,
                            ),
                            recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()
                                )
                              );
                            }
                          )
                        )
                      ]
                    ),
                    MiButton(
                      onPressed: _nada,
                      text: "Entrar",
                    )
                  ]
                )
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 6,
                children: [
                  const Text(
                    "¿Aún no tienes una cuenta?",
                    style: TextStyle(
                      color: AppColors.primaryText,
                    )
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Regístrate",
                      style: const TextStyle(
                        color: AppColors.accentedText,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.accentedText
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen()
                            )
                          );
                        }
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