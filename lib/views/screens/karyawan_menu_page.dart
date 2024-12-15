import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hungry/views/screens/karyawan_detail_pesanan_page.dart';
import 'package:hungry/views/screens/karyawan_pesanan_page.dart';
import 'package:hungry/views/screens/karyawan_dashboard_page.dart';

class KaryawanMenuPage extends StatefulWidget {
  @override
  _KaryawanMenuPageState createState() => _KaryawanMenuPageState();
}

class _KaryawanMenuPageState extends State<KaryawanMenuPage> {
  List<Map<String, dynamic>> menus = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMenus();
  }

  Future<void> fetchMenus() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/menu'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        setState(() {
          menus = data.map((item) => Map<String, dynamic>.from(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load menus');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteMenu(int id) async {
    try {
      final response = await http.delete(Uri.parse('http://127.0.0.1:8000/api/menu/$id'));
      if (response.statusCode == 200) {
        setState(() {
          menus.removeWhere((menu) => menu['id'] == id);
        });
      } else {
        throw Exception('Failed to delete menu');
      }
    } catch (e) {
      print(e);
    }
  }

  void showAddMenuModal() {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController imageController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController stockController = TextEditingController();
    TextEditingController idKantinController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tambah Menu'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nama Menu'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: imageController,
                decoration: InputDecoration(labelText: 'Gambar'),
              ),
              TextField(
                controller: stockController,
                decoration: InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: idKantinController,
                decoration: InputDecoration(labelText: 'ID Kantin'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newMenu = {
                'name': nameController.text,
                'description': descriptionController.text,
                'price': int.parse(priceController.text),
                'image': imageController.text,
                'stock': int.parse(stockController.text),
                'id_kantin': int.parse(idKantinController.text),
              };
              try {
                final response = await http.post(
                  Uri.parse('http://127.0.0.1:8000/api/menu'),
                  body: json.encode(newMenu),
                  headers: {'Content-Type': 'application/json'},
                );
                if (response.statusCode == 201) {
                  setState(() {
                    menus.add(json.decode(response.body));
                  });
                  Navigator.pop(context);
                } else {
                  throw Exception('Failed to add menu');
                }
              } catch (e) {
                print(e);
              }
            },
            child: Text('Tambah'),
          ),
        ],
      ),
    );
  }

  void showEditMenuModal(Map<String, dynamic> menu) {
    TextEditingController nameController = TextEditingController(text: menu['name']);
    TextEditingController descriptionController = TextEditingController(text: menu['description']);
    TextEditingController priceController = TextEditingController(text: menu['price'].toString());
    TextEditingController imageController = TextEditingController(text: menu['image']);
    TextEditingController stockController = TextEditingController(text: menu['stock'].toString());
    TextEditingController idKantinController = TextEditingController(text: menu['id_kantin'].toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Menu'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nama Menu'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: imageController,
                decoration: InputDecoration(labelText: 'Gambar'),
              ),
              TextField(
                controller: stockController,
                decoration: InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: idKantinController,
                decoration: InputDecoration(labelText: 'ID Kantin'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final updatedMenu = {
                'name': nameController.text,
                'description': descriptionController.text,
                'price': int.parse(priceController.text),
                'image': imageController.text,
                'stock': int.parse(stockController.text),
                'id_kantin': int.parse(idKantinController.text),
              };
              try {
                final response = await http.put(
                  Uri.parse('http://127.0.0.1:8000/api/menu/${menu['id']}'),
                  body: json.encode(updatedMenu),
                  headers: {'Content-Type': 'application/json'},
                );
                if (response.statusCode == 200) {
                  setState(() {
                    final index = menus.indexWhere((m) => m['id'] == menu['id']);
                    if (index != -1) menus[index] = json.decode(response.body);
                  });
                  Navigator.pop(context);
                } else {
                  throw Exception('Failed to update menu');
                }
              } catch (e) {
                print(e);
              }
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KaryawanDashboardPage()));
              }, // Navigate to Dashboard
            ),
            ListTile(
              leading: Icon(Icons.fastfood),
              title: Text('Menu'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KaryawanMenuPage()));
              }, // Stay on Menu Page
            ),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text('Pesanan'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KaryawanPesananPage()));
              }, // Navigate to Pesanan Page
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Detail Pesanan'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KaryawanDetailPesananPage()));
              }, // Navigate to Transaksi Page
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: showAddMenuModal,
                  child: Text('Tambah Menu'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Nama Menu')),
                          DataColumn(label: Text('Deskripsi')),
                          DataColumn(label: Text('Harga')),
                          DataColumn(label: Text('Gambar')),
                          DataColumn(label: Text('Stok')),
                          DataColumn(label: Text('ID Kantin')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: menus.map((menu) {
                          return DataRow(cells: [
                            DataCell(Text(menu['name'])),
                            DataCell(Text(menu['description'])),
                            DataCell(Text(menu['harga'])),
                            DataCell(Text(menu['image'])),
                            DataCell(Text(menu['stok'])),
                            DataCell(Text(menu['id_kantin'])),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () => showEditMenuModal(menu),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => deleteMenu(menu['id']),
                                  ),
                                ],
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
