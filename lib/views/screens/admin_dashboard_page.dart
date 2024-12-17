import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_dine/constant.dart';
import 'package:quick_dine/services/kantin_service.dart';
import 'package:quick_dine/services/user_service.dart';
import 'package:quick_dine/views/screens/admin_akun_page.dart';
import 'package:quick_dine/views/screens/admin_kantin_page.dart';
import 'package:quick_dine/views/screens/auth/welcome_page.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int totalUser = 0;
  int totalKantin = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      totalUser = await getTotalUser();
      totalKantin = await getTotalkantin();
      setState(() {
        isLoading=false;
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
        title: Text('Admin Dashboard'),
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
            ListTile(
              leading: Icon(Icons.exit_to_app_outlined, color:Colors.red),
              title: Text('Logout'),
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
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jumlah Akun',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            totalUser.toString(),
                            style: TextStyle(fontSize: 24, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jumlah Kantin',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            totalKantin.toString(),
                            style: TextStyle(fontSize: 24, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
