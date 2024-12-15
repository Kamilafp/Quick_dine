import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hungry/views/screens/karyawan_pesanan_page.dart';
import 'package:hungry/views/screens/karyawan_menu_page.dart';
import 'package:hungry/views/screens/karyawan_detail_pesanan_page.dart';

class KaryawanDashboardPage extends StatefulWidget {
  @override
  _KaryawanDashboardPageState createState() => _KaryawanDashboardPageState();
}

class _KaryawanDashboardPageState extends State<KaryawanDashboardPage> {
  int totalMenu = 0;
  int totalPesanan = 0;
  int totalDetailPesanan = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final menuResponse = await http.get(Uri.parse('http://127.0.0.1:8000/api/menu'));
      final pesananResponse = await http.get(Uri.parse('http://127.0.0.1:8000/api/pesanan'));
      final detailPesananResponse = await http.get(Uri.parse('http://127.0.0.1:8000/api/detail-pesanan'));

      if (menuResponse.statusCode == 200 &&
          pesananResponse.statusCode == 200 &&
          detailPesananResponse.statusCode == 200) {
        setState(() {
          totalMenu = json.decode(menuResponse.body).length;
          totalPesanan = json.decode(pesananResponse.body).length;
          totalDetailPesanan = json.decode(detailPesananResponse.body).length;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
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
        title: Text('Dashboard Karyawan'),
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
                        builder: (context) => KaryawanDashboardPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.restaurant_menu),
              title: Text('Menu'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KaryawanMenuPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text('Pesanan'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KaryawanPesananPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('Detail Pesanan'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KaryawanDetailPesananPage()));
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCard(
                        title: 'Jumlah Menu',
                        count: totalMenu.toString(),
                        color: Colors.blueAccent,
                      ),
                      _buildCard(
                        title: 'Jumlah Pesanan',
                        count: totalPesanan.toString(),
                        color: Colors.orangeAccent,
                      ),
                      _buildCard(
                        title: 'Detail Pesanan',
                        count: totalDetailPesanan.toString(),
                        color: Colors.greenAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildCard({required String title, required String count, required Color color}) {
    return Card(
      color: color,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 150,
        height: 120,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              count,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
