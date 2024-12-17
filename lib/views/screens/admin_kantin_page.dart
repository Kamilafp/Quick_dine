import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_dine/models/api_response.dart';
import 'package:quick_dine/models/core/kantin.dart';
import 'package:quick_dine/services/kantin_service.dart';
import 'package:quick_dine/services/user_service.dart';
import 'package:quick_dine/views/screens/admin_akun_page.dart';
import 'package:quick_dine/views/screens/admin_dashboard_page.dart';
import 'package:quick_dine/constant.dart';

class AdminKantinPage extends StatefulWidget {
  @override
  _AdminKantinPageState createState() => _AdminKantinPageState();
}

class _AdminKantinPageState extends State<AdminKantinPage> {
  List<Map<String, dynamic>> kantins = [];
  List<Map<String, dynamic>> karyawanList = [];
  
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchKantins();
    fetchKaryawan();
  }

  Future<void> fetchKantins() async {
    try {
      final data = await fetchKantin();
      setState(() {
        kantins = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchKaryawan() async {
    try {
      final data = await fetchUser();
      print('Data yang diterima: $data');  // Cek apakah data benar-benar ada
      setState(() {
        karyawanList = data.where((user) => user['role'] == 'Karyawan').toList();
      });
    } catch (e) {
      print(e);
    }
    print('Karyawan List: $karyawanList');  // Cek data yang sudah difilter
  }

  Future<void> addKantin(String namaKantin, int idKaryawan, String metodePembayaran, String noTelp) async {
    try {
      final response = await http.post(
        Uri.parse(kantinURL),
        body: json.encode({
          'nama_kantin': namaKantin,
          'id_karyawan': idKaryawan,
          'metode_pembayaran' : metodePembayaran,
          'no_telp' : noTelp,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 201) {
        fetchKantins();
      } else {
        throw Exception('Failed to add kantin');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> editKantin(int id, String namaKantin, int idKaryawan) async {
    try {
      final response = await http.put(
        Uri.parse('$kantinURL/$id'),
        body: json.encode({
          'nama_kantin': namaKantin,
          'id_karyawan': idKaryawan,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        fetchKantins();
      } else {
        throw Exception('Failed to edit kantin');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteKantin(int id) async {
    try {
      final response = await http.delete(Uri.parse('$kantinURL/$id'));
      if (response.statusCode == 200) {
        fetchKantins();
      } else {
        throw Exception('Failed to delete kantin');
      }
    } catch (e) {
      print(e);
    }
  }

  void showAddModal() {
    final _namaKantinController = TextEditingController(),
          _metodepembayaranController = TextEditingController(),
          _notelpController = TextEditingController();
    String? selectedIdKaryawan;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tambah Kantin'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _namaKantinController,
                decoration: InputDecoration(labelText: 'Nama Kantin'),
              ),
              DropdownButtonFormField<String>(
                value: selectedIdKaryawan,
                items: karyawanList.map((karyawan) {
                  return DropdownMenuItem<String>(
                    value: karyawan['id'].toString(),
                    child: Text(karyawan['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedIdKaryawan = value;
                    print('Karyawan yang dipilih: $value');
                  });
                },
                decoration: InputDecoration(labelText: 'Karyawan'),
              ),
              TextField(
                controller: _metodepembayaranController,
                decoration: InputDecoration(labelText: 'Metode Pembayaran'),
              ),
              TextField(
                controller: _notelpController,
                decoration: InputDecoration(labelText: 'No Telepon'),
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
            onPressed: () {
              if (selectedIdKaryawan != null) {
                addKantin(
                  _namaKantinController.text,
                  int.parse(selectedIdKaryawan!),
                  _metodepembayaranController.text,
                  _notelpController.text,
                );
                Navigator.pop(context);
              } else {
                print('Pilih karyawan terlebih dahulu');
              }
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void showEditModal(BuildContext context, Map<String, dynamic> kantin) {
    final _namaKantinController = TextEditingController(text: kantin['nama_kantin']);
    String selectedIdKaryawan = kantin['id_karyawan'].toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Kantin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _namaKantinController,
              decoration: InputDecoration(labelText: 'Nama Kantin'),
            ),
            DropdownButtonFormField<String>(
                value: selectedIdKaryawan,
                items: karyawanList.map((karyawan) {
                  return DropdownMenuItem<String>(
                    value: karyawan['id'].toString(),
                    child: Text(karyawan['name']),
                  );
                }).toList(),
                onChanged: (value){
                  selectedIdKaryawan = value!;
                },
                decoration: InputDecoration(labelText: 'Karyawan')
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              editKantin(
                kantin['id'],
                _namaKantinController.text,
                int.parse(selectedIdKaryawan));
              Navigator.pop(context);
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void showDeleteModal(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Kantin'),
        content: Text('Apakah Anda yakin ingin menghapus kantin ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              deleteKantin(id);
              Navigator.pop(context);
            },
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kantin'),
        backgroundColor: const Color.fromARGB(255, 26, 161, 69),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showAddModal();
              })
        ],
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
              title: Text('Akun'),
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
          : ListView.builder(
              itemCount: kantins.length,
              itemBuilder: (context, index) {
                final kantin = kantins[index];
                return ListTile(
                  title: Text(kantin['nama_kantin']),
                  subtitle: Text(kantin['karyawan']['name']),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => showEditModal(context, kantin),
                  ),
                );
              },
            ),
    );
  }
}
