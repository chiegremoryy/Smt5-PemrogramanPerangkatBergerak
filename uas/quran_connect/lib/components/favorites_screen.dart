// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:quran_connect/models/database_helper.dart';
// import 'package:quran_connect/models/favorite_ayah.dart';

// class FavoritesScreen extends StatefulWidget {
//   @override
//   _FavoritesScreenState createState() => _FavoritesScreenState();
// }

// class _FavoritesScreenState extends State<FavoritesScreen> {
//   final DatabaseHelper _dbHelper = DatabaseHelper();
//   List<FavoriteAyah> favoriteAyahs = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadFavorites();
//   }

//   Future<void> _loadFavorites() async {
//     List<FavoriteAyah> favorites = await _dbHelper.getFavorites();
//     setState(() {
//       favoriteAyahs = favorites;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Favorites Ayat',
//           style: GoogleFonts.poppins(
//             fontSize: 18,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//       ),
//       body: favoriteAyahs.isEmpty
//           ? Center(
//               child: Text('Belum ayat favorite!', style: GoogleFonts.poppins()),
//             )
//           : ListView.builder(
//               itemCount: favoriteAyahs.length,
//               itemBuilder: (context, index) {
//                 final ayah = favoriteAyahs[index];
//                 return ListTile(
//                   title: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Surah: ${ayah.surahNumber}, Ayah: ${ayah.ayahNumber}',
//                         style: GoogleFonts.poppins(),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         ayah.arabicText,
//                         style: GoogleFonts.amiri(
//                           fontSize: 20,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         ayah.translation,
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           color: Colors.black54,
//                         ), // Menampilkan terjemahan dengan font Poppins
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_connect/models/database_helper.dart';
import 'package:quran_connect/models/favorite_ayah.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final DatabaseHelper _dbHelper =
      DatabaseHelper.instance; // Use singleton instance
  List<FavoriteAyah> favoriteAyahs = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    List<FavoriteAyah> favorites =
        await _dbHelper.getFavorites(); // Correctly fetch List<FavoriteAyah>
    setState(() {
      favoriteAyahs = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites Ayat',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
      body: favoriteAyahs.isEmpty
          ? Center(
              child: Text('Belum ayat favorite!', style: GoogleFonts.poppins()),
            )
          : ListView.builder(
              itemCount: favoriteAyahs.length,
              itemBuilder: (context, index) {
                final ayah = favoriteAyahs[index];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Surah: ${ayah.surahNumber}, Ayah: ${ayah.ayahNumber}',
                        style: GoogleFonts.poppins(),
                      ),
                      SizedBox(height: 5),
                      Text(
                        ayah.arabicText,
                        style: GoogleFonts.amiri(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        ayah.translation,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
