import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_dine/services/user_service.dart';
import 'package:quick_dine/views/screens/auth/welcome_page.dart';
import 'package:quick_dine/views/screens/karyawan_detail_pesanan_page.dart';
import 'package:quick_dine/views/screens/karyawan_pesanan_page.dart';
import 'package:quick_dine/views/screens/karyawan_dashboard_page.dart';
import 'package:quick_dine/constant.dart';
import 'package:quick_dine/models/api_response.dart';
import 'package:quick_dine/services/menu_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


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
    fetchMenu();
  }

  void fetchMenu() async {
    int idKantin = 1; // ID Kantin, bisa didapat dari state atau SharedPreferences
    ApiResponse response = await getAllMenu(idKantin);

    if (response.error == null) {
      print("Menu List: ${response.data}");
    } else {
      print("Error: ${response.error}");
    }
  }

  void fetchTotalMenu() async {
    int idKantin = 1; // ID Kantin
    try {
      int totalMenu = await getTotalMenu(idKantin);
      print("Total Menu: $totalMenu");
    } catch (e) {
      print("Error fetching total menu: $e");
    }
  }

  void showDeleteModal(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus Menu'),
          content: Text('Apakah Anda yakin menghapus menu ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  String token = await getToken();
                  final response = await http.delete(
                    Uri.parse('$menuURL/$id'),
                    headers: {
                      'Authorization': 'Bearer $token',
                      'Accept': 'application/json',
                    },
                  );
                  if (response.statusCode == 200) {
                    fetchMenu();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Menu  berhasil dihapus'),
                    ));
                  } else {
                    throw Exception('Failed to delete menu');
                  }
                } catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Gagal menghapus menu'),
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

  void showAddMenuModal() {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController stockController = TextEditingController();
    TextEditingController idKantinController = TextEditingController();

    File? imageFile;

    Future<void> pickImage() async {
      final pickedFile =
      await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });
      }
    }

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
                controller: stockController,
                decoration: InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: idKantinController,
                decoration: InputDecoration(labelText: 'ID Kantin'),
              ),
              SizedBox(height: 16),
              imageFile == null
                  ? Text('Belum ada gambar yang dipilih.')
                  : Image.file(imageFile!, height: 100, width: 100),
              ElevatedButton.icon(
                onPressed: pickImage,
                icon: Icon(Icons.upload),
                label: Text('Upload Gambar'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
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
              if (imageFile != null) {
                // Contoh penggunaan gambar (Anda perlu mengunggahnya ke server nanti)
                final newMenu = {
                  'nama_menu': nameController.text,
                  'deskripsi': descriptionController.text,
                  'harga': int.parse(priceController.text),
                  'image': 'dummy_image_path', // Handle upload gambar ke API
                  'stok': int.parse(stockController.text),
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
              } else {
                print("Pilih gambar terlebih dahulu!");
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
                'nama_menu': nameController.text,
                'deskripsi': descriptionController.text,
                'harga': int.parse(priceController.text),
                'image': imageController.text,
                'stok': int.parse(stockController.text),
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
            ListTile(
              leading: Icon(Icons.exit_to_app_outlined, color:Colors.red),
              title: Text('Logout',style: TextStyle(color: (Colors.red))),
              onTap: (){
            logout().then((value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                        (route) => false)
                  });
              }
            )
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
                            DataCell(Text('${menu['nama_menu']}')),
                            DataCell(Text('${menu['deskripsi']}')),
                            DataCell(Text('${menu['harga']}')),
                            DataCell(Text('${menu['image']}')),
                            DataCell(Text('${menu['stok']}')),
                            DataCell(Text('${menu['id_kantin']}')),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () => showEditMenuModal(menu),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {showDeleteModal(context, menu['id']);},
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
