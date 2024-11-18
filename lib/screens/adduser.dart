import 'package:flutter/material.dart';
import 'package:flutter_application_1/db_helper/database_connection.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/listUsers.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _descriptionController = TextEditingController();
  Future<void> _addUser() async {
    final name = _nameController.text.trim();
    final contact = _contactController.text.trim();
    final description = _descriptionController.text.trim();

    if (name.isEmpty || contact.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    final user = User(name: name, contact: contact, description: description);
    await DatabaseHelper.instance.addUser(user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User added successfully!')),
    );

    _nameController.clear();
    _descriptionController.clear();
    _contactController.clear();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
          child: Container(
        width: 300,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: "name",
                  border: mesBordures(),
                  enabledBorder: mesBordures(),
                  focusedBorder: mesFocusBorder(),
                )),
            const SizedBox(height: 20),
            TextField(
                controller: _contactController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  labelText: "contact",
                  border: mesBordures(),
                  enabledBorder: mesBordures(),
                  focusedBorder: mesFocusBorder(),
                )),
            const SizedBox(height: 20),
            TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.description),
                  labelText: "description",
                  border: mesBordures(),
                  enabledBorder: mesBordures(),
                  focusedBorder: mesFocusBorder(),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addUser,
              child: const Text('Add User'),
            ),
          ],
        ),
      )),
    );
  }

  OutlineInputBorder mesBordures() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 3,
      ),
    );
  }

  OutlineInputBorder mesFocusBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.greenAccent,
        width: 3,
      ),
    );
  }
}
