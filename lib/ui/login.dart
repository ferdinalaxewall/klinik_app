import 'package:klinik_app/service/login_service.dart';
import 'package:klinik_app/ui/beranda.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login Admin',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              Center(
                child: Form(
                  key: formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Column(
                      children: [
                        usernameTextField(),
                        const SizedBox(height: 20),
                        passwordTextField(),
                        const SizedBox(height: 40),
                        tombolLogin()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget usernameTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Username'),
      controller: usernameCtrl,
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
      controller: passwordCtrl,
    );
  }

  Widget tombolLogin() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: const Text('Login'),
        onPressed: () async {
          String username = usernameCtrl.text;
          String password = passwordCtrl.text;

          await LoginService().login(username, password).then((isLogin) {
            if (isLogin) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Beranda(),
                ),
              );
            } else {
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
      ),
    );
  }
}
