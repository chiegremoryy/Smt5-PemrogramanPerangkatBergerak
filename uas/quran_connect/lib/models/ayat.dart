class Ayat {
  Ayat({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });

  int number;
  String text;
  int numberInSurah;
  int juz;
  int manzil;
  int page;
  int ruku;
  int hizbQuarter;
  bool sajda;

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      number: json["number"] ?? 0, 
      text: json["text"] ?? "",
      numberInSurah: json["numberInSurah"] ?? 0,
      juz: json["juz"] ?? 0,
      manzil: json["manzil"] ?? 0,
      page: json["page"] ?? 0,
      ruku: json["ruku"] ?? 0,
      hizbQuarter: json["hizbQuarter"] ?? 0,
      sajda: json["sajda"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "number": number,
        "text": text,
        "numberInSurah": numberInSurah,
        "juz": juz,
        "manzil": manzil,
        "page": page,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda,
      };
}
