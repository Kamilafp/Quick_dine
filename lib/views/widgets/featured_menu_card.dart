// import 'package:flutter/material.dart';
// import 'package:quick_dine/models/core/menu.dart';

// class FeaturedMenuCard extends StatefulWidget {
//   final Menu data;
//   final Function(int) onUpdateOrder; // Callback untuk memperbarui jumlah pesanan

//   FeaturedMenuCard({required this.data, required this.onUpdateOrder});

//   @override
//   _FeaturedMenuCardState createState() => _FeaturedMenuCardState();
// }

// class _FeaturedMenuCardState extends State<FeaturedMenuCard> {
//   int quantity = 0;

//   void updateQuantity(int change) {
//     setState(() {
//       quantity += change;
//     });
//     widget.onUpdateOrder(change); // Update total pesanan di halaman utama
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: Padding(
//         padding: EdgeInsets.all(8),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Gambar Menu
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.asset(
//                 widget.data.foto,
//                 width: 80,
//                 height: 80,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(width: 16),
//             // Informasi Menu
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.data.nama,
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Rp ${widget.data.harga}',
//                     style: TextStyle(fontSize: 14, color: Colors.green),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     widget.data.deskripsi,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//             // Tombol Tambah dan Kurang
//             Column(
//               children: [
//                 IconButton(
//                   onPressed: () => updateQuantity(1), // Tambah jumlah
//                   icon: Icon(Icons.add_circle, color: Colors.blue),
//                 ),
//                 if (quantity > 0)
//                   IconButton(
//                     onPressed: () => updateQuantity(-1), // Kurangi jumlah
//                     icon: Icon(Icons.remove_circle, color: Colors.red),
//                   ),
//                 Text(
//                   '$quantity',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
