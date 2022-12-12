import 'package:crud_app_with_sql/add_student.dart';
import 'package:crud_app_with_sql/database/database_helper.dart';
import 'package:crud_app_with_sql/update_student.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Student DB'),
          actions: [
            IconButton(
                onPressed: () async {
                  await DatabaseHelper().delete();
                  setState(() {});
                },
                icon: const Icon(Icons.delete)),
            IconButton(
                onPressed: () async {
                  var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => const AddStudent()));
                  if (result == 'success') {
                    setState(() {});
                  }
                },
                icon: const Icon(Icons.add)),
          ],
        ),
        body: FutureBuilder<List<Map>>(
          future: DatabaseHelper().getAllStudents(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    Map? student = snapshot.data?[index];
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.numbers),
                            title: const Text('ID'),
                            subtitle: Text(student?['id'].toString() ?? ''),
                            trailing: IconButton(
                                onPressed: () async {
                                  var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateStudent(
                                              id: student?['id'],
                                              name: student?['name'],
                                              address: student?['address'],
                                              phone: student?['phone'],
                                              email: student?['email'])));
                                  if (result != null && result == 'success') {
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(Icons.edit)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text('Name'),
                            subtitle: Text(student?['name']),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                              ),
                              onPressed: () async {
                                await DatabaseHelper()
                                    .deleteStudent(student?['id']);
                                setState(() {});
                              },
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.location_city),
                            title: const Text('Address'),
                            subtitle: Text(student?['address']),
                          ),
                          ListTile(
                            leading: const Icon(Icons.phone),
                            title: const Text('Phone'),
                            subtitle: Text(student?['phone']),
                          ),
                          ListTile(
                            leading: const Icon(Icons.mail),
                            title: const Text('Email'),
                            subtitle: Text(student?['email']),
                          )
                        ],
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
