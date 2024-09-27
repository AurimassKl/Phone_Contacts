// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_contacts/provider/auth_provider.dart';
// import 'package:phone_contacts/provider/auth_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  // final GlobalKey _widgetKey = GlobalKey();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (context, ref, _) {
          final auth = ref.watch(authenticationProvider);
          Future<void> _onPressedFunction() async {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            await auth
                .signUpWithEmailAndPassword(
                  email.text,
                  password.text,
                  name.text,
                  context,
                )
                .whenComplete(
                  () => auth.authStateChange.listen(
                    (event) async {
                      if (event == null) {
                        return;
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                );
          }

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).padding.top + kToolbarHeight),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 144, 95, 228),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      const Image(
                        height: 300,
                        fit: BoxFit.fill,
                        image: AssetImage('assets/contacts.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 280),
                        child: Column(
                          children: [
                            Card(
                              elevation: 5,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                width: 300,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: name,
                                      validator: (value) {
                                        if (name.text.isEmpty) {
                                          return 'Empty field';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.black,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.person,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        hintText: 'Name',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      height: 1.5,
                                      color: Colors.grey[400],
                                    ),
                                    TextFormField(
                                      controller: email,
                                      validator: (value) {
                                        if (email.text.isEmpty) {
                                          return 'Empty field';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.black,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.email_outlined,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        hintText: 'Email address',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      height: 2,
                                      color: Colors.grey[400],
                                    ),
                                    TextFormField(
                                      controller: password,
                                      validator: (value) {
                                        if (password.text.isEmpty) {
                                          return 'Empty field';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.black,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      obscureText: !passwordVisible,
                                      decoration: InputDecoration(
                                        icon: const Icon(
                                          Icons.lock_outline_rounded,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                        hintStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        hintText: 'Password',
                                        border: InputBorder.none,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(
                                              () {
                                                passwordVisible =
                                                    !passwordVisible;
                                              },
                                            );
                                          },
                                          icon: Icon(
                                            passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      height: 2,
                                      color: Colors.grey[400],
                                    ),
                                    TextFormField(
                                      controller: confirmPassword,
                                      validator: (value) {
                                        if (password.text !=
                                            confirmPassword.text) {
                                          return 'Password does not match';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.black,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      obscureText: !confirmPasswordVisible,
                                      decoration: InputDecoration(
                                        icon: const Icon(
                                          Icons.lock_outline_rounded,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                        hintStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        hintText: 'Confirm Password',
                                        border: InputBorder.none,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(
                                              () {
                                                confirmPasswordVisible =
                                                    !confirmPasswordVisible;
                                              },
                                            );
                                          },
                                          icon: Icon(
                                            confirmPasswordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurple,
                                minimumSize: const Size(180, 40),
                              ),
                              onPressed: _onPressedFunction,
                              icon: const Icon(Icons.add),
                              label: const Text('SIGN UP'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
