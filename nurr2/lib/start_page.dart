import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart'; // Экран с BottomNavigationBar
import 'package:nurr2/pages/registration_page.dart'; // Исправленный путь до RegistrationPage

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key); // Передаем key в super

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  // Проверка статуса авторизации
  Future<void> _checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    bool isAuth = prefs.getBool('isAuthenticated') ?? false;

    // Проверка mounted перед вызовом setState
    if (!mounted) return;  // Проверка, чтобы избежать ошибок после асинхронной операции

    if (isAuth) {
      // Если пользователь авторизован, идём на главный экран с BottomNavigationBar
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      // Если не авторизован, идём на экран регистрации
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationPage()), // Используем const RegistrationPage
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Индикатор загрузки
      ),
    );
  }
}
