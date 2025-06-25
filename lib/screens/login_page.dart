import 'dart:convert';
import 'package:flutter/material.dart';
import 'product_management_screen.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _handleLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ProductManagementScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 4,
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Clockee Admin", style: TextStyle(fontSize: 24)),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Mật khẩu"),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final username = emailController.text.trim();
                    final password = passwordController.text.trim();
                    login(username, password, context);
                  },
                  child: const Text("Đăng nhập"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Future<void> login(String username, String password, BuildContext context) async {
  final url = Uri.parse("http://103.77.243.218/api/adminlogin");

  final response = await http.post(
    url,
    body: {
      'username': username,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    final user = json.decode(response.body);
    print("Đăng nhập thành công: $user");

    // Chuyển sang màn chính
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ProductManagementScreen()),
    );
  } else {
    final error = json.decode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error['message'] ?? 'Lỗi đăng nhập')),
    );
  }
}