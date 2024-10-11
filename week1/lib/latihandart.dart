import 'karyawan.dart';

void main(List<String> arguments) {
  Karyawan staff1 = Karyawan("A123", "Lars Bak");
  Karyawan staff2 = Karyawan("B123", "Kasper Lund", thnMasuk: 2016);
  Karyawan staff3 = Karyawan("C123", "Denis Ritchie", thnMasuk: 2020);

  staff1.presensi(DateTime.parse('2023-08-08 07:00:00'));
  staff2.presensi(DateTime.parse('2023-08-08 09:01:01'));
  staff3.presensi(DateTime.parse('2023-08-08 08:30:00'));

  staff2.gaji = 50000;
  staff3.gaji = 500000;

  print(staff1.deskripsi());
  print(staff2.deskripsi());
  print(staff3.deskripsi());
}
