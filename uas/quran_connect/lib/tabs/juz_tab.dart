import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_connect/models/juz.dart';
import 'package:quran_connect/components/juz_detail_screen.dart';

class JuzTab extends StatelessWidget {
  const JuzTab({super.key});

  Future<List<Juz>> _getJuzList() async {
    try {
      List<Juz> allJuz = [];
      for (int i = 1; i <= 30; i++) {
        final response = await http
            .get(Uri.parse('https://api.alquran.cloud/v1/juz/$i/id.asad'));
        if (response.statusCode == 200) {
          final juzData = json.decode(response.body)["data"];
          allJuz.add(Juz.fromJson(juzData));
        } else {
          debugPrint('Failed to load Juz $i. Status: ${response.statusCode}');
        }
      }
      return allJuz;
    } catch (e) {
      debugPrint('Error fetching Juz: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Juz>>(
      future: _getJuzList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'Failed to load Juz.\nPlease check your internet connection.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            final juz = snapshot.data![index];
            return _juzItem(context: context, juz: juz);
          },
          itemCount: snapshot.data!.length,
        );
      },
    );
  }

  Widget _juzItem({required Juz juz, required BuildContext context}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JuzDetailScreen(
                juzNumber: juz.juzNumber), // Pass correct Juz number
          ),
        );
      },
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF007C70), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "${juz.juzNumber}",
            style: GoogleFonts.poppins(
              color: const Color(0xFF007C70),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
      title: Text(
        "Juz ${juz.juzNumber}",
        style: GoogleFonts.poppins(
          color: const Color(0xFF131313),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        "${juz.startSurahName} • ${juz.startAyah}-${juz.endAyah}",
        style: GoogleFonts.poppins(
          color: Colors.grey[500],
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
      trailing: Text(
        "جُزْءُ",
        style: GoogleFonts.amiri(
          color: const Color(0xFF007C70),
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }
}
