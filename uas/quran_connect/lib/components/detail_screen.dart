import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatelessWidget {
  final int noSurat;

  const DetailScreen({super.key, required this.noSurat});

  Future<Map<String, dynamic>> _getDetailSurah() async {
    try {
      var response = await Dio().get(
          "https://api.alquran.cloud/v1/surah/$noSurat/editions/quran-uthmani,id.indonesian");
      if (response.statusCode == 200) {
        var data = response.data['data'];
        List<Map<String, dynamic>> combinedData = [];
        for (int i = 0; i < data[0]['ayahs'].length; i++) {
          combinedData.add({
            "arabic": data[0]['ayahs'][i]['text'],
            "translation": data[1]['ayahs'][i]['text'],
            "number": data[0]['ayahs'][i]['numberInSurah'],
          });
        }
        return {
          "name": data[0]['englishName'],
          "translation": data[1]['englishNameTranslation'],
          "revelationType": data[0]['revelationType'],
          "ayahs": combinedData,
          "numberOfAyahs": data[0]['numberOfAyahs'],
        };
      } else {
        throw Exception("Failed to load Surah");
      }
    } catch (e) {
      throw Exception("Failed to load Surah: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: FutureBuilder<Map<String, dynamic>>(
        future: _getDetailSurah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text("Error: ${snapshot.error}")),
            );
          } else if (!snapshot.hasData) {
            return Scaffold(
              body: Center(child: Text("No data available.")),
            );
          }

          var surahData = snapshot.data!;
          var ayatList = surahData['ayahs'];

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 40),
                    child: Container(
                      width: double.infinity,
                      height: 270,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('lib/assets/quran-3.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            surahData['name'],
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            surahData['translation'],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            "${surahData['revelationType']} • ${surahData['numberOfAyahs']} Verses",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Ayat List
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: ayatList.length,
                    shrinkWrap:
                        true, // Allow ListView to take the space it needs
                    physics:
                        NeverScrollableScrollPhysics(), // Disable inner scrolling
                    itemBuilder: (context, index) {
                      final ayat = ayatList[index];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.grey[200],
                                    child: Text(
                                      "${ayat['number']}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 124, 112),
                                      ),
                                    ),
                                  ),
                                  // Icon(Icons.favorite_border),
                                  Icon(Icons.bookmark_border),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  ayat['arabic'],
                                  style: GoogleFonts.amiri(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 124, 112),
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                ayat['translation'],
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
