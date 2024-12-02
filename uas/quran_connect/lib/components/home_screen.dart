import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quran_connect/tabs/surah_tab.dart';
import 'package:quran_connect/models/random_ayat.dart';

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
  List<dynamic> searchResults = [];
  bool isLoading = false;

  Future<void> searchSurah(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://api.alquran.cloud/v1/search/$query/all/id.indonesian'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          searchResults = data['data']['matches'] ?? [];
        });
      } else {
        setState(() {
          searchResults = [];
        });
      }
    } catch (e) {
      print("Error fetching search results: $e");
      setState(() {
        searchResults = [];
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNav(),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              isSearchVisible ? _buildSearchBar() : _buildHeader(),
              const SizedBox(height: 16),
              if (!isSearchVisible) _buildLastRead(),
              const SizedBox(height: 16),
              if (!isSearchVisible) _buildTabBar(),
              const SizedBox(height: 16),
              Expanded(
                child: isSearchVisible
                    ? _buildSearchResults()
                    : const TabBarView(
                        children: [
                          SurahTab(),
                          Placeholder(),
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
              onPressed: () {
                setState(() {
                  isSearchVisible = false;
                  searchController.clear();
                  searchResults = [];
                });
              },
            )
          : null,
      title: isSearchVisible
          ? null
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
            onPressed: () {
              setState(() {
                isSearchVisible = true;
              });
            },
          ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              hintText: 'Masukkan kata kunci. . .',
              hintStyle: GoogleFonts.poppins(),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        IconButton(
          icon:
              const Icon(Icons.search, color: Color.fromARGB(255, 0, 124, 112)),
          onPressed: () {
            searchSurah(searchController.text);
          },
        ),
        IconButton(
          icon:
              const Icon(Icons.close, color: Color.fromARGB(255, 0, 124, 112)),
          onPressed: () {
            setState(() {
              isSearchVisible = false;
              searchController.clear();
              searchResults = [];
            });
          },
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (searchResults.isEmpty) {
      return Center(
        child: Text(
          'Pencarian tidak ditemukan!',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final result = searchResults[index];
        return ListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  result['text'] ?? 'Unknown',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ),
              Text(
                result['surah']['name'] ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 124, 112),
                ),
              ),
            ],
          ),
          subtitle: Text(
            'Surah: ${result['surah']['englishName']} | Ayat: ${result['numberInSurah']}',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Text(
          "Assalamualaikum, $userName!",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        RandomAyatWidget(),
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
      child: Padding(
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
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      labelColor: const Color.fromARGB(255, 0, 124, 112),
      unselectedLabelColor: Colors.grey[400],
      indicatorColor: const Color.fromARGB(255, 0, 124, 112),
      indicatorWeight: 3,
      labelStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      tabs: const [
        Tab(text: 'Surah'),
        Tab(text: 'Juz'),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color.fromARGB(255, 0, 124, 112),
      unselectedItemColor: Colors.grey[400],
      selectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
      unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.book_rounded),
          label: 'Al-Quran',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Bookmarks',
        ),
      ],
    );
  }
}
