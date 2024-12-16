import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_dine/views/screens/karyawan_detail_pesanan_page.dart';
import 'package:quick_dine/views/screens/karyawan_menu_page.dart';
import 'package:quick_dine/views/screens/karyawan_dashboard_page.dart';

class KaryawanPesananPage extends StatefulWidget {
  @override
  _KaryawanPesananPageState createState() => _KaryawanPesananPageState();
}

class _KaryawanPesananPageState extends State<KaryawanPesananPage> {
  List<Map<String, dynamic>> pesanan = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPesanan();
  }

  Future<void> fetchPesanan() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/pesanan'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        setState(() {
          pesanan = data.map((item) => Map<String, dynamic>.from(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load pesanan');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<void> deletePesanan(int id) async {
  //   try {
  //     final response = await http.delete(Uri.parse('http://127.0.0.1:8000/api/pesanan/$id'));
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         pesanan.removeWhere((item) => item['id'] == id);
  //       });
  //     } else {
  //       throw Exception('Failed to delete pesanan');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void showTambahPesananModal() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Tambah Pesanan'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'ID User'),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'ID Kantin'),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Total'),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Status'),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Diantar/Diambil'),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Lokasi Pengantaran'),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Metode Pembayaran'),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Bukti Pembayaran'),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               // Handle tambah pesanan
  //             },
  //             child: Text('Tambah'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('Batal'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void showEditPesananModal(Map<String, dynamic> pesananData) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Edit Pesanan'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'ID User'),
  //                 controller: TextEditingController(text: pesananData['id_user'].toString()),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'ID Kantin'),
  //                 controller: TextEditingController(text: pesananData['id_kantin'].toString()),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Total'),
  //                 controller: TextEditingController(text: pesananData['total'].toString()),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Status'),
  //                 controller: TextEditingController(text: pesananData['status']),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Diantar/Diambil'),
  //                 controller: TextEditingController(text: pesananData['diantar_diambil']),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Lokasi Pengantaran'),
  //                 controller: TextEditingController(text: pesananData['lokasi_pengantaran']),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Metode Pembayaran'),
  //                 controller: TextEditingController(text: pesananData['metode_pembayaran']),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Bukti Pembayaran'),
  //                 controller: TextEditingController(text: pesananData['bukti_pembayaran']),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               // Handle edit pesanan
  //             },
  //             child: Text('Simpan'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('Batal'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan'),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => KaryawanDashboardPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.fastfood),
              title: Text('Menu'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KaryawanMenuPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('Pesanan'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KaryawanPesananPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: Text('Detail Pesanan'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KaryawanDetailPesananPage()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     ElevatedButton(
            //       onPressed: showTambahPesananModal,
            //       child: Text('Tambah Pesanan'),
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.green,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 16.0),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('ID User')),
                          DataColumn(label: Text('ID Kantin')),
                          DataColumn(label: Text('Total')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Diantar/Diambil')),
                          DataColumn(label: Text('Lokasi Pengantaran')),
                          DataColumn(label: Text('Metode Pembayaran')),
                          DataColumn(label: Text('Bukti Pembayaran')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: pesanan.map((item) {
                          return DataRow(cells: [
                            DataCell(Text(item['id_user'].toString())),
                            DataCell(Text(item['id_kantin'].toString())),
                            DataCell(Text(item['total'].toString())),
                            DataCell(Text(item['status'])),
                            DataCell(Text(item['diantar_diambil'])),
                            DataCell(Text(item['lok_pengantaran'])),
                            DataCell(Text(item['metode_pembayaran'])),
                            DataCell(Text(item['bukti_pembayaran'])),
                            // DataCell(
                            //   Row(
                            //     children: [
                            //       IconButton(
                            //         icon: Icon(Icons.edit, color: Colors.blue),
                            //         onPressed: () => showEditPesananModal(item),
                            //       ),
                            //       IconButton(
                            //         icon: Icon(Icons.delete, color: Colors.red),
                            //         onPressed: () => deletePesanan(item['id']),
                            //       ),
                            //     ],
                            //   ),
                            // ),
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
