import 'package:flutter/material.dart';
import 'package:quick_dine/services/user_service.dart';
import 'package:quick_dine/views/screens/auth/welcome_page.dart';
import 'package:quick_dine/views/screens/profile_page.dart';
import 'package:quick_dine/views/utils/AppColor.dart';
import 'package:quick_dine/views/widgets/custom_app_bar.dart';
import 'package:quick_dine/models/core/ruko.dart';
import 'package:quick_dine/models/helper/ruko_helper.dart';
import 'package:quick_dine/views/widgets/featured_ruko_card.dart';
import 'package:quick_dine/views/screens/ruko_list_page.dart';

class HomePage extends StatelessWidget {
  final List<Ruko> featuredRuko = RukoHelper.contohRuko();

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
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // Section 1 - Featured Ruko - Wrapper
          Container(
            color: Colors.white, // Background putih untuk seluruh body
            child: Column(
              children: [
                // Delicious Today - Header
                Container(
                  margin: EdgeInsets.only(top: 12),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kantin Fakultas Teknik Unsoed',
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'inter'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RukoListPage()));
                        },
                        child: Text('see all'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColor.primary,
                          textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                // Featured Ruko - ListView
                Container(
                  margin: EdgeInsets.only(top: 4),
                  height: 220,
                  child: ListView.separated(
                    itemCount: featuredRuko.length,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 16,
                      );
                    },
                    itemBuilder: (context, index) {
                      return FeaturedRukoCard(data: featuredRuko[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
