class Karyawan {
  String npp; //not nullable
  String nama;
  String? alamat; //nullable
  int thnMasuk;
  int _gaji = 2900000;

  Karyawan(this.npp, this.nama, {this.thnMasuk = 2015}); //constructor

  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 8) {
      print("$nama Datang terlambat");
    } else {
      print("$nama Datang tepat waktu");
    }
  }

  String deskripsi() {
    String teks = """===================
    NPP: $npp
    Nama: $nama
    Gaji:$_gaji
    """; //petik tiga itu untuk multi line
    if (alamat != null) {
      teks += "Alamat: $alamat";
    }
    return teks;
  }
}
