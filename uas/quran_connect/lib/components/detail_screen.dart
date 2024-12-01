import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quran_connect/models/surah.dart';

class DetailScreen extends StatelessWidget {
  final int noSurat;
  const DetailScreen({super.key, required this.noSurat});

  Future<Surah> _getDetailSurah() async {
    try {
      var response = await Dio().get(
          "https://api.alquran.cloud/v1/surah/$noSurat/editions/quran-uthmani,id.indonesian");
      if (response.statusCode == 200) {
        return Surah.fromJson(response.data['data'][0]);
      } else {
        throw Exception("Failed to load Surah");
      }
    } catch (e) {
      throw Exception("Failed to load Surah: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Surah>(
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

        Surah surah = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: Text(surah.namaLatin)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: surah.ayat.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            surah.ayat[index].text, // Teks ayat Arab
                            style: TextStyle(fontSize: 24),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Terjemahan: ${surah.ayat[index].text}', // Terjemahan ayat Arab
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
