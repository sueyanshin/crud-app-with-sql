import 'package:crud_app_with_sql/database/database_helper.dart';
import 'package:crud_app_with_sql/models/student.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final GlobalKey<FormState> _key = GlobalKey();
  String? name, address, phone, email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('Add Student')),
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
                        int id = await DatabaseHelper().insertStudent(
                            Student.insertStudent(
                                name: name ?? '',
                                address: address ?? '',
                                email: email ?? '',
                                phone: phone ?? ''));
                        print(id);
                        Navigator.pop(context, 'success');
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save'))
              ],
            )));
  }
}
