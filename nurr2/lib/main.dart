import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'success_page.dart'; // Импортируем SuccessPage

void main() {
  runApp(const NurrApp());
}

class NurrApp extends StatelessWidget {
  const NurrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nurr Registration',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Метод для сохранения данных в SharedPreferences
  Future<void> _saveRegistrationData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('username', usernameController.text);
    await prefs.setBool('isAuthenticated', true); // Устанавливаем авторизацию как true
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF42A5F5), // голубой фон
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 400,
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Sign up once and watch any of our free demos.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Enter your Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Name is required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Enter your Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Email is required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintText: "Enter your Username",
                      prefixIcon: Icon(Icons.account_circle),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Username is required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: "Enter your Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),   
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: _obscureConfirm,
                    decoration: InputDecoration(
                      hintText: "Confirm your Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirm = !_obscureConfirm;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _saveRegistrationData(); // Сохраняем данные
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SuccessPage(), // Переходим на страницу успеха
                          ),
                        );
                      }
                    },
                    child: const Text("Register"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
