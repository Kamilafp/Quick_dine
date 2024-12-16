// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:quick_dine/models/api_response.dart';
// import 'package:quick_dine/models/core/kantin.dart';
// import 'package:quick_dine/services/kantin_service.dart';
// import 'package:quick_dine/views/screens/admin_akun_page.dart';
// import 'package:quick_dine/views/screens/admin_dashboard_page.dart';
// import 'package:quick_dine/constant.dart';

// class AdminKantinPage extends StatefulWidget {
//   @override
//   _AdminKantinPageState createState() => _AdminKantinPageState();
// }

// class _AdminKantinPageState extends State<AdminKantinPage> {
//   List<Kantin> kantins = [];
//   List<Map<String, dynamic>> users = [];
  
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchKantins();
//     fetchUsers();
//   }

//   Future<void> addKantin(String namaKantin, int idKaryawan) async {
//     try {
//       final response = await http.post(
//         Uri.parse(kantinURL),
//         body: json.encode({
//           'nama_kantin': namaKantin,
//           'id_karyawan': idKaryawan,
//         }),
//         headers: {'Content-Type': 'application/json'},
//       );
//       if (response.statusCode == 201) {
//         fetchKantins();
//       } else {
//         throw Exception('Failed to add kantin');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> editKantin(int id, String namaKantin, int idKaryawan) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$kantinURL/$id'),
//         body: json.encode({
//           'nama_kantin': namaKantin,
//           'id_karyawan': idKaryawan,
//         }),
//         headers: {'Content-Type': 'application/json'},
//       );
//       if (response.statusCode == 200) {
//         fetchKantins();
//       } else {
//         throw Exception('Failed to edit kantin');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> deleteKantin(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$kantinURL/$id'));
//       if (response.statusCode == 200) {
//         fetchKantins();
//       } else {
//         throw Exception('Failed to delete kantin');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   void showAddModal() {
//     final _namaKantinController = TextEditingController();
//     final _idKaryawanController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Tambah Kantin'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _namaKantinController,
//               decoration: InputDecoration(labelText: 'Nama Kantin'),
//             ),
//             TextField(
//               controller: _idKaryawanController,
//               decoration: InputDecoration(labelText: 'ID Karyawan'),
//               keyboardType: TextInputType.number,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Batal'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               addKantin(
//                 _namaKantinController.text,
//                 int.parse(_idKaryawanController.text),
//               );
//               Navigator.pop(context);
//             },
//             child: Text('Simpan'),
//           ),
//         ],
//       ),
//     );
//   }

//   void showEditModal(Map<String, dynamic> kantin) {
//     final _namaKantinController = TextEditingController(text: kantin['nama_kantin']);
//     final _idKaryawanController = TextEditingController(text: kantin['id_karyawan'].toString());

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Edit Kantin'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _namaKantinController,
//               decoration: InputDecoration(labelText: 'Nama Kantin'),
//             ),
//             TextField(
//               controller: _idKaryawanController,
//               decoration: InputDecoration(labelText: 'ID Karyawan'),
//               keyboardType: TextInputType.number,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Batal'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               editKantin(
//                 kantin['id'],
//                 _namaKantinController.text,
//                 int.parse(_idKaryawanController.text),
//               );
//               Navigator.pop(context);
//             },
//             child: Text('Simpan'),
//           ),
//         ],
//       ),
//     );
//   }

//   void showDeleteModal(int id) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Hapus Kantin'),
//         content: Text('Apakah Anda yakin ingin menghapus kantin ini?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Batal'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               deleteKantin(id);
//               Navigator.pop(context);
//             },
//             child: Text('Hapus'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Kantin'),
//         backgroundColor: Colors.green,
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.green,
//               ),
//               child: Text(
//                 'Menu',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.dashboard),
//               title: Text('Dashboard'),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboardPage()));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.admin_panel_settings),
//               title: Text('Admin'),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => AdminAkunPage()));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.store),
//               title: Text('Kantin'),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => AdminKantinPage()));
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                   onPressed: showAddModal,
//                   child: Text('Tambah Kantin'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.0),
//             Expanded(
//               child: isLoading
//                   ? Center(child: CircularProgressIndicator())
//                   : SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         columns: [
//                           DataColumn(label: Text('Nama Kantin')),
//                           DataColumn(label: Text('ID Karyawan')),
//                           DataColumn(label: Text('Actions')),
//                         ],
//                         rows: kantins.map((kantin) {
//                           return DataRow(cells: [
//                             DataCell(Text(kantin['nama_kantin'])),
//                             DataCell(Text(kantin['id_karyawan'].toString())),
//                             DataCell(
//                               Row(
//                                 children: [
//                                   IconButton(
//                                     icon: Icon(Icons.edit, color: Colors.blue),
//                                     onPressed: () => showEditModal(kantin),
//                                   ),
//                                   IconButton(
//                                     icon: Icon(Icons.delete, color: Colors.red),
//                                     onPressed: () => showDeleteModal(kantin['id']),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ]);
//                         }).toList(),
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
