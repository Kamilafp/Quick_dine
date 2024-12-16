import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_dine/constant.dart';
import 'package:quick_dine/models/api_response.dart';
import 'package:quick_dine/services/user_service.dart';
import 'package:quick_dine/views/screens/admin_kantin_page.dart';
import 'package:quick_dine/views/screens/admin_dashboard_page.dart';
import 'package:quick_dine/views/widgets/modals/login_modal.dart';

class AdminAkunPage extends StatefulWidget {
  @override
  _AdminAkunPageState createState() => _AdminAkunPageState();
}

class _AdminAkunPageState extends State<AdminAkunPage> {
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;


  Future<void> fetchUsers() async {
    String token = await getToken();
    try {
      final response = await http.get(Uri.parse('$baseURL/allUsers'),
      headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['users'] as List;
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
    final TextEditingController nameController =
        TextEditingController(text: user['name']);
    final TextEditingController emailController =
        TextEditingController(text: user['email']);
    final TextEditingController notelpController =
        TextEditingController(text: user['notelp']);

    List<String> roles = ['Mahasiswa', 'Karyawan', 'Admin'];
    String selectedRole = user['role'];
    if (!roles.contains(selectedRole)) {
    selectedRole = roles.first; // Fallback to the first role if not found
  }
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
                decoration: InputDecoration(labelText: 'Nama'),
                enabled: false,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                enabled: false,
              ),
              TextField(
                controller: notelpController,
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                enabled: false,
              ),
              SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedRole,
              items: roles.map((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                selectedRole = value!;
              },
              decoration: InputDecoration(labelText: 'Role'),
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
                  String token=await getToken();
                  final response = await http.put(
                    Uri.parse('$userURL/${user['id']}'),
                    headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer $token'
                  },
                    body: jsonEncode({
                      'role': selectedRole
                    }),
                  );

                  if (response.statusCode == 200) {
                    fetchUsers();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Role berhasil diubah'),
                  ));
                  } else {
                    throw Exception('Failed to update user');
                  }
                } catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Gagal mengubah role'),
                ));
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteModal(BuildContext context, int id) {
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
                  String token = await getToken();
                  final response = await http.delete(
                    Uri.parse('$userURL/$id'),
                    headers: {
                      'Authorization': 'Bearer $token',
                      'Accept': 'application/json',
                    },
                  );
                  if (response.statusCode == 200) {
                    fetchUsers();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('User  berhasil dihapus'),
                    ));
                  } else {
                    throw Exception('Failed to delete user');
                  }
                } catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Gagal menghapus user'),
                  ));
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
  void initState() {
    super.initState();
    fetchUsers();
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminDashboardPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Admin'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminAkunPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.store),
              title: Text('Kantin'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminKantinPage()));
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
                    DataColumn(label: Text('Nama')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Nomor Telepon')),
                    DataColumn(label: Text('Role')),
                    // DataColumn(label: Text('Foto')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: users.map((user) {
                    return DataRow(cells: [
                      DataCell(Text(user['name'])),
                      DataCell(Text(user['email'])),
                      DataCell(Text(user['notelp'])),
                      DataCell(Text(user['role'])),
                      // DataCell(
                      //   Image.network(
                      //     user['image'],
                      //     width: 50,
                      //     height: 50,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
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
