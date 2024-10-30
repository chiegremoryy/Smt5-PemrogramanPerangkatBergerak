import 'package:dart_project5/catatan.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController judulCtrl = TextEditingController();
  TextEditingController isiCtrl = TextEditingController();
  List<Catatan> dataCatatan = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Catatan Pagi"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextField untuk Judul
              TextField(
                controller: judulCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Judul",
                ),
              ),
              SizedBox(height: 10),

              // TextField untuk Isi Catatan
              TextField(
                controller: isiCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Catatan",
                ),
              ),
              SizedBox(height: 10),

              // Tombol Clear dan Submit
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Membuat tombol Clear lebih besar
                  SizedBox(
                    width: 150, // Lebar tombol Clear
                    height: 50, // Tinggi tombol Clear
                    child: ElevatedButton(
                      onPressed: () {
                        judulCtrl.clear();
                        isiCtrl.clear();
                      },
                      child: Text("Clear"),
                    ),
                  ),
                  // Membuat tombol Submit lebih besar
                  SizedBox(
                    width: 150, // Lebar tombol Submit
                    height: 50, // Tinggi tombol Submit
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          dataCatatan.add(Catatan(
                            judul: judulCtrl.text,
                            isi: isiCtrl.text,
                          ));
                          judulCtrl.clear();
                          isiCtrl.clear();
                        });
                      },
                      child: Text("Submit"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Daftar Catatan yang ditambahkan
              Expanded(
                child: ListView.builder(
                  itemCount: dataCatatan.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        onTap: () {
                          // Aksi ketika ListTile ditekan
                          print(dataCatatan[index].judul);
                          print(dataCatatan[index].isi);
                          print(dataCatatan[index].tglInput);
                        },
                        title: Text(dataCatatan[index].judul),
                        subtitle: Text(
                          dataCatatan[index].isi,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              dataCatatan.removeAt(index);
                            });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
