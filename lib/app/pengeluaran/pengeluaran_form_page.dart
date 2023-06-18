import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dashboard_wpn/app/pengeluaran/pengeluaran_model.dart';
import 'package:dashboard_wpn/app/pengeluaran/pengeluaran_service.dart';
import 'package:dashboard_wpn/app/production/production_model.dart';
import 'package:dashboard_wpn/app/production/production_service.dart';
import 'package:dashboard_wpn/app/user/user_model.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/wigdets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class PengeluaranFormPage extends StatefulWidget {
  final Pengeluaran? user;
  final ValueNotifier<bool> showForm;
  final Function() onAdd;
  final Function() onEdit;

  PengeluaranFormPage(
      {Key? key,
      this.user,
      required this.showForm,
      required this.onAdd,
      required this.onEdit})
      : super(key: key);

  @override
  _PengeluaranFormPageState createState() => _PengeluaranFormPageState();
}

class _PengeluaranFormPageState extends State<PengeluaranFormPage> {
  // final picker = ImagePicker();

  DateTime tanggal = DateTime.now();
  TextEditingController total = TextEditingController();
  TextEditingController notes = TextEditingController();
  int selectedType = 0;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      tanggal = DateFormat('dd/MM/yyyy').parse(widget.user!.tanggal);
      total.text = widget.user!.jumlah;
      notes.text = widget.user!.notes;
      selectedType = widget.user!.type;
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
                  'Pengeluaran Form',
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
              'Tanggal',
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
            SizedBox(height: 20),
            Text(
              'Tipe Pengeluaran',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black45, width: 0.1.w)),
              child: DropdownButton(
                  hint: Text('Tipe Pengeluaran'),
                  underline: Container(),
                  value: selectedType,
                  isExpanded: true,
                  onChanged: (int? value) {
                    setState(() {
                      selectedType = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Upah'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Sparepart'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Oli'),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('Bensin'),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Text('Dll'),
                    ),
                  ]),
            ),
            SizedBox(height: 20),
            Text(
              'Jumlah Pengeluaran',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: total,
              decoration: InputDecoration(
                  hintText: 'Jumlah Pengeluaran',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 20),
            Text(
              'Catatan',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: notes,
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: 'Catatan',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
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
                        PengeluaranService.createPengeluaran(
                                tanggal:
                                    DateFormat('dd/MM/yyyy').format(tanggal),
                                notes: notes.text,
                                tipe: selectedType.toString(),
                                total: total.text)
                            .then((value) {
                          EasyLoading.dismiss();
                          if (value.status == RequestStatus.successRequest) {
                            showSnackbar(context,
                                title: 'Berhasil Menambah Data Pengeluaran',
                                customColor: Colors.green);
                            widget.showForm.value = false;
                            widget.onAdd();
                          } else {
                            showSnackbar(context,
                                title: 'Gagal Menambah Data Pengeluaran',
                                customColor: Colors.orange);
                          }
                        });
                      } else {
                        EasyLoading.show(status: 'Mohon Tunggu');
                        PengeluaranService.updatePengeluaran(
                                id: widget.user!.id.toString(),
                                tanggal:
                                    DateFormat('dd/MM/yyyy').format(tanggal),
                                notes: notes.text,
                                tipe: selectedType.toString(),
                                total: total.text)
                            .then((value) {
                          EasyLoading.dismiss();
                          if (value.status == RequestStatus.successRequest) {
                            showSnackbar(context,
                                title: 'Berhasil Menyimpan Data Pengeluaran',
                                customColor: Colors.green);
                            widget.showForm.value = false;
                            widget.onEdit();
                          } else {
                            showSnackbar(context,
                                title: 'Gagal Menyimpan Data Pengeluaran',
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
