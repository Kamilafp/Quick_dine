import 'package:flutter/material.dart';
import 'package:hungry/models/core/menu.dart';
import 'package:hungry/models/helper/menu_helper.dart';
import 'package:hungry/views/widgets/featured_menu_card.dart';

class MenuListPage extends StatefulWidget {
  final String idRuko;

  MenuListPage({required this.idRuko});

  @override
  _MenuListPageState createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  int totalOrders = 0;
  Map<Menu, int> orderDetails = {}; // Menyimpan menu dan jumlah pesanannya

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
                  'Total: Rp ${orderDetails.entries.fold<int>(0, (sum, entry) => sum + ((entry.key.harga.toInt() ?? 0) * (entry.value ?? 0)))}',
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
    List<Menu> menuList = MenuHelper.getMenuByRukoId(int.parse(widget.idRuko));

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Menu'),
      ),
      body: Column(
        children: [
          // List Menu
          Expanded(
            child: menuList.isEmpty
                ? Center(
                    child: Text('Belum ada menu untuk ruko ini.'),
                  )
                : ListView.builder(
                    itemCount: menuList.length,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      return FeaturedMenuCard(
                        data: menuList[index],
                        onUpdateOrder: (change) =>
                            updateOrder(menuList[index], change),
                      );
                    },
                  ),
          ),
          // Total Pesanan
          InkWell(
            onTap: () => showOrderDetails(),
            child: Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Pesanan:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$totalOrders',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
