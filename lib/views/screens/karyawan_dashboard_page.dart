import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_dine/services/detail_pesanan_service.dart';
import 'package:quick_dine/services/menu_service.dart';
import 'package:quick_dine/services/pesanan_service.dart';
import 'package:quick_dine/views/screens/karyawan_pesanan_page.dart';
import 'package:quick_dine/views/screens/karyawan_menu_page.dart';
import 'package:quick_dine/views/screens/karyawan_detail_pesanan_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KaryawanDashboardPage extends StatefulWidget {
  @override
  _KaryawanDashboardPageState createState() => _KaryawanDashboardPageState();
}

class _KaryawanDashboardPageState extends State<KaryawanDashboardPage> {
  int totalMenu = 0;
  int totalPesanan = 0;
  // int totalDetailPesanan = 0;
  bool isLoading = true;
  int? idKantin;

  @override
  void initState() {
    super.initState();
    _getIdKantin();
  }

  Future<void> _getIdKantin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idKantin = pref.getInt('id_kantin');  // Ambil id_kantin
    });
    if (idKantin != null) {
      fetchData();  // Hanya panggil fetchData jika id_kantin tersedia
    }
  }

  Future<void> fetchData() async {
    if (idKantin == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      totalMenu = await getTotalMenu(idKantin!);  // Mengambil data berdasarkan id_kantin
      totalPesanan = await getTotalPesanan(idKantin!);
      // totalDetailPesanan = await getTotalDetailPesanan(idKantin!);
      setState(() {
        isLoading = false;
      });
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KaryawanDashboardPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.restaurant_menu),
              title: Text('Menu'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KaryawanMenuPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text('Pesanan'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KaryawanPesananPage()));
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.list_alt),
            //   title: Text('Detail Pesanan'),
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => KaryawanDetailPesananPage()));
            //   },
            // ),
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
            _buildCard(title: 'Jumlah Menu', count: totalMenu.toString()),
            SizedBox(height: 16),
            _buildCard(title: 'Jumlah Pesanan', count: totalPesanan.toString()),
            // SizedBox(height: 16),
            // _buildCard(title: 'Detail Pesanan', count: totalDetailPesanan.toString()),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat card yang serupa dengan AdminDashboard
  Widget _buildCard({required String title, required String count}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xFFF8F4FF), // Warna ungu muda
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              count,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
