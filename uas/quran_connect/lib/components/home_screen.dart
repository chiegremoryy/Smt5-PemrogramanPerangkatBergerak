import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_connect/models/surah.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoggedIn = true;
  bool isSearchVisible = false;
  String userName = "Chie Gremoryyy";
  TextEditingController searchController = TextEditingController();
  List<String> allSurahs = [];
  List<String> filteredSurahs = [];

  @override
  void initState() {
    super.initState();
    fetchSurahs(); // Ambil data Surah ketika halaman dimulai
  }

  // Fungsi untuk mengambil data Surah dari API
  Future<void> fetchSurahs() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.alquran.cloud/v1/surah'));

      if (response.statusCode == 200) {
        final List<Surah> surahList = surahFromJson(response.body);
        setState(() {
          allSurahs = surahList.map((surah) => surah.namaLatin).toList();
          filteredSurahs = List.from(allSurahs);
        });
      } else {
        debugPrint('Failed to load surahs. Status: ${response.statusCode}');
        throw Exception('Failed to load surahs');
      }
    } on SocketException catch (_) {
      debugPrint('No internet connection');
      throw Exception('No internet connection');
    } catch (e) {
      debugPrint('Error fetching surahs: $e');
      throw Exception('Error fetching surahs');
    }
  }

  // Fungsi untuk mencari surah berdasarkan query
  void searchSurah(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredSurahs = List.from(allSurahs);
      } else {
        filteredSurahs = allSurahs
            .where((surah) => surah.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // Fungsi untuk toggle search bar
  void toggleSearchBar() {
    setState(() {
      isSearchVisible = !isSearchVisible;
      if (!isSearchVisible) {
        searchController.clear();
        searchSurah('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNav(),
      body: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              if (!isSearchVisible) _buildHeader(),
              const SizedBox(height: 24),
              _buildLastRead(),
              const SizedBox(height: 24),
              _buildTabBar(),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildSurahList(),
                    _buildPlaceholderContent('Para'),
                    _buildPlaceholderContent('Page'),
                    _buildPlaceholderContent('Hijb'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: isSearchVisible
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: toggleSearchBar,
            )
          : null,
      title: isSearchVisible
          ? TextField(
              controller: searchController,
              onChanged: searchSurah,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search Surah...",
                border: InputBorder.none,
                hintStyle: GoogleFonts.poppins(color: Colors.grey),
              ),
              style: GoogleFonts.poppins(color: Colors.black87),
            )
          : Text(
              'QuranConnect',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
      actions: [
        if (!isSearchVisible)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: toggleSearchBar,
          ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isLoggedIn
              ? "Assalamualaikum, $userName!"
              : "Welcome to QuranConnect!",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '“Karena sesungguhnya sesudah kesulitan itu ada kemudahan, sesungguhnya sesudah kesulitan itu ada kemudahan.”',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLastRead() {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage('lib/assets/quran-2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Last Read',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Al-Fatihah',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ayat: 1',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      labelColor: Colors.blue[700],
      unselectedLabelColor: Colors.grey[400],
      indicatorColor: Colors.blue[700],
      indicatorWeight: 3,
      labelStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      tabs: const [
        Tab(text: 'Surah'),
        Tab(text: 'Para'),
        Tab(text: 'Page'),
        Tab(text: 'Hijb'),
      ],
    );
  }

  Widget _buildSurahList() {
    return ListView.builder(
      itemCount: filteredSurahs.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            filteredSurahs[index],
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        );
      },
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue[700],
      unselectedItemColor: Colors.grey[400],
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontSize: 12,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          label: 'Quran',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
          label: 'Bookmarks',
        ),
      ],
    );
  }

  Widget _buildPlaceholderContent(String label) {
    return Center(
      child: Text(
        'Content for $label',
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.grey[500],
        ),
      ),
    );
  }
}
