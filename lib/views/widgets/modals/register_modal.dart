import 'package:flutter/material.dart';
import 'package:quick_dine/models/api_response.dart';
import 'package:quick_dine/models/core/user.dart';
import 'package:quick_dine/services/user_service.dart';
import 'package:quick_dine/views/screens/home_page.dart';
import 'package:quick_dine/views/screens/page_switcher.dart';
import 'package:quick_dine/views/utils/AppColor.dart';
import 'package:quick_dine/views/widgets/custom_text_field.dart';
import 'package:quick_dine/views/widgets/modals/login_modal.dart';
import 'package:quick_dine/views/screens/karyawan_dashboard_page.dart';
import 'package:quick_dine/views/screens/admin_dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterModal extends StatefulWidget {
  _RegisterModalState createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      passwordConfirmController = TextEditingController(),
      notelpController = TextEditingController(),
      namaController = TextEditingController();

  bool loading = false;
  bool hasError = false;

  String? harusIsi;
  String? passwordMin;
  String? passwordMatch;

  bool validate() {
    setState(() {
      harusIsi = null;
      passwordMin = null;
      passwordMatch = null;
      hasError = false;

      if (emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          notelpController.text.isEmpty ||
          namaController.text.isEmpty ||
          passwordConfirmController.text.isEmpty) {
        harusIsi = 'Semua field harus diisi';
        hasError = true;
      }
      if (passwordController.text.length < 6) {
        passwordMin = 'Password minimal 6 karakter';
        hasError = true;
      }
      if (hasError) {
        String errorMsg = harusIsi ?? passwordMin ?? passwordMatch ?? '';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating, // Menempatkan SnackBar di atas
            margin: EdgeInsets.only(top: 20),
          ),
        );
      } else {
        hasError = false;
      }
    });
    return !hasError;
  }

  void _validate() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      hasError = true;
    }
    if (passwordController.text.length < 6) {
      hasError = true;
    }
    if (passwordController.text != passwordConfirmController.text) {
      passwordMatch = 'Password harus sama';
    } else {
      hasError = false;
    }
  }

  void _registerUser() async {
    setState(() {
      loading = true;
    });
    ApiResponse response = await register(
        namaController.text,
        emailController.text,
        passwordController.text,
        notelpController.text,
        'Mahasiswa');
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

    if (user.role == 'admin'||user.role == 'Mdmin') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AdminDashboardPage(),
      ));
    } else if (user.role == 'mahasiswa'||user.role == 'Mahasiswa') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage()
      ));
    } else if (user.role == 'karyawan'||user.role == 'Karyawan') {
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
      _registerUser();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email dan password harus diisi')));
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
                  'Get Started',
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
                  hint: 'emailanda@email.com',
                  controller: emailController),
              CustomTextField(
                  title: 'Nama Lengkap',
                  hint: 'Nama Lengkap Anda',
                  controller: namaController,
                  margin: EdgeInsets.only(top: 16)),
              CustomTextField(
                  title: 'Password',
                  hint: '**********',
                  obsecureText: true,
                  controller: passwordController,
                  margin: EdgeInsets.only(top: 16)),
              CustomTextField(
                  title: 'Konfirmasi Password',
                  hint: '**********',
                  obsecureText: true,
                  controller: passwordConfirmController,
                  margin: EdgeInsets.only(top: 16)),
              CustomTextField(
                  title: 'Nomor Telepon',
                  hint: '081234567891',
                  controller: notelpController),
              // Register Button
              Container(
                margin: EdgeInsets.only(top: 32, bottom: 6),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: loading ? null : onSubmit,
                  child: loading
                      ? CircularProgressIndicator(color: Colors.green)
                      : Text('Register',
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
              // Login textbutton
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    isScrollControlled: true,
                    builder: (context) {
                      return LoginModal();
                    },
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Have an account? ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'inter',
                          ),
                          text: 'Log in')
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
