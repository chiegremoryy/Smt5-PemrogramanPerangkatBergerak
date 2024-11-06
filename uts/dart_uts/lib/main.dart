import 'package:dart_uts/catatan.dart';
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
  TextEditingController namaCtrl = TextEditingController();
  TextEditingController nominalCtrl = TextEditingController();
  bool isPemasukan = true;
  List<Catatan> dataCatatan = [];
  double saldo = 0;

  void hitungSaldo() {
    saldo = 0;
    for (var catatan in dataCatatan) {
      if (catatan.isPemasukan) {
        saldo += catatan.nominal;
      } else {
        saldo -= catatan.nominal;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Catatan Keuangan",
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: namaCtrl,
                decoration: const InputDecoration(
                  labelText: "Transaksi",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Jenis Transaksi",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Pemasukan",
                              style: TextStyle(fontSize: 15)),
                          value: true,
                          groupValue: isPemasukan,
                          onChanged: (value) {
                            setState(() {
                              isPemasukan = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Pengeluaran",
                              style: TextStyle(fontSize: 15)),
                          value: false,
                          groupValue: isPemasukan,
                          onChanged: (value) {
                            setState(() {
                              isPemasukan = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TextField(
                controller: nominalCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Nominal",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (namaCtrl.text.isNotEmpty && nominalCtrl.text.isNotEmpty) {
                    setState(() {
                      dataCatatan.add(Catatan(
                        nama: namaCtrl.text,
                        isPemasukan: isPemasukan,
                        nominal: double.parse(nominalCtrl.text),
                      ));
                      hitungSaldo();
                      namaCtrl.clear();
                      nominalCtrl.clear();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Simpan Transaksi"),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Saldo: Rp ${saldo.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: dataCatatan.length,
                  itemBuilder: (context, index) {
                    final catatan = dataCatatan[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          catatan.isPemasukan
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color:
                              catatan.isPemasukan ? Colors.green : Colors.red,
                        ),
                        title: Text(catatan.nama),
                        subtitle:
                            Text("Rp ${catatan.nominal.toStringAsFixed(0)}"),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              dataCatatan.removeAt(index);
                              hitungSaldo();
                            });
                          },
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
