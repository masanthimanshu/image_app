import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_sample/network/endpoints.dart';
import 'package:image_sample/network/requests.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  bool _showImg = false;

  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _phone = "";

  late File _imageFile;

  _handleSubmit() {
    Map<String, dynamic> data = {
      "image": _imageFile.path,
      "first_name": _firstName,
      "last_name": _lastName,
      "email": _email,
      "phone": _phone,
    };

    APIRequests().saveData(url: APIEndpoints().saveData, payload: data).then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(value!)),
        );

        Navigator.pop(context);
      },
    );
  }

  _uploadImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        _showImg = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details Screen")),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            GestureDetector(
              onTap: _uploadImage,
              child: Container(
                height: 250,
                margin: const EdgeInsets.all(10),
                child: _showImg
                    ? Image.file(
                        _imageFile,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/upload_image.png",
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Expanded(child: Text("First Name")),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      onChanged: (text) => _firstName = text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your First Name";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Expanded(child: Text("Last Name")),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      onChanged: (text) => _lastName = text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your Last Name";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Expanded(child: Text("Email")),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      onChanged: (text) => _email = text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your Email";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Expanded(child: Text("Phone")),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      onChanged: (text) => _phone = text,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter Phone Number";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _handleSubmit();
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
