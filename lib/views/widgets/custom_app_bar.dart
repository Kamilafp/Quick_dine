import 'package:flutter/material.dart';
import 'package:quick_dine/services/user_service.dart';
import 'package:quick_dine/views/screens/auth/welcome_page.dart';
import 'package:quick_dine/views/utils/AppColor.dart';
import 'package:flutter/services.dart';
import 'package:quick_dine/views/widgets/modals/login_modal.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool showProfilePhoto;
  final ImageProvider? profilePhoto;
  final VoidCallback? profilePhotoOnPressed;

  CustomAppBar({required this.title, required this.showProfilePhoto, this.profilePhoto, this.profilePhotoOnPressed});

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: AppColor.primary,
      title: title,
      elevation: 0,
      actions: [
        IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              logout().then((value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                        (route) => false)
                  });
            },
          ),
        Visibility(
          visible: showProfilePhoto,
          child: Container(
            margin: EdgeInsets.only(right: 16),
            alignment: Alignment.center,
            child: IconButton(
              onPressed: profilePhotoOnPressed ?? () {},
              icon: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  image: DecorationImage(image: profilePhoto ?? AssetImage('assets/profile.png'), fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
