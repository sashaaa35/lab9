import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  const UserInfoPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(Icons.person, 'Name', name),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.email, 'Email', email),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.phone, 'Phone', phone),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue.shade700),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}
