import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final biodata = <String, String>{};

  MainApp({super.key}) {
    biodata['name'] = 'ミカサ | Mikasa Ackerman';
    biodata['email'] = 'mikasaa@shingekinokyoujin.id';
    biodata['phone'] = '+6281249254544';
    biodata['image'] = 'mikasa_ackerman.jpg';
    biodata['hobby'] = 'Melukis di Pulau Paradise';
    biodata['addr'] = 'Wall Rose Paradise';
    biodata['desc'] =
        '''Mikasa first appears in year 845 inside Wall Maria, waking Eren and telling him to return home. Surprised to see him crying, she asks why. On their way, they meet Hannes, and Mikasa watches Eren complain about soldiers slacking off. Afterward, she reveals to Eren's parents his desire to join the Survey Corps, annoying him. Eren leaves, and Mikasa follows, saving Armin from bullies. They discuss their wish to go beyond the Walls. ''';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aplikasi Biodata",
      home: Scaffold(
        appBar: AppBar(title: const Text("Aplikasi Biodata")),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            teksKotak(Colors.black, biodata['name'] ?? ''),
            Image(image: AssetImage('assets/${biodata["image"] ?? ''}')),
            SizedBox(height: 10),
            Row(
              children: [
                btnContact(Icons.alternate_email, Colors.green[900],
                    "mailto:${biodata['email']}"),
                btnContact(Icons.mark_email_unread_rounded, Colors.blueAccent,
                    "https://wa.me/${biodata['phone']}"),
                btnContact(
                    Icons.phone, Colors.deepPurple, "tel:${biodata['phone']}")
              ],
            ),
            SizedBox(height: 10),
            textAttribute("Hobi", biodata['hobby'] ?? ''),
            textAttribute("Alamat", biodata['addr'] ?? ''),
            SizedBox(height: 10),
            teksKotak(Colors.black38, 'Deskripsi'),
            Text(
              biodata['desc'] ?? '',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
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
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      ),
    );
  }

  Row textAttribute(String judul, String teks) {
    return Row(
      children: [
        Container(
          width: 80,
          child: Text("- $judul",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Text(" : ", style: TextStyle(fontSize: 18)),
        Text(teks, style: TextStyle(fontSize: 18))
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
