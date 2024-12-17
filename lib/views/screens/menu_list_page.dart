import 'package:flutter/material.dart';
import 'package:quick_dine/models/api_response.dart';
import 'package:quick_dine/models/core/menu.dart';
import 'package:quick_dine/services/menu_service.dart';
import 'package:quick_dine/views/widgets/featured_menu_card.dart';

class MenuListPage extends StatefulWidget {
  final int idKantin;

  MenuListPage({required this.idKantin});

  @override
  _MenuListPageState createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  int totalOrders = 0;
  Map<Menu, int> orderDetails = {}; // Menyimpan menu dan jumlah pesanannya
  List<Menu> menuList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMenu();
  }

  Future<void> fetchMenu() async {
    ApiResponse apiResponse = await getAllMenu(widget.idKantin);
    if (apiResponse.error == null) {
      setState(() {
        menuList = apiResponse.data as List<Menu>;
        isLoading = false;
      });
    } else {
      print(apiResponse.error);
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateOrder(Menu menu, int change) {
    setState(() {
      totalOrders += change;
      orderDetails.update(
        menu,
        (value) => value + change,
        ifAbsent: () => change,
      );
      if (orderDetails[menu] == 0) {
        orderDetails.remove(menu); // Hapus menu dari daftar jika jumlahnya 0
      }
    });
  }

  void showOrderDetails() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Detail Pesanan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              ...orderDetails.entries.map((entry) {
                final menu = entry.key;
                final quantity = entry.value;
                return ListTile(
                  title: Text(menu.nama),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jumlah: $quantity'),
                      Text('Total: Rp ${menu.harga * quantity}'),
                    ],
                  ),
                );
              }).toList(),
              Divider(),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Total: Rp ${orderDetails.entries.fold<int>(0, (sum, entry) => sum + (entry.key.harga * entry.value))}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: showOrderDetails,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : menuList.isEmpty
              ? Center(child: Text('Belum ada menu untuk kantin ini.'))
              : ListView.builder(
                  itemCount: menuList.length,
                  itemBuilder: (context, index) {
                    return FeaturedMenuCard(
                      data: menuList[index],
                      onUpdateOrder: (change) => updateOrder(menuList[index], change),
                    );
                  },
                ),
    );
  }
}

// class MenuListPage extends StatelessWidget {
//   final int idKantin;

//   MenuListPage({required this.idKantin});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Menu Kantin'),
//       ),
//       body: FutureBuilder(
//         future: fetchMenu(idKantin),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final menuList = snapshot.data!;
//             return ListView.builder(
//               itemCount: menuList.length,
//               itemBuilder: (context, index) {
//                 final menu = menuList[index];
//                 return ListTile(
//                   title: Text(menu['nama_menu']),
//                   subtitle: Text('Harga: ${menu['harga']}'),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class MenuListPage extends StatefulWidget {
//   final int idKantin;

//   MenuListPage({required this.idKantin});

//   @override
//   _MenuListPageState createState() => _MenuListPageState();
// }

// class _MenuListPageState extends State<MenuListPage> {
//   int totalOrders = 0;
//   Map<Menu, int> orderDetails = {}; // Menyimpan menu dan jumlah pesanannya
//   List<Menu> menuList = [];
//   String namaKantin='';

//   bool isLoading = true;

//   void updateOrder(Menu menu, int change) {
//     setState(() {
//       totalOrders += change;
//       orderDetails.update(
//         menu,
//         (value) => value + change,
//         ifAbsent: () => change,
//       );
//       if (orderDetails[menu] == 0) {
//         orderDetails.remove(menu); // Hapus menu dari daftar jika jumlahnya 0
//       }
//     });
//   }
//   void showOrderDetails() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Detail Pesanan',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               Divider(),
//               ...orderDetails.entries.map((entry) {
//                 final menu = entry.key;
//                 final quantity = entry.value;
//                 return ListTile(
//                   title: Text(menu.nama),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Jumlah: $quantity'),
//                       Text('Total: Rp ${menu.harga * quantity}'),
//                     ],
//                   ),
//                 );
//               }).toList(),
//               Divider(),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   'Total: Rp ${orderDetails.entries.fold<int>(0, (sum, entry) => sum + ((entry.key.harga?? 0) * (entry.value ?? 0)))}',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override 
//   void initState(){
//     super.initState();
//     fetchMenu();
//   }

//   Future<void> fetchMenu() async {
//     ApiResponse apiResponse = await getAllMenu(widget.idKantin);
//     if (apiResponse.error == null) {
//       setState(() {
//         menuList = (apiResponse.data as List).map((item)=>Menu.fromJson(item)).toList();
//         isLoading = false;
//       });
//     } else {
//       print(apiResponse.error);
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Daftar Menu'),
//       ),
//       body: 
//       // Column(
//       //   children: [
//       //     // List Menu
//       //     Expanded(
//       isLoading ? Center(child: CircularProgressIndicator()) : menuList.isEmpty
//                 ? Center(
//                     child: Text('Belum ada menu untuk kantin ini.'),
//                   )
//                 : 
//                 // Column(
//                 //   children: [
//                 //     Expanded(
//                 //       child: 
//                       ListView.builder(
//                     itemCount: menuList.length,
//                     // padding: EdgeInsets.symmetric(vertical: 10),
//                     itemBuilder: (context, index) {
//                       return FeaturedMenuCard(
//                         data: menuList[index],
//                         onUpdateOrder: (change) =>
//                             updateOrder(menuList[index], change),
//                       );
//                     },
//     //               ),
//     //                 ),
//     //       // Total Pesanan
//     //       InkWell(
//     //         onTap: () => showOrderDetails(),
//     //         child: Container(
//     //           color: Colors.grey.shade200,
//     //           padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//     //           child: Row(
//     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //             children: [
//     //               Text(
//     //                 'Total Pesanan:',
//     //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//     //               ),
//     //               Text(
//     //                 '$totalOrders',
//     //                 style: TextStyle(fontSize: 16, color: Colors.blue),
//     //               ),
//     //             ],
//     //           ),
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   ));}
// }
