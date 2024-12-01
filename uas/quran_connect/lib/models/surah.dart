import 'dart:convert';
import 'ayat.dart';

List<Surah> surahFromJson(String str) =>
    List<Surah>.from(json.decode(str)["data"].map((x) => Surah.fromJson(x)));

String surahToJson(List<Surah> data) =>
    json.encode({"data": List<dynamic>.from(data.map((x) => x.toJson()))});

class Surah {
  Surah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    this.ayat = const [],
  });

  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  TempatTurun tempatTurun;
  List<Ayat> ayat;

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        nomor: json["number"],
        nama: json["name"],
        namaLatin: json["englishName"],
        jumlahAyat: json["numberOfAyahs"],
        tempatTurun: _getTempatTurun(json["revelationType"]),
        ayat: json["ayahs"] != null
            ? List<Ayat>.from(json["ayahs"].map((x) => Ayat.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "number": nomor,
        "name": nama,
        "englishName": namaLatin,
        "numberOfAyahs": jumlahAyat,
        "revelationType": tempatTurunValues.reverse[tempatTurun],
        "ayahs": List<dynamic>.from(ayat.map((x) => x.toJson())),
      };

  static TempatTurun _getTempatTurun(String revelationType) {
    if (revelationType.toLowerCase() == "meccan") {
      return TempatTurun.MEKAH;
    } else if (revelationType.toLowerCase() == "medinan") {
      return TempatTurun.MADINAH;
    } else {
      throw Exception("Unknown revelation type: $revelationType");
    }
  }
}

enum TempatTurun { MEKAH, MADINAH }

final tempatTurunValues =
    EnumValues({"Meccan": TempatTurun.MEKAH, "Medinan": TempatTurun.MADINAH});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
