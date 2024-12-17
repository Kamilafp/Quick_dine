// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:quick_dine/views/screens/menu_list_page.dart'; // Import halaman MenuListPage
// import 'package:quick_dine/models/core/ruko.dart'; // Model Ruko
//
// class FeaturedRukoCard extends StatelessWidget {
//   final Ruko data; // Data ruko yang akan ditampilkan
//
//   FeaturedRukoCard({required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Navigasi ke MenuListPage dengan mengoper idRuko
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => MenuListPage(idRuko: data.id),
//         ));
//       },
//       child: Container(
//         width: 180,
//         height: 220,
//         alignment: Alignment.bottomCenter,
//         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           image: DecorationImage(
//             image: AssetImage(data.gambarRuko), // Gambar ruko dari properti data
//             fit: BoxFit.cover, // Mengatur agar gambar sesuai dengan ukuran card
//           ),
//         ),
//         // Informasi Ruko
//         child: ClipRect(
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
//             child: Container(
//               height: 80,
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 color: Colors.black.withOpacity(0.26),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Nama Ruko
//                   Text(
//                     data.namaRuko, // Nama dari ruko
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       height: 1.5,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'inter',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
