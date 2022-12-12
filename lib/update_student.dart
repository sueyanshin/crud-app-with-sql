import 'package:flutter/material.dart';

import 'database/database_helper.dart';
import 'models/student.dart';

class UpdateStudent extends StatefulWidget {
  const UpdateStudent(
      {required this.id,
      required this.name,
      required this.address,
      required this.phone,
      required this.email});
  final int id;
  final String name;
  final String address;
  final String phone;
  final String email;

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  final GlobalKey<FormState> _key = GlobalKey();
  int? id;
  String? name, address, phone, email;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    name = widget.name; // ho bat ka lr mat name
    address = widget.address;
    phone = widget.phone;
    email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Update Student')),
      body: Form(
          key: _key,
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              const Text('Name'),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                initialValue: name,
                validator: (str) {
                  if (str == null || str.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
                onSaved: (str) {
                  name = str;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Enter Name',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text('Address'),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                initialValue: address,
                validator: (str) {
                  if (str == null || str.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                onSaved: (str) {
                  address = str;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_city),
                    hintText: 'Enter Address',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text('Phone'),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                initialValue: phone,
                validator: (str) {
                  if (str == null || str.isEmpty) {
                    return 'Please enter phone';
                  }
                  return null;
                },
                onSaved: (str) {
                  phone = str;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Enter Phone',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text('Email'),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                initialValue: email,
                validator: (str) {
                  if (str == null || str.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
                onSaved: (str) {
                  email = str;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter Email',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    if (_key.currentState != null &&
                        _key.currentState!.validate()) {
                      _key.currentState?.save();
                      int result = await DatabaseHelper().updateStudent(
                          Student.insertStudent(
                              name: name ?? '',
                              address: address ?? '',
                              email: email ?? '',
                              phone: phone ?? ''),
                          id!);

                      Navigator.pop(context, 'success');
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save'))
            ],
          )),
    );
  }
}
