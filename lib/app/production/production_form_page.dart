import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dashboard_wpn/app/production/production_model.dart';
import 'package:dashboard_wpn/app/production/production_service.dart';
import 'package:dashboard_wpn/app/user/user_model.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/wigdets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ProductionFormPage extends StatefulWidget {
  final Production? user;
  final ValueNotifier<bool> showForm;
  final Function() onAdd;
  final Function() onEdit;

  ProductionFormPage(
      {Key? key,
      this.user,
      required this.showForm,
      required this.onAdd,
      required this.onEdit})
      : super(key: key);

  @override
  _ProductionFormPageState createState() => _ProductionFormPageState();
}

class _ProductionFormPageState extends State<ProductionFormPage> {
  // final picker = ImagePicker();

  DateTime tanggal = DateTime.now();
  TextEditingController totalProduksi = TextEditingController();
  TextEditingController totalGagal = TextEditingController();
  TextEditingController totalLahan = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      tanggal = DateFormat('dd/MM/yyyy').parse(widget.user!.tanggal);
      totalProduksi.text = widget.user!.produksi;
      totalGagal.text = widget.user!.gagal;
      totalLahan.text = widget.user!.lahan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    widget.showForm.value = false;
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Produksi Form',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Tanggal Produksi',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: tanggal,
                    firstDate:
                        DateTime.now().subtract(Duration(days: 365 * 10)),
                    lastDate: DateTime.now());

                if (picked != null) {
                  setState(() {
                    tanggal = picked;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black45, width: 0.1.w)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd/MM/yyyy').format(tanggal),
                      style: TextStyle(fontSize: 13),
                    ),
                    Icon(
                      Icons.date_range,
                      color: Colors.black54,
                    )
                  ],
                ),
              ),
            ),
            // TextField(
            //   controller: period,
            //   decoration: InputDecoration(
            //       hintText: 'Periode Produksi',
            //       prefixIcon: Icon(Icons.date_range),
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10))),
            // ),
            SizedBox(height: 20),
            Text(
              'Total Produksi (Jumlah Kayu)',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: totalProduksi,
              decoration: InputDecoration(
                  hintText: 'Total Produksi',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 20),
            Text(
              'Total Gagal (Jumlah Kayu Tidak Layak)',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: totalGagal,
              decoration: InputDecoration(
                  hintText: 'Total Kayu Tidak Layak',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 20),
            Text(
              'Lahan Penebangan (m2)',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: totalLahan,
              decoration: InputDecoration(
                  hintText: 'Lahan Penebangan',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Mohon gunakan titik (.) sebagai pemisah desimal',
              style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54),
            ),

            SizedBox(height: 40),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      widget.showForm.value = false;
                    },
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        alignment: Alignment.center,
                        child: Text(
                          'Batal',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      double totalPengeluaran = 0;

                      if (widget.user == null) {
                        EasyLoading.show(status: 'Mohon Tunggu');
                        ProductionService.createProduction(
                                tanggal:
                                    DateFormat('dd/MM/yyyy').format(tanggal),
                                totalGagal: totalGagal.text,
                                totalLahan: totalLahan.text,
                                totalProduksi: totalProduksi.text)
                            .then((value) {
                          EasyLoading.dismiss();
                          if (value.status == RequestStatus.successRequest) {
                            showSnackbar(context,
                                title: 'Berhasil Menambah Data Produksi',
                                customColor: Colors.green);
                            widget.showForm.value = false;
                          } else {
                            showSnackbar(context,
                                title: 'Gagal Menambah Data Produksi',
                                customColor: Colors.orange);
                          }
                        });
                      } else {
                        EasyLoading.show(status: 'Mohon Tunggu');
                        ProductionService.updateProduction(
                          tanggal: DateFormat('dd/MM/yyyy').format(tanggal),
                          totalGagal: totalGagal.text,
                          totalLahan: totalLahan.text,
                          totalProduksi: totalProduksi.text,
                          id: widget.user!.id.toString(),
                        ).then((value) {
                          EasyLoading.dismiss();
                          if (value.status == RequestStatus.successRequest) {
                            widget.onEdit();
                            showSnackbar(context,
                                title: 'Berhasil Menyimpan Data Produksi',
                                customColor: Colors.green);
                            widget.showForm.value = false;
                          } else {
                            showSnackbar(context,
                                title: 'Gagal Menyimpan Data Produksi',
                                customColor: Colors.orange);
                          }
                        });
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        alignment: Alignment.center,
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0.w),
          ],
        ));
  }
}
