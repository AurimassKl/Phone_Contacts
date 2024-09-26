import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_contacts/pages/signup_page.dart';
import 'package:phone_contacts/provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final email = TextEditingController();
  final password = TextEditingController();
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final _auth = ref.watch(authenticationProvider);

          Future<void> _onPressedFunction() async {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            await _auth
                .signInWithEmailAndPassword(
                  email.text,
                  password.text,
                  context,
                )
                .whenComplete(
                  () => _auth.authStateChange.listen(
                    (event) async {
                      if (event == null) {
                        return;
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
                  height: MediaQuery.of(context).size.height,
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
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Image(
                          height: 300,
                          fit: BoxFit.fill,
                          image: AssetImage('assets/contacts.png'),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
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
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller: email,
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
                                      hintStyle: TextStyle(color: Colors.black),
                                      hintText: 'Email address',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  Container(
                                    width: 300,
                                    height: 1,
                                    color: Colors.grey[400],
                                  ),
                                  TextField(
                                    controller: password,
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
                                      hintStyle:
                                          const TextStyle(color: Colors.black),
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
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurple,
                                minimumSize: const Size(180, 40),
                              ),
                              onPressed: _onPressedFunction,
                              child: const Text('LOGIN'),
                            ),
                          )
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            // ignore: inference_failure_on_instance_creation
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Create your account'),
                            Icon(Icons.arrow_forward_rounded)
                          ],
                        ),
                      )
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
