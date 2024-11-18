import 'package:flutter/material.dart';
import 'package:flutter_application_1/db_helper/database_connection.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/Updateuser.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> _users = []; // List of users to display

  @override
  void initState() {
    super.initState();
    _loadUsers(); // Load the list of users when the screen is initialized
  }

  void _loadUsers() async {
    final usersData = await DatabaseHelper.instance
        .getUsers(); // Fetch users from the database
    setState(() {
      // Convert each user map to a User object and update the list
      _users = usersData;
    });
  }

  Future<void> _deleteUser(int id, int index) async {
    await DatabaseHelper.instance.deleteUser(id); // Delete the user from the DB
    setState(() {
      _users.removeAt(index); // Remove the user from the list in the UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite User Database'),
        backgroundColor: Colors.cyan,
      ),
      body: _users.isEmpty
          ? Center(child: Text('No users found.'))
          : ListView.builder(
              itemCount: _users.length, // The number of users to display
              itemBuilder: (context, index) {
                final user = _users[index]; // Get the user at the given index
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(user.name!), // Display the user's name
                    subtitle: Text(
                        '${user.contact} - ${user.description}'), // Display contact and description
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateUserScreen(
                                        id: user.id!,
                                        name: user.name!,
                                        contact: user.contact!,
                                        description: user.description!,
                                      )),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await _deleteUser(
                                user.id!, index); // Delete the user
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
