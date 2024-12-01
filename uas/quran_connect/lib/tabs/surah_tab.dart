import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_connect/models/surah.dart';
import 'package:quran_connect/components/detail_screen.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  Future<List<Surah>> _getSurahList() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.alquran.cloud/v1/surah'));

      if (response.statusCode == 200) {
        return surahFromJson(response.body);
      } else {
        debugPrint('Failed to load surahs. Status: ${response.statusCode}');
        throw Exception('Failed to load surahs');
      }
    } catch (e) {
      debugPrint('Error fetching surahs: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
        future: _getSurahList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Failed to load Surahs.\nPlease check your internet connection.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) => _surahItem(
              context: context,
              surah: snapshot.data![index],
            ),
            separatorBuilder: (context, index) =>
                Divider(color: const Color(0xFF7B80AD).withOpacity(.35)),
            itemCount: snapshot.data!.length,
          );
        });
  }

  Widget _surahItem({required Surah surah, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailScreen(
                    noSurat: surah.nomor,
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            children: [
              // Nomor Surah dengan dekorasi
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/nomor-surah.svg', // Ikon bunga seperti di gambar
                    width: 40,
                    height: 40,
                  ),
                  Text(
                    "${surah.nomor}",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF007C70),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.namaLatin,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF131313),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${surah.tempatTurun.name.toUpperCase()} • ${surah.jumlahAyat} Ayat",
                      style: GoogleFonts.poppins(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                surah.nama,
                style: GoogleFonts.amiri(
                  color: const Color(0xFF007C70),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      );
}
