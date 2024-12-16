import 'package:flutter/material.dart';
import 'package:quick_dine/models/core/ruko.dart'; // Pastikan Ruko class diimport dengan benar

class RukoDetailPage extends StatefulWidget {
  final Ruko data;
  RukoDetailPage({required this.data});

  @override
  _RukoDetailPageState createState() => _RukoDetailPageState();
}

class _RukoDetailPageState extends State<RukoDetailPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.namaRuko),
        actions: [IconButton(icon: Icon(Icons.phone), onPressed: () {
          // Function to call ruko's phone number
        })],
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          // Section 1 - Ruko Image (Placeholder used)
          GestureDetector(
            onTap: () {
              // Open image or detail view
            },
            child: Image.asset(
              'assets/images/restaurant1.jfif', // Placeholder image path
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.data.namaRuko, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Metode Pembayaran: ${widget.data.metodePembayaran}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('No. Telepon: ${widget.data.noTelp}', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
