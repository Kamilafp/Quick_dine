import 'package:quick_dine/models/core/pesanan.dart';

class OrderHelper {
  // Metode untuk mengonversi JSON ke objek Order
  static Order fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      idRuko: json['idRuko'] ?? '',
      idUser: json['idUser'] ?? '',
      idTransaksi: json['idTransaksi'] ?? '',
      produk: json['produk'] ?? '',
      jumlah: json['jumlah'] ?? 0,
      status: json['status'] ?? '',
      catatan: json['catatan'] ?? '',
    );
  }

  // Metode untuk mengonversi objek Order ke Map
  static Map<String, dynamic> toMap(Order order) {
    return {
      'id': order.id,
      'idRuko': order.idRuko,
      'idUser': order.idUser,
      'idTransaksi': order.idTransaksi,
      'produk': order.produk,
      'jumlah': order.jumlah,
      'status': order.status,
      'catatan': order.catatan,
    };
  }

  // Metode untuk mengonversi daftar JSON ke daftar objek Order
  static List<Order> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }

  // Metode untuk mengonversi daftar objek Order ke daftar Map
  static List<Map<String, dynamic>> listToMap(List<Order> orderList) {
    return orderList.map((order) => toMap(order)).toList();
  }

  // Mendapatkan daftar pesanan berdasarkan idRuko
  static List<Order> getOrdersByRukoId(int idRuko) {
    List<Order> allOrders = contohOrder();
    print('ID Ruko diterima: $idRuko');
    print('Semua Pesanan: ${allOrders.map((order) => order.toJson()).toList()}');
    
    var filteredOrders = allOrders.where((order) => order.idRuko.toString() == idRuko.toString()).toList();
    print('Filtered Orders: ${filteredOrders.map((order) => order.toJson()).toList()}');
    
    return filteredOrders;
  }

  // Menambahkan contoh data pesanan
  static List<Order> contohOrder() {
    List<Map<String, dynamic>> jsonList = [
      {
        'id': '1',
        'idRuko': '1',
        'idUser': '501',
        'idTransaksi': 'TX12345',
        'produk': 'Nasi Goreng',
        'jumlah': 2,
        'status': 'pending',
        'catatan': 'Tidak terlalu pedas',
      },
      {
        'id': '2',
        'idRuko': '2',
        'idUser': '502',
        'idTransaksi': 'TX12346',
        'produk': 'Mie Goreng',
        'jumlah': 1,
        'status': 'completed',
        'catatan': 'Tambahkan ayam',
      },
    ];

    return listFromJson(jsonList);
  }
}
