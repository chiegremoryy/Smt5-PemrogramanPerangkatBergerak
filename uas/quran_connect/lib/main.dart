import 'package:flutter/material.dart';
import 'package:quran_connect/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Menghilangkan label "debug" di sudut layar
      title: 'Quran Connect',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomePage(), // Mengatur HomePage sebagai halaman awal
    );
  }
}
