import 'package:intl/intl.dart';

class Penjualan {
  late int id;
  late String tanggal;
  late String jumlah;
  late String nama;
  late String total;
  late String catatan;
  DateTime? tanggalLocal;

  Penjualan.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    tanggal = jsonMap['tanggal'];
    jumlah = jsonMap['jumlah'];
    nama = jsonMap['nama'];
    total = jsonMap['total'];
    tanggalLocal = DateFormat('dd/MM/yyyy').parse(tanggal);
    catatan = jsonMap['catatan'];
  }

  Penjualan(
      {required this.id,
      required this.tanggal,
      required this.jumlah,
      required this.nama,
      required this.total,
      required this.catatan});
}
