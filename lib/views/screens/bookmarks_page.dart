import 'package:flutter/material.dart';
import 'package:hungry/models/helper/pesanan_helper.dart';
import 'package:hungry/models/core/pesanan.dart';
import 'package:hungry/views/widgets/custom_app_bar.dart';
import 'package:hungry/views/screens/profile_page.dart';

class BookmarksPage extends StatefulWidget {
  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  List<Order> orders = OrderHelper.contohOrder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          title: Text(
            'QuickDine',
            style: TextStyle(color: Colors.white, fontFamily: 'inter', fontWeight: FontWeight.w700),
          ),
          showProfilePhoto: true,
          profilePhoto: AssetImage('assets/images/profile.jfif'),
          profilePhotoOnPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
          },
        ),
      ),
      body: Column(
        children: [
          // Section Header: Pesanan
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              'Pesanan',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'inter',
              ),
            ),
          ),
          // List of Orders
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                itemCount: orders.length,
                padding: EdgeInsets.all(16),
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name and Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order.produk,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'inter',
                              ),
                            ),
                            Text(
                              order.status == 'completed' ? 'Selesai' : 'Pending',
                              style: TextStyle(
                                color: order.status == 'completed' ? Colors.green : Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        // Order Details
                        Text(
                          'Jumlah: ${order.jumlah}',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'inter',
                          ),
                        ),
                        Text(
                          'Catatan: ${order.catatan}',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'inter',
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        // Transaction ID
                        Text(
                          'ID Transaksi: ${order.idTransaksi}',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'inter',
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
