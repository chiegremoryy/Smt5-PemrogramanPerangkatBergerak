import 'dart:convert';

List<Juz> juzFromJson(String str) =>
    List<Juz>.from(json.decode(str)["data"].map((x) => Juz.fromJson(x)));

String juzToJson(List<Juz> data) =>
    json.encode({"data": List<dynamic>.from(data.map((x) => x.toJson()))});

class Juz {
  Juz({
    required this.juzNumber,
    required this.startSurahName,
    required this.startAyah,
    required this.endSurahName,
    required this.endAyah,
  });

  int juzNumber;
  String startSurahName;
  int startAyah;
  String endSurahName;
  int endAyah;

  factory Juz.fromJson(Map<String, dynamic> json) => Juz(
        juzNumber: json["number"], // 'number' is the juz number
        startSurahName: json["ayahs"].first["surah"]
            ["englishName"], // first Surah name
        startAyah: json["ayahs"].first["numberInSurah"], // first Ayah number
        endSurahName: json["ayahs"].last["surah"]
            ["englishName"], // last Surah name
        endAyah: json["ayahs"].last["numberInSurah"], // last Ayah number
      );

  Map<String, dynamic> toJson() => {
        "juzNumber": juzNumber,
        "startSurahName": startSurahName,
        "startAyah": startAyah,
        "endSurahName": endSurahName,
        "endAyah": endAyah,
      };
}
