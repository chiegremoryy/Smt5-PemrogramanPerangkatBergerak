import 'karyawan.dart';
// Created by Chie.

void main(List<String> arguments) {
  List<Karyawan> dataKaryawan = genData(dummyData());
  // dataKaryawan.add(Pejabat("A404", "Chie Gremoryyy", TipeJabatan.Direktur));
  // dataKaryawan.add(Pejabat("B404", "Pak Vinsen", TipeJabatan.Manager));
  // dataKaryawan[1].thnMasuk = 2016;
  // dataKaryawan.add(StafBiasa("C404", "Tasya Nismona", thnMasuk: 2020));

  dataKaryawan[0].presensi(DateTime.parse('2023-08-08 07:00:00'));
  dataKaryawan[1].presensi(DateTime.parse('2023-08-08 09:01:01'));
  dataKaryawan[2].presensi(DateTime.parse('2023-08-08 08:30:00'));

  dataKaryawan[1].gaji = 500000;
  dataKaryawan[2].gaji = 5000000;

  dataKaryawan[0].alamat = "Pati, Indonesia";
  dataKaryawan[1].alamat = "Semarang, Indonesia";

  for (var staff in dataKaryawan) {
    print(staff.deskripsi());
  }
}

List<Karyawan> genData(var listData) {
  List<Karyawan> data = [];

  for (var dtPegawai in listData) {
    Karyawan pegawai;
    if (dtPegawai.containsKey('jabatan')) {
      pegawai =
          Pejabat(dtPegawai['npp'], dtPegawai['nama'], dtPegawai['jabatan']);
    } else {
      pegawai = StafBiasa(dtPegawai['npp'], dtPegawai['nama']);
    }

    if (dtPegawai.containsKey('thn_masuk')) {
      pegawai.thnMasuk = dtPegawai['thn_masuk'];
    }

    if (dtPegawai.containsKey('alamat')) {
      pegawai.alamat = dtPegawai['alamat'];
    }

    data.add(pegawai);
  }

  return data;
}

List<Map<String, dynamic>> dummyData() {
  List<Map<String, dynamic>> data = [
    {
      "npp": "A123",
      "nama": "Lars Bak",
      "thn_masuk": 2017,
      "jabatan": TipeJabatan.Direktur,
      "alamat": "Semarang Indonesia"
    },
    {
      "npp": "A345",
      "nama": "Kasper Lund",
      "thn_masuk": 2018,
      "jabatan": TipeJabatan.Manager,
      "alamat": "Semarang Indonesia"
    },
    {"npp": "B231", "nama": "Guido Van Rossum", "alamat": "California Amerika"},
    {
      "npp": "B355",
      "nama": "Rasmus Lerdorf",
      "thn_masuk": 2015,
      "alamat": "Bandung Indonesia"
    },
    {
      "npp": "B355",
      "nama": "Dennis MacAlistair Ritchie",
      "jabatan": TipeJabatan.Kabag,
      "alamat": "Semarang Indonesia"
    }
  ];
  return data;
}

// import 'package:dart_project1/dart_project1.dart' as dart_project1;

  // Karyawan staff1 = StafBiasa("A404", "Chie Gremoryy");
  // Karyawan staff2 = StafBiasa("B404", "Pak Vinsen", thnMasuk: 2016);
  // Karyawan staff3 = StafBiasa("C404", "Tasya", thnMasuk: 2020);
  
  // staff1.presensi(DateTime.parse('2023-08-08 07:00:00'));
  // staff2.presensi(DateTime.parse('2023-08-08 09:01:01'));
  // staff3.presensi(DateTime.parse('2023-08-08 08:30:00'));

  // staff2.gaji = 500000;
  // staff3.gaji = 5000000;

  // staff1.alamat = "Pati, Jawa Tengah";

  // print(staff1.deskripsi());
  // print(staff2.deskripsi());
  // print(staff3.deskripsi());
  // print('Hello world: ${dart_project1.calculate()}!');

  /*int nilai = 90;

  if (nilai > 80) {
    print("Lulus");
  } else {
    print("Tidak Lulus");
  }

  for (int i = 0; i < 10; i++) {
    print("cetakan ke ${i + 1}");
  }*/