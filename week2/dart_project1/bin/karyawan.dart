<<<<<<< HEAD
import 'package:intl/intl.dart';

const UMR = 2900000;

var numFormat = NumberFormat("#,000");
var dateFormat = DateFormat('yyyy-MM-dd');

abstract class Karyawan {
  //superclass
  String npp; //not nullable
  String nama;
  String? alamat; //nullable
  int thnMasuk;
  int _gaji = UMR; //inisialisasi setter dan getter

  Karyawan(this.npp, this.nama, {this.thnMasuk = 2015}); //constructor

  void presensi(
      DateTime jamMasuk); //hanya perlu titik koma untuk membuat abstract method
  /*{
    if (jamMasuk.hour > 8) {
      print("$nama Datang terlambat");
    } else {
      print("$nama datang tepat waktu");
    }
  }*/

  String deskripsi() {
    String teks = """=================== 
    NPP: $npp
    Nama: $nama
    Gaji:${numFormat.format(gaji)}
    """; //multi line string bisa petik 1 atau petik 2 sebanyak 3
    if (alamat != null) {
      teks += "Alamat: $alamat";
    }
    return teks;
  }

  /*int get tunjangan {
    //tidak perlu kurung karena tidak ada parameter disini

    //contoh 1: kondisi if else
    if ((2023 - thnMasuk) < 5) {
      return 500000;
    } else {
      return 1000000;
    }
    */

  //contoh 2: ternari operation seperti halny di java
  /*return ((2023 - thnMasuk) < 5) ? 500000 : 1000000;
    */

  //contoh 3: setter dengan arrow function
  int get tunjangan;

  int get gaji => (_gaji + tunjangan);

  set gaji(int gaji) {
    if (gaji < UMR) {
      _gaji = UMR;
      print("Gaji tidak boleh di bawah UMR");
    } else {
      _gaji = gaji;
    }
  }
}

class StafBiasa extends Karyawan {
  StafBiasa(super.npp, super.nama, {thnMasuk = 2015});

  @override
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 8) {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang terlambat");
    } else {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang tepat waktu");
    }
  }

  @override
  int get tunjangan => ((2023 - thnMasuk) < 5) ? 500000 : 1000000;
}

enum TipeJabatan { Kabag, Manager, Direktur }

class Pejabat extends Karyawan {
  TipeJabatan jabatan;

  Pejabat(super.npp, super.nama, this.jabatan);

  @override
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 10) {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang terlambat");
    } else {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang tepat waktu");
    }
  }

  @override
  int get tunjangan {
    if (jabatan == TipeJabatan.Kabag) {
      return 1500000;
    } else if (jabatan == TipeJabatan.Manager) {
      return 2500000;
    } else {
      return 5000000;
    }
  } //subclass

  @override
  String deskripsi() {
    String teks = super.deskripsi();
    teks += "\n    Jabatan : ${jabatan.name}";
    return teks;
  }
}
=======
import 'package:intl/intl.dart';

const UMR = 2900000;

var numFormat = NumberFormat("#,000");
var dateFormat = DateFormat('yyyy-MM-dd');

abstract class Karyawan {
  //superclass
  String npp; //not nullable
  String nama;
  String? alamat; //nullable
  int thnMasuk;
  int _gaji = UMR; //inisialisasi setter dan getter

  Karyawan(this.npp, this.nama, {this.thnMasuk = 2015}); //constructor

  void presensi(
      DateTime jamMasuk); //hanya perlu titik koma untuk membuat abstract method
  /*{
    if (jamMasuk.hour > 8) {
      print("$nama Datang terlambat");
    } else {
      print("$nama datang tepat waktu");
    }
  }*/

  String deskripsi() {
    String teks = """=================== 
    NPP: $npp
    Nama: $nama
    Gaji:${numFormat.format(gaji)}
    """; //multi line string bisa petik 1 atau petik 2 sebanyak 3
    if (alamat != null) {
      teks += "Alamat: $alamat";
    }
    return teks;
  }

  /*int get tunjangan {
    //tidak perlu kurung karena tidak ada parameter disini

    //contoh 1: kondisi if else
    if ((2023 - thnMasuk) < 5) {
      return 500000;
    } else {
      return 1000000;
    }
    */

  //contoh 2: ternari operation seperti halny di java
  /*return ((2023 - thnMasuk) < 5) ? 500000 : 1000000;
    */

  //contoh 3: setter dengan arrow function
  int get tunjangan;

  int get gaji => (_gaji + tunjangan);

  set gaji(int gaji) {
    if (gaji < UMR) {
      _gaji = UMR;
      print("Gaji tidak boleh di bawah UMR");
    } else {
      _gaji = gaji;
    }
  }
}

class StafBiasa extends Karyawan {
  StafBiasa(super.npp, super.nama, {thnMasuk = 2015});

  @override
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 8) {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang terlambat");
    } else {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang tepat waktu");
    }
  }

  @override
  int get tunjangan => ((2023 - thnMasuk) < 5) ? 500000 : 1000000;
}

enum TipeJabatan { Kabag, Manager, Direktur }

class Pejabat extends Karyawan {
  TipeJabatan jabatan;

  Pejabat(super.npp, super.nama, this.jabatan);

  @override
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 10) {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang terlambat");
    } else {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang tepat waktu");
    }
  }

  @override
  int get tunjangan {
    if (jabatan == TipeJabatan.Kabag) {
      return 1500000;
    } else if (jabatan == TipeJabatan.Manager) {
      return 2500000;
    } else {
      return 5000000;
    }
  } //subclass

  @override
  String deskripsi() {
    String teks = super.deskripsi();
    teks += "\n    Jabatan : ${jabatan.name}";
    return teks;
  }
}
>>>>>>> f9f913229947a88b3c4190e10de5073ea80734cb
