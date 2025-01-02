import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JuzDetailScreen extends StatefulWidget {
  final int juzNumber;

  const JuzDetailScreen({Key? key, required this.juzNumber}) : super(key: key);

  @override
  State<JuzDetailScreen> createState() => _JuzDetailScreenState();
}

class _JuzDetailScreenState extends State<JuzDetailScreen> {
  Future<List<String>> _getJuzDetails() async {
    try {
      final response = await Dio().get(
          "https://api.alquran.cloud/v1/juz/${widget.juzNumber}/quran-uthmani");
      if (response.statusCode == 200) {
        final ayahs = response.data['data']['ayahs'] as List;
        return ayahs.map((ayah) => ayah['text'] as String).toList();
      } else {
        throw Exception("Failed to load Juz details");
      }
    } catch (e) {
      throw Exception("Failed to load Juz details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: FutureBuilder<List<String>>(
        future: _getJuzDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text("Error: ${snapshot.error}")),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Scaffold(
              body: Center(child: Text("No data available.")),
            );
          }

          final ayahs = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Juz ${widget.juzNumber}",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true, // Menyebabkan teks di header berada di tengah
              backgroundColor: const Color.fromARGB(255, 0, 124, 112),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              itemCount: ayahs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        ayahs[index],
                        style: GoogleFonts.amiri(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 124, 112),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
