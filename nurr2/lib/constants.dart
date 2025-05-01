import 'package:flutter/material.dart';

// Основные цвета
const kPrimaryColor = Color(0xFF42A5F5);
const kSecondaryColor = Color(0xFF1E88E5);
const kAccentColor = Color(0xFF90CAF9);
const kBackgroundColor = Color(0xFFE3F2FD);

// Стиль текста
const kTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

// Более гибкие стили текста
const kTitleStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

const kLabelStyle = TextStyle(
  fontSize: 14,
  color: Colors.white70,
);

const kInputTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.black87,
);

// Универсальный BoxDecoration
BoxDecoration kCardBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6,
      offset: Offset(0, 3),
    ),
  ],
);

// Функции для адаптивных размеров
double getAdaptiveHeight(BuildContext context, double inputHeight) {
  final screenHeight = MediaQuery.of(context).size.height;
  return (inputHeight / 812.0) * screenHeight; // 812 — базовая высота iPhone X
}

double getAdaptiveWidth(BuildContext context, double inputWidth) {
  final screenWidth = MediaQuery.of(context).size.width;
  return (inputWidth / 375.0) * screenWidth; // 375 — базовая ширина iPhone X
}
