import 'package:flutter/material.dart';
import 'package:quick_dine/models/api_response.dart';
import 'package:quick_dine/models/core/user.dart';
import 'package:quick_dine/services/user_service.dart';
import 'package:quick_dine/views/screens/admin_dashboard_page.dart';
import 'package:quick_dine/views/screens/karyawan_dashboard_page.dart';
import 'package:quick_dine/views/screens/page_switcher.dart';
import 'package:quick_dine/views/utils/AppColor.dart';
import 'package:quick_dine/views/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginModal extends StatefulWidget {
  @override
  _LoginModalState createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;
  bool hasError = false;
  bool validate() {
    setState(() {
      _validate();
    });
    return !hasError;
  }

  void _validate() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      hasError = true;
    } else {
      hasError = false;
    }
  }

  void _loginUser() async {
    setState(() {
      loading = true;
    });
    ApiResponse response =
        await login(emailController.text, passwordController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('idUser', user.id ?? 0);
    await pref.setString('role', user.role ?? '');
    if (user.role == 'karyawan') {
      await pref.setInt('id_kantin', user.idKantin ?? 0); // Make sure idKantin is correctly mapped
    }

    if (user.role == 'admin') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AdminDashboardPage(),
      ));
    } else if (user.role == 'mahasiswa') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => PageSwitcher(initialPageIndex: 0),
      ));
    } else if (user.role == 'karyawan') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => KaryawanDashboardPage(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Belum ada role ini'),
      ));
      return;
    } //hapus aja kali ya, soalnya cuma 3 role
  }

  void onSubmit() {
    if (validate()) {
      _loginUser();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email dan password harus diisi'),
        behavior: SnackBarBehavior.floating, // Menempatkan SnackBar di atas
        margin: EdgeInsets.only(top: 20),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 85 / 100,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            physics: BouncingScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 35 / 100,
                  margin: EdgeInsets.only(bottom: 20),
                  height: 6,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              // header
              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'inter'),
                ),
              ),
              // Form
              CustomTextField(
                  title: 'Email',
                  hint: 'youremail@email.com',
                  controller: emailController),
              CustomTextField(
                  title: 'Password',
                  hint: '**********',
                  obsecureText: true,
                  controller: passwordController,
                  margin: EdgeInsets.only(top: 16)),
              // Log in Button
              Container(
                margin: EdgeInsets.only(top: 32, bottom: 6),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: loading ? null : onSubmit,
                  child: loading
                      ? CircularProgressIndicator(color: Colors.green)
                      : Text('Login',
                          style: TextStyle(
                              color: AppColor.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'inter')),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: AppColor.primarySoft,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Forgot your password? ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'inter',
                          ),
                          text: 'Reset')
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
