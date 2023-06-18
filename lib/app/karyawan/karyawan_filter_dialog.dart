import 'package:dashboard_wpn/wigdets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class KaryawanFilterDialog extends StatefulWidget {
  const KaryawanFilterDialog({super.key});

  @override
  State<KaryawanFilterDialog> createState() => _KaryawanFilterDialogState();
}

class _KaryawanFilterDialogState extends State<KaryawanFilterDialog> {
  TextEditingController yearController = TextEditingController();
  TextEditingController monthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 600,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filter Lama Bekerja',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 1,
                color: Colors.black12,
                width: double.infinity,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tahun',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputField(
                          borderType: 'border',
                          controller: yearController,
                          onChanged: (value) {},
                          hintText: 'Tahun',
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bulan',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputField(
                          borderType: 'border',
                          controller: monthController,
                          onChanged: (value) {},
                          hintText: 'Bulan',
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        if (yearController.text.isEmpty &&
                            monthController.text.isEmpty) {
                          showSnackbar(context,
                              title:
                                  'Mohon Mengisi Lama bekerja minimal tahun/bulan',
                              customColor: Colors.orange);
                        } else {
                          int total = 0;

                          if (yearController.text.isNotEmpty) {
                            total =
                                total + (int.parse(yearController.text) * 12);
                          }

                          if (monthController.text.isNotEmpty) {
                            total = total + int.parse(monthController.text);
                          }

                          Navigator.pop(context, total);
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
