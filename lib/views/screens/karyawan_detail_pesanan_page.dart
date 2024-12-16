import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_dine/views/screens/karyawan_pesanan_page.dart';
import 'package:quick_dine/views/screens/karyawan_menu_page.dart';
import 'package:quick_dine/views/screens/karyawan_dashboard_page.dart';

class KaryawanDetailPesananPage extends StatefulWidget {
  @override
  _KaryawanDetailPesananPageState createState() => _KaryawanDetailPesananPageState();
}

class _KaryawanDetailPesananPageState extends State<KaryawanDetailPesananPage> {
  List<Map<String, dynamic>> detailPesanan = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDetailPesanan();
  }

  Future<void> fetchDetailPesanan() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/detail_pesanan'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        setState(() {
          detailPesanan = data.map((item) => Map<String, dynamic>.from(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load detail pesanan');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
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
              leading: Icon(Icons.menu_book),
              title: Text('Menu'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KaryawanMenuPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Pesanan'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KaryawanPesananPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.details),
              title: Text('Detail Pesanan'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => KaryawanDetailPesananPage()),
                );
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
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('ID Pesanan')),
                          DataColumn(label: Text('ID Menu')),
                          DataColumn(label: Text('Jumlah')),
                          DataColumn(label: Text('Sub Total')),
                        ],
                        rows: detailPesanan.map((detail) {
                          return DataRow(cells: [
                            DataCell(Text(detail['id_pesanan'].toString())),
                            DataCell(Text(detail['id_menu'].toString())),
                            DataCell(Text(detail['jumlah'].toString())),
                            DataCell(Text(detail['sub_total'].toString())),
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
