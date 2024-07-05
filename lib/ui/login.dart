import 'package:klinik_app/service/login_service.dart';
import 'package:klinik_app/ui/beranda.dart';
import 'package:flutter/material.dart';

// Widget Stateful untuk halaman login
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Kunci form untuk validasi
  final formKey = GlobalKey<FormState>();

  // Controller untuk mengelola input teks
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Scaffold untuk struktur dasar halaman
    return Scaffold(
      body: SingleChildScrollView(
        // SafeArea untuk menghindari area notifikasi dan status bar
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Judul halaman login
                const Text(
                  'Login Admin',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                Center(
                  child: Form(
                    key: formKey, // Kunci form untuk validasi
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        children: [
                          // Field untuk input username
                          usernameTextField(),
                          const SizedBox(height: 20),
                          // Field untuk input password
                          passwordTextField(),
                          const SizedBox(height: 40),
                          // Tombol untuk login
                          tombolLogin()
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk field input username
  Widget usernameTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Username'),
      controller: usernameCtrl,
    );
  }

  // Widget untuk field input password
  Widget passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true, // Menyembunyikan teks password
      controller: passwordCtrl,
    );
  }

  // Widget untuk tombol login
  Widget tombolLogin() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        // Aksi yang dilakukan saat tombol ditekan
        onPressed: () async {
          // Mengambil nilai input dari controller
          String username = usernameCtrl.text;
          String password = passwordCtrl.text;

          // Memanggil service login dan menunggu hasilnya
          await LoginService().login(username, password).then((isLogin) {
            if (isLogin) {
              // Jika login berhasil, navigasi ke halaman beranda
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Beranda(),
                ),
              );
            } else {
              // Jika login gagal, tampilkan dialog notifikasi
              AlertDialog alertDialog = AlertDialog(
                content: const Text(
                  "Username & Password Salah!",
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              );

              showDialog(context: context, builder: (context) => alertDialog);
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        child: const Text('Login'),
      ),
    );
  }
}
