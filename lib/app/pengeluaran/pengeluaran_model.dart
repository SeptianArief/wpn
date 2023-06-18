import 'dart:convert';

import 'package:intl/intl.dart';

class Pengeluaran {
  late String jumlah;
  late int id;
  late String tanggal;
  late String notes;
  late int type;
  DateTime? tanggalLocal;

  Pengeluaran.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    tanggal = jsonMap['tanggal'];
    jumlah = jsonMap['jumlah'];
    notes = jsonMap['notes'];
    type = jsonMap['type'];
    tanggalLocal = DateFormat('dd/MM/yyyy').parse(tanggal);
  }

  Pengeluaran(
      {required this.id,
      required this.jumlah,
      required this.notes,
      required this.tanggal,
      required this.type});
}
