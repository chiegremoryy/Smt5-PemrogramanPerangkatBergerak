import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart'; // Impor google_fonts

class RandomAyatWidget extends StatefulWidget {
  @override
  _RandomAyatWidgetState createState() => _RandomAyatWidgetState();
}

class _RandomAyatWidgetState extends State<RandomAyatWidget> {
  String ayatText = "";
  String surahName = "";
  String ayatNumber = "";

  @override
  void initState() {
    super.initState();
    fetchRandomAyat();
  }

  Future<void> fetchRandomAyat() async {
    int randomAyatNumber = (Random().nextInt(6236)) +
        1; // Mendapatkan angka acak antara 1 dan 6236
    final response = await http.get(
      Uri.parse(
          'https://api.alquran.cloud/v1/ayah/$randomAyatNumber/id.indonesian'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final ayatData = data['data'];

      setState(() {
        ayatText = ayatData['text'];
        surahName = ayatData['surah']['englishName'];
        ayatNumber = ayatData['number'].toString();
      });
    } else {
      throw Exception('Failed to load ayat');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (ayatText.isNotEmpty)
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Motivation',
                  style: GoogleFonts.poppins(
                    // Gunakan font Poppins
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 124, 112),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '"$ayatText"',
                  style: GoogleFonts.poppins(
                    // Gunakan font Poppins
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Surah: $surahName | Ayat: $ayatNumber',
                  style: GoogleFonts.poppins(
                    // Gunakan font Poppins
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
