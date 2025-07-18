import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/widgets.dart';
import '../theme/colors.dart';
import 'home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Text(
                    "Crea una cuenta",
                    style: Theme.of(context).textTheme.displayLarge
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 16,
                    children: [
                      FormTextBox(
                        label: "Nombre(s)",
                        hintText: "Brad",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Olvidaste tu nombre';
                          }
                          return null;
                        },
                        controller: nameController,
                        textCapitalization: TextCapitalization.words,
                        focusNode: nameFocusNode,
                        prefixIcon: Icons.person_rounded,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(lastNameFocusNode);
                        },
                        textInputAction: TextInputAction.next
                      ),
                      FormTextBox(
                        label: "Apellido(s)",
                        hintText: "Pitt",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Olvidaste tu apellido';
                          }
                          return null;
                        },
                        controller: lastNameController,
                        textCapitalization: TextCapitalization.words,
                        focusNode: lastNameFocusNode,
                        prefixIcon: Icons.person_rounded,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(emailFocusNode);
                        },
                        textInputAction: TextInputAction.next
                      ),
                      FormTextBox(
                        label: "Email",
                        hintText: "myemail@example.com",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Necesitamos un email';
                          }
                          return null;
                        },
                        controller: emailController,
                        focusNode: emailFocusNode,
                        prefixIcon: Icons.alternate_email_rounded,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(passwordFocusNode);
                        },
                        textInputAction: TextInputAction.next
                      ),
                      Column(
                        spacing: 8,
                        children: [
                          FormTextBox(
                            label: "Contraseña",
                            hintText: "****************",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '¿Y la contraseña?';
                              }
                              return null;
                            },
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            prefixIcon: Icons.key_rounded,
                            suffixIcon: Icons.visibility,
                            isPassword: true,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(confPasswordFocusNode);
                            },
                            textInputAction: TextInputAction.next
                          ),
                          Visibility(
                            visible: _password.isNotEmpty,
                            child: PasswordSafeBar(password: _password)
                          )
                        ]
                      ),
                      FormTextBox(
                        label: "Confirmar Contraseña",
                        hintText: "****************",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirma tu contraseña';
                          }
                          return null;
                        },
                        controller: confPasswordController,
                        focusNode: confPasswordFocusNode,
                        prefixIcon: Icons.key_rounded,
                        suffixIcon: Icons.visibility,
                        isPassword: true
                      ),
                      Button(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) { return; }

                          final firstName = nameController.text.trim();
                          final lastName = lastNameController.text.trim();
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();
                          final confPassword = confPasswordController.text.trim();

                          if (password != confPassword) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Las contraseñas no coinciden")
                              )
                            );
                            return;
                          }

                          try {
                            // Registro en Auth
                            final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: email,
                              password: password
                            );

                            // Registro en Firestore
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(cred.user!.uid)
                                .set({
                              'firstName': firstName,
                              'lastName': lastName,
                              'email': email,
                              'role': ''
                            });

                            // Usuario creado
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen()
                              )
                            );
                          } on FirebaseAuthException catch (e) {
                            String mensaje = 'Falta llenar campos';
                            if (e.code == 'email-already-in-use') {
                              mensaje = 'El correo ya está usado';
                            } else if (e.code == 'weak-password') {
                              mensaje = 'La contraseña ta débil';
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(mensaje))
                            );
                          }
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
                                thickness: 0.4
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
                                thickness: 0.4
                              )
                            )
                          ]
                        )
                      )
                    ]
                  )
                ]
              ),
            )
          )
        )
      )
    );
  }
}