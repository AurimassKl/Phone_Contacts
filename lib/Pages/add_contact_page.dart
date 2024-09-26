import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_contacts/provider/database_provider.dart';

class AddPage extends ConsumerStatefulWidget {
  const AddPage({super.key});

  @override
  ConsumerState<AddPage> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final name = TextEditingController();
  final number = TextEditingController();
  bool imageRequired = false;
  File? imageFile;
  late String urlDownload;

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      setState(() => imageFile = File(image.path));
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD CONTACT'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final database = ref.watch(databaseProvider);

          Future<void> _onPressedFunction() async {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            if (imageFile == null) {
              setState(() {
                imageRequired = !imageRequired;
              });
              return;
            }
            urlDownload = await database.uploadFile(imageFile);
            await database
                .addNewContact(name.text, number.text, urlDownload)
                .whenComplete(() {
              Navigator.pop(context);
            });
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
                        Color.fromARGB(255, 185, 185, 185),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 60, 5, 20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: imageFile == null
                              ? const AssetImage('assets/question_mark.png')
                              : FileImage(
                                  imageFile!,
                                ) as ImageProvider,
                        ),
                        Visibility(
                          visible: imageRequired,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              '* Image is required',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => pickImage(ImageSource.gallery),
                                icon: const Icon(
                                  Icons.image_outlined,
                                  color: Colors.black,
                                ),
                                label: const Text(
                                  'Pick gallery',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  minimumSize: const Size(100, 40),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () => pickImage(ImageSource.camera),
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.black,
                                ),
                                label: const Text(
                                  'Pick camera',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  minimumSize: const Size(100, 40),
                                ),
                              )
                            ],
                          ),
                        ),
                        Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
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
                                hintStyle: TextStyle(color: Colors.black),
                                hintText: 'Name',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: number,
                                validator: (value) {
                                  if (!RegExp("r'+370[0-9]{8}|[0-9]{9}")
                                      .hasMatch(number.text)) {
                                    debugPrint('Taip');
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
                                    Icons.phone,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                  hintStyle: TextStyle(color: Colors.black),
                                  hintText: 'Number',
                                  border: InputBorder.none,
                                ),
                              ),
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
                          label: const Text('ADD CONTACTS'),
                        ),
                      ],
                    ),
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
