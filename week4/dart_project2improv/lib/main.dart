import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final restoInfo = <String, String>{};

  MainApp({super.key}) {
    restoInfo['name'] = 'Rm. Sedap Rasa';
    restoInfo['email'] = 'info@sedaprasa.com';
    restoInfo['phone'] = '+6281249254544';
    restoInfo['address'] = 'Jl. Java Culture No.123, Kota Java, Indonesia';
    restoInfo['image'] = 'sedap_rasa.jpg';
    restoInfo['desc'] =
        '''Rumah Makan Sedap Rasa menghadirkan berbagai masakan khas nusantara dengan cita rasa yang lezat dan harga terjangkau. Nikmati pengalaman kuliner yang memanjakan lidah Anda bersama keluarga dan teman.''';
    restoInfo['menu'] = '''1. Nasi Goreng Kambing
2. Rendang Daging
3. Soto Betawi
4. Sate Ayam Madura
5. Gudeg Jogja''';
    restoInfo['hours'] = '''a. Senin - Jumat: 10:00 - 22:00
b. Sabtu - Minggu: 08:00 - 23:00''';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profil Resto",
      home: Scaffold(
        appBar: AppBar(title: const Text(" Rm. Sedap Rasa")),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            teksKotak(Colors.black, restoInfo['name'] ?? ''),
            Image(image: AssetImage('assets/${restoInfo["image"] ?? ''}')),
            SizedBox(height: 10),
            Row(
              children: [
                btnContact(Icons.email, Colors.green[900],
                    "mailto:${restoInfo['email']}"),
                btnContact(
                    Icons.map, Colors.blueAccent, "https://maps.google.com"),
                btnContact(Icons.phone, Colors.deepPurple,
                    "tel:${restoInfo['phone']}"),
              ],
            ),
            SizedBox(height: 10),
            teksKotak(Colors.black38, 'Deskripsi'),
            Text(
              restoInfo['desc'] ?? '',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            teksKotak(Colors.black38, 'List Menu'),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                restoInfo['menu'] ?? '',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 10),
            teksKotak(Colors.black38, 'Alamat'),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                restoInfo['address'] ?? '',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 10),
            teksKotak(Colors.black38, 'Jam Buka'),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                restoInfo['hours'] ?? '',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Container teksKotak(Color bgColor, String teks) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(color: bgColor),
      child: Text(
        teks,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
      ),
    );
  }

  Row textAttribute(String judul, String teks) {
    return Row(
      children: [
        Container(
          width: 100,
          child: Text("$judul",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        Text(" : ", style: TextStyle(fontSize: 18)),
        Expanded(
          child: Text(teks, style: TextStyle(fontSize: 18)),
        )
      ],
    );
  }

  Expanded btnContact(IconData icon, var color, String uri) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          launch(uri);
        },
        child: Icon(icon),
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            textStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  void launch(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Tidak dapat memanggil: $uri');
    }
  }
}
