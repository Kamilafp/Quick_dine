// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:quick_dine/models/core/menu.dart';

// class MenuDetailPage extends StatefulWidget {
//   final Menu data;
//   MenuDetailPage({required this.data});

//   @override
//   _MenuDetailPageState createState() => _MenuDetailPageState();
// }

// class _MenuDetailPageState extends State<MenuDetailPage> with TickerProviderStateMixin {
//   late TabController _tabController;
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _scrollController = ScrollController();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.data.nama),
//         actions: [IconButton(icon: Icon(Icons.favorite_border), onPressed: () {})],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Function to add menu to cart
//         },
//         child: Icon(Icons.add_shopping_cart),
//       ),
//       body: ListView(
//         controller: _scrollController,
//         children: [
//           // Section 1 - Menu Image and Info
//           GestureDetector(
//             onTap: () {
//               // Open image in full screen
//             },
//             child: Image.asset(widget.data.foto, fit: BoxFit.cover),
//           ),
//           Container(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(widget.data.nama, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 8),
//                 Text('Harga: ${widget.data.harga}', style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 8),
//                 // Row(
//                 //   children: [
//                 //     Icon(Icons.star, size: 20, color: Colors.orange),
//                 //     // Text('${widget.data.rating} / 5', style: TextStyle(fontSize: 16)),
//                 //   ],
//                 // ),
//                 SizedBox(height: 16),
//                 Text('Deskripsi: ${widget.data.deskripsi}'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
