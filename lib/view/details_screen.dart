import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_sample/network/endpoints.dart';
import 'package:image_sample/network/requests.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.imgUrl,
    required this.imgTag,
  });

  final String imgUrl;
  final String imgTag;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailPattern = RegExp(r'^[\w-]+@[\w-]+\.\w+$');
  final _phonePattern = RegExp(r'^\d{10}$');

  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _phone = "";

  _handleSubmit() {
    Map<String, dynamic> data = {
      "first_name": _firstName,
      "last_name": _lastName,
      "image": widget.imgUrl,
      "email": _email,
      "phone": _phone,
    };

    APIRequests().saveData(url: APIEndpoints().saveData, payload: data).then(
      (value) {
        final Map<String, dynamic> jsonData = json.decode(value!);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonData["message"])),
        );

        Navigator.pop(context);
      },
    );
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
            Padding(
              padding: const EdgeInsets.all(5),
              child: Hero(
                tag: widget.imgTag,
                child: Image.network(
                  height: 225,
                  widget.imgUrl,
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

                        if (!_emailPattern.hasMatch(value)) {
                          return "Invalid Email";
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

                        if (!_phonePattern.hasMatch(value)) {
                          return "Invalid Phone Number";
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
