// class FavoriteAyah {
//   final int id;
//   final int surahNumber;
//   final int ayahNumber;
//   final String arabicText; // Menambahkan teks Arab
//   final String translation; // Menambahkan terjemahan

//   FavoriteAyah({
//     required this.id,
//     required this.surahNumber,
//     required this.ayahNumber,
//     required this.arabicText, // Menambahkan konstruktor untuk arabicText
//     required this.translation, // Menambahkan konstruktor untuk translation
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'surahNumber': surahNumber,
//       'ayahNumber': ayahNumber,
//       'arabicText': arabicText, // Menambahkan arabicText ke map
//       'translation': translation, // Menambahkan translation ke map
//     };
//   }

//   factory FavoriteAyah.fromMap(Map<String, dynamic> map) {
//     return FavoriteAyah(
//       id: map['id'],
//       surahNumber: map['surahNumber'],
//       ayahNumber: map['ayahNumber'],
//       arabicText: map['arabicText'], // Mengambil arabicText dari map
//       translation: map['translation'], // Mengambil translation dari map
//     );
//   }
// }
class FavoriteAyah {
  final int surahNumber;
  final int ayahNumber;
  final String arabicText;
  final String translation;

  FavoriteAyah({
    required this.surahNumber,
    required this.ayahNumber,
    required this.arabicText,
    required this.translation,
  });

  factory FavoriteAyah.fromMap(Map<String, dynamic> map) {
    return FavoriteAyah(
      surahNumber: map['surahNumber'],
      ayahNumber: map['ayahNumber'],
      arabicText: map['arabicText'],
      translation: map['translation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'surahNumber': surahNumber,
      'ayahNumber': ayahNumber,
      'arabicText': arabicText,
      'translation': translation,
    };
  }
}
