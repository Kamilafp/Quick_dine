import 'package:flutter/material.dart';
import 'package:quick_dine/models/core/kantin.dart';
import 'package:quick_dine/services/kantin_service.dart';
import 'package:quick_dine/views/screens/featured_kantin_card.dart';
import 'package:quick_dine/views/screens/menu_list_page.dart';
import 'package:quick_dine/views/screens/profile_page.dart';
import 'package:quick_dine/views/screens/ruko_list_page.dart';
import 'package:quick_dine/views/utils/AppColor.dart';
import 'package:quick_dine/views/widgets/custom_app_bar.dart';
import 'package:quick_dine/views/widgets/modals/kantin_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Kantin> kantins = [];
  List<Map<String, dynamic>> kantins = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchKantins();
  }

  Future<void> fetchKantins() async {
    try {
      final data = await fetchKantin(); // Mengambil data kantin
        setState(() {
          kantins = data; // Menyimpan data kantin
          isLoading = false;
        });
      
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }
  void navigateToMenuList(int idKantin) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MenuListPage(idKantin: idKantin)),
    );
  }

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
      body: isLoading
      ? Center(child: CircularProgressIndicator())
      : 
//       ListView(
//         shrinkWrap: true,
//         physics: BouncingScrollPhysics(),
//         children: [
//           // Section 1 - Featured Ruko - Wrapper
//           Container(
//             color: Colors.white, // Background putih untuk seluruh body
//             child: Column(
//               children: [
//                 // Delicious Today - Header
//                 Container(
//                   margin: EdgeInsets.only(top: 12),
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   width: MediaQuery.of(context).size.width,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Kantin Fakultas Teknik Unsoed',
//                         style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'inter'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => RukoListPage()));
//                         },
//                         child: Text('see all'),
//                         style: TextButton.styleFrom(
//                           foregroundColor: AppColor.primary,
//                           textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Featured Kantin - ListView
//                 Container(
//                   margin: EdgeInsets.only(top: 4),
//                   height: 220,
//                   child: 
//                   // ListView.separated(
//                     // itemCount: featuredRuko.length,
//                     // itemCount: kantins.length,
//                     // padding: EdgeInsets.symmetric(horizontal: 16),
//                     // physics: BouncingScrollPhysics(),
//                     // shrinkWrap: true,
//                     // scrollDirection: Axis.horizontal,
//                     // separatorBuilder: (context, index) {
//                     //   return SizedBox(
//                     //     width: 16,
//                     //   );
//                     // },
//                     ListView.builder(
//                       itemCount: kantins.length,
//                       itemBuilder: (context, index) {
//                       // return FeaturedRukoCard(data: featuredRuko[index]);
//                       final kantin = kantins[index];
//                       return KantinCard(kantin: kantin);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

Padding(padding: const EdgeInsets.all(16.0),
child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: kantins.length,
                itemBuilder: (context, index) {
                  final kantin = kantins[index];
                  return GestureDetector(
                    onTap: () => navigateToMenuList(kantin['id']),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              kantin['nama_kantin'],
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text('Metode Pembayaran: ${kantin['metode_pembayaran']}'),
                            Text('No Telepon: ${kantin['no_telp']}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}