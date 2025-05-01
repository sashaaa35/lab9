import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Successful'),
      ),
      body: Center(
        child: Text(
          'You have successfully registered!',
          style: TextStyle(fontSize: 24, color: Colors.green),
        ),
      ),
    );
  }
}
