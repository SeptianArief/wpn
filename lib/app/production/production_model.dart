import 'dart:convert';

import 'package:intl/intl.dart';

class ProductionFilter {
  int? month;
  int? year;

  ProductionFilter({this.month, this.year});
}

class Production {
  late String tanggal;
  late int id;
  late String produksi;
  late String gagal;
  late String lahan;
  late DateTime? tanggalLocal;

  Production.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    tanggal = jsonMap['tanggal'];
    produksi = jsonMap['total_produksi'];
    gagal = jsonMap['total_gagal'];
    lahan = jsonMap['total_lahan'];
    tanggalLocal = DateFormat('dd/MM/yyyy').parse(tanggal);
  }

  Production(
      {required this.tanggal,
      required this.id,
      required this.produksi,
      required this.gagal,
      required this.lahan});
}
