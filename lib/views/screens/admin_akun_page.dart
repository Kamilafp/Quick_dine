import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_dine/views/screens/admin_kantin_page.dart';
import 'package:quick_dine/views/screens/admin_dashboard_page.dart';

class AdminAkunPage extends StatefulWidget {
  @override
  _AdminAkunPageState createState() => _AdminAkunPageState();
}

class _AdminAkunPageState extends State<AdminAkunPage> {
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/api/user'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        setState(() {
          users = data.map((item) => Map<String, dynamic>.from(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  void showEditModal(BuildContext context, Map<String, dynamic> user) {
    final TextEditingController nameController = TextEditingController(text: user['name']);
    final TextEditingController emailController = TextEditingController(text: user['email']);
    final TextEditingController phoneController = TextEditingController(text: user['phone']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final response = await http.put(
                    Uri.parse('http://localhost/api/user/${user['id']}'),
                    body: {
                      'name': nameController.text,
                      'email': emailController.text,
                      'phone': phoneController.text,
                    },
                  );

                  if (response.statusCode == 200) {
                    fetchUsers();
                    Navigator.pop(context);
                  } else {
                    throw Exception('Failed to update user');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteModal(BuildContext context, int userId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final response = await http.delete(Uri.parse('http://localhost/api/user/$userId'));
                  if (response.statusCode == 200) {
                    fetchUsers();
                    Navigator.pop(context);
                  } else {
                    throw Exception('Failed to delete user');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun'),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboardPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Admin'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminAkunPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.store),
              title: Text('Kantin'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminKantinPage()));
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Phone')),
                    DataColumn(label: Text('Role')),
                    DataColumn(label: Text('Photo')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: users.map((user) {
                    return DataRow(cells: [
                      DataCell(Text(user['name'])),
                      DataCell(Text(user['email'])),
                      DataCell(Text(user['phone'])),
                      DataCell(Text(user['role'])),
                      DataCell(
                        Image.network(
                          user['photo'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                showEditModal(context, user);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDeleteModal(context, user['id']);
                              },
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
    );
  }
}
