import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main_screen.dart'; // Экран с BottomNavigationBar

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

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    nameFocus.dispose();
    emailFocus.dispose();
    usernameFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

  // Функция для создания декорации текстового поля
  InputDecoration _buildInputDecoration(String hintKey, IconData icon) {
    return InputDecoration(
      hintText: hintKey.tr(),
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
    );
  }

  // Функция для сохранения данных и перехода на главный экран
  Future<void> _saveAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();

    // Сохранение данных в SharedPreferences
    await prefs.setString('name', nameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('username', usernameController.text);
    await prefs.setBool('isAuthenticated', true);

    if (!mounted) return;

    // Переход на главный экран
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()), // Экран с BottomNavigationBar
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF42A5F5),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Text('title'.tr()), // Перевод заголовка
        actions: [
          // Изменение языка на английский
          IconButton(
            icon: const Text('🇺🇸'),
            onPressed: () => context.setLocale(const Locale('en', 'US')),
          ),
          // Изменение языка на русский
          IconButton(
            icon: const Text('🇷🇺'),
            onPressed: () => context.setLocale(const Locale('ru', 'RU')),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Container(
            padding: EdgeInsets.all(20.w),
            width: 0.9.sw,
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
                  Text(
                    'form_hint'.tr(),
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Text('name'.tr(), style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                  SizedBox(height: 6.h),
                  TextFormField(
                    controller: nameController,
                    focusNode: nameFocus,
                    decoration: _buildInputDecoration('name'.tr(), Icons.person),
                    validator: (value) => value == null || value.isEmpty ? 'name_required'.tr() : null,
                  ),
                  SizedBox(height: 16.h),
                  Text('email'.tr(), style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                  SizedBox(height: 6.h),
                  TextFormField(
                    controller: emailController,
                    focusNode: emailFocus,
                    decoration: _buildInputDecoration('email'.tr(), Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'email_required'.tr();
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'invalid_email'.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text('username'.tr(), style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                  SizedBox(height: 6.h),
                  TextFormField(
                    controller: usernameController,
                    focusNode: usernameFocus,
                    decoration: _buildInputDecoration('username'.tr(), Icons.groups),
                    validator: (value) => value == null || value.isEmpty ? 'username_required'.tr() : null,
                  ),
                  SizedBox(height: 16.h),
                  Text('password'.tr(), style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                  SizedBox(height: 6.h),
                  TextFormField(
                    controller: passwordController,
                    focusNode: passwordFocus,
                    obscureText: _obscurePassword,
                    decoration: _buildInputDecoration('password'.tr(), Icons.lock).copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password_required'.tr();
                      } else if (value.length < 6) {
                        return 'password_length'.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text('confirm_password'.tr(), style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                  SizedBox(height: 6.h),
                  TextFormField(
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordFocus,
                    obscureText: _obscureConfirm,
                    decoration: _buildInputDecoration('confirm_password'.tr(), Icons.lock).copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirm ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() => _obscureConfirm = !_obscureConfirm);
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'password_mismatch'.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveAndNavigate(); // Сохраняем и переходим
                      }
                    },
                    child: Text('register'.tr(), style: TextStyle(fontSize: 18.sp)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
