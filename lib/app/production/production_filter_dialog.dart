import 'package:dashboard_wpn/app/production/production_model.dart';
import 'package:dashboard_wpn/shared/const_value.dart';
import 'package:dashboard_wpn/shared/year_picker_dialog.dart';
import 'package:dashboard_wpn/wigdets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductionFilterDialog extends StatefulWidget {
  const ProductionFilterDialog({super.key});

  @override
  State<ProductionFilterDialog> createState() => _ProductionFilterDialogState();
}

class _ProductionFilterDialogState extends State<ProductionFilterDialog> {
  int? selectedMonth;
  DateTime? selectedYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 600,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Filter',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.black12,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Bulan',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black45, width: 1)),
                                child: DropdownButton(
                                    hint: const Text('Bulan'),
                                    underline: Container(),
                                    value: selectedMonth,
                                    isExpanded: true,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedMonth = value!;
                                      });
                                    },
                                    items: List.generate(bulanData.length,
                                        (index) {
                                      return DropdownMenuItem(
                                        value: index,
                                        child: Text(bulanData[index]),
                                      );
                                    })),
                              ),
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
                              const Text(
                                'Tahun',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () async {
                                  DateTime? result = await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return YearPickerDialog(
                                          yearController: selectedYear,
                                        );
                                      });

                                  if (result != null) {
                                    setState(() {
                                      selectedYear = result;
                                    });
                                  }
                                },
                                child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18, horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black45, width: 1)),
                                    child: Text(
                                      selectedYear == null
                                          ? 'Pilih Tahun'
                                          : selectedYear!.year.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: selectedYear == null
                                              ? Colors.black54
                                              : Colors.black87),
                                    )),
                              ),
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
                              if (selectedMonth == null ||
                                  selectedYear == null) {
                                showSnackbar(context,
                                    title:
                                        'Mohon mengisi bulan dan tahun filter',
                                    customColor: Colors.orange);
                              } else {
                                Navigator.pop(
                                    context,
                                    ProductionFilter(
                                        month: selectedMonth,
                                        year: selectedYear!.year));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
