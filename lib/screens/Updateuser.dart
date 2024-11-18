import 'package:flutter/material.dart';
import 'package:flutter_application_1/db_helper/database_connection.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/listUsers.dart';

class UpdateUserScreen extends StatefulWidget {
  final String name;
  final int id;
  final String description;
  final String contact;
  const UpdateUserScreen(
      {Key? key,
      required this.id,
      required this.name,
      required this.contact,
      required this.description})
      : super(key: key);

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  var _nameController = TextEditingController();
  var _contactController = TextEditingController();
  var _descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _nameController.text = widget.name;
    _contactController.text = widget.contact;
    _descriptionController.text = widget.description;
  }

  Future<void> _updateuser() async {
    final name = _nameController.text.trim();
    final contact = _contactController.text.trim();
    final description = _descriptionController.text.trim();
    final id = widget.id;
    if (name.isEmpty || contact.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    final user = User.withId(
        id: widget.id, name: name, contact: contact, description: description);
    await DatabaseHelper.instance.updateUser(user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User updated successfully!')),
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
        title: const Text('Update User'),
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
              onPressed: _updateuser,
              child: const Text('Update User'),
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
