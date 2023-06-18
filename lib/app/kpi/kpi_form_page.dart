import 'package:dashboard_wpn/app/karyawan/karyawan_main_page.dart';
import 'package:dashboard_wpn/app/kpi/kpi_model.dart';
import 'package:dashboard_wpn/app/kpi/kpi_service.dart';
import 'package:dashboard_wpn/app/user/user_model.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/shared/util_cubit/fetch_cubit.dart';
import 'package:dashboard_wpn/shared/util_cubit/fetch_state.dart';
import 'package:dashboard_wpn/wigdets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class KPIFormPage extends StatefulWidget {
  final KPI? user;
  final Function() onAdd;
  final Function(KPI) onEdit;
  final ValueNotifier<bool> showForm;
  KPIFormPage(
      {Key? key,
      this.user,
      required this.showForm,
      required this.onAdd,
      required this.onEdit})
      : super(key: key);

  @override
  _KPIFormPageState createState() => _KPIFormPageState();
}

class _KPIFormPageState extends State<KPIFormPage> {
  // final picker = ImagePicker();

  int selectedKaryawan = 0;
  String? selectedName;
  String? selectedId;
  TextEditingController reqruitmentTime = TextEditingController();
  TextEditingController evaluation = TextEditingController();
  TextEditingController pelatihan = TextEditingController();
  TextEditingController kenaikan = TextEditingController();
  TextEditingController kepuasan = TextEditingController();
  int selectedIdp = 0;
  int selectedIdpReady = 0;
  FetchCubit fetchCubit = FetchCubit();

  @override
  void initState() {
    fetchCubit.fetchKaryawan();
    super.initState();

    if (widget.user != null) {
      // for (var i = 0; i < dataKaryawan.length; i++) {
      //   if (dataKaryawan[i].name == widget.user!.karyawanName) {
      //     selectedKaryawan = i;
      //   }
      // }

      reqruitmentTime.text = widget.user!.reqruitmentTime;
      evaluation.text = widget.user!.evaluationValue;
      pelatihan.text = widget.user!.pelatihanTime;
      kenaikan.text = widget.user!.kenaikanProduktivitas;
      kepuasan.text = widget.user!.kepuasan;
      selectedIdp = widget.user!.idpReady;
      selectedIdpReady = widget.user!.idpStart;
      // AuthAPI.userDetail(id: widget.user!.id.toString()).then((value) {
      //   if (value!.status == RequestStatus.suceess_request) {
      //     setState(() {
      //       nameController.text = widget.user!.name;
      //       usernameController.text = widget.user!.username!;
      //       passwordController.text = widget.user!.password!;
      //       selectedLevel = widget.user!.level;
      //       selectedStatus = int.parse(widget.user!.status);
      //       _preloadImage = value.data!.profilePicture;
      //       showPreLoadedImage = true;
      //     });
      //   }
      // });
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
                  'KPI Form',
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
              'Pegawai',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            BlocBuilder<FetchCubit, FetchState>(
                bloc: fetchCubit,
                builder: (context, state) {
                  if (state is ListKaryawanLoaded) {
                    if (widget.user != null) {
                      for (var i = 0; i < state.data.length; i++) {
                        if (state.data[i].id.toString() ==
                            widget.user!.idPegawai) {
                          selectedName = state.data[i].name;
                          selectedId = state.data[i].id.toString();
                        }
                      }

                      if (selectedName == null) {
                        selectedName = state.data[0].name;
                        selectedId = state.data[0].id.toString();
                      }
                    } else {
                      if (selectedName == null) {
                        selectedName = state.data[0].name;
                        selectedId = state.data[0].id.toString();
                      }
                    }

                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.black45, width: 0.1.w)),
                      child: DropdownButton(
                          hint: Text('Pilih Pegawai'),
                          underline: Container(),
                          value: selectedKaryawan,
                          isExpanded: true,
                          onChanged: (int? value) {
                            setState(() {
                              selectedKaryawan = value!;
                              selectedId = state.data[value].id.toString();
                              selectedName = state.data[value].name;
                            });
                          },
                          items: List.generate(state.data.length, (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(state.data[index].name),
                            );
                          })),
                    );
                  }

                  return Container();
                }),
            SizedBox(
              height: 20,
            ),
            Text(
              'Waktu Rekruitmen',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: reqruitmentTime,
              decoration: InputDecoration(
                  hintText: 'Waktu Rekruitmen',
                  suffixText: 'Hari',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 20),
            Text(
              'Nilai Evaluasi 3 Bulan',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: evaluation,
              enabled: widget.user == null,
              decoration: InputDecoration(
                  hintText: 'Nilai Evaluasi 3 Bulan',
                  suffixText: '/100',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 20),
            Text(
              'Total Jam Pelatihan',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: pelatihan,
              enabled: widget.user == null,
              decoration: InputDecoration(
                  hintText: 'Total Jam Pelatihan',
                  suffixText: 'Jam',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 20),
            Text(
              'Kenaikan Produktivitas',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: kenaikan,
              enabled: widget.user == null,
              decoration: InputDecoration(
                  hintText: 'Kenaikan Produktivitas',
                  suffixText: '%',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 20),
            Text(
              'Skor Kepuasan',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: kepuasan,
              enabled: widget.user == null,
              decoration: InputDecoration(
                  hintText: 'Skor Kepuasan',
                  suffixText: '/5',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Pegawai Telah Menyiapkan IDP',
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
                  hint: Text('Pilih Pegawai telah menyiapkan IDP'),
                  underline: Container(),
                  value: selectedIdp,
                  isExpanded: true,
                  onChanged: (int? value) {
                    setState(() {
                      selectedIdp = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Ya'),
                    ),
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Tidak'),
                    ),
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Pelaksanaan IDP',
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
                  hint: Text('Pelaksanaan IDP'),
                  underline: Container(),
                  value: selectedIdpReady,
                  isExpanded: true,
                  onChanged: (int? value) {
                    setState(() {
                      selectedIdpReady = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Ya'),
                    ),
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Tidak'),
                    ),
                  ]),
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
                      if (widget.user == null) {
                        EasyLoading.show(status: 'Mohon Tunggu');
                        KPIService.createKPI(
                                id: selectedId!,
                                name: selectedName!,
                                reqruitmentTime: reqruitmentTime.text,
                                evaluationTime: evaluation.text,
                                pelatihanTime: pelatihan.text,
                                produktivitas: kenaikan.text,
                                kepuasan: kepuasan.text,
                                kpiDate: DateFormat('dd/MM/yyyy')
                                    .format(DateTime.now()),
                                idpReady: selectedIdp.toString(),
                                idpStart: selectedIdpReady.toString())
                            .then((value) {
                          EasyLoading.dismiss();
                          if (value.status == RequestStatus.successRequest) {
                            showSnackbar(context,
                                title: 'Berhasil Menyimpan Data KPI',
                                customColor: Colors.green);
                            widget.onAdd();
                            widget.showForm.value = false;
                          } else {
                            showSnackbar(context,
                                title: 'Gagal Menyimpan Data KPI',
                                customColor: Colors.orange);
                          }
                        });
                      } else {
                        EasyLoading.show(status: 'Mohon Tunggu');
                        KPIService.updateKPI(
                                id: selectedId!,
                                idFinal: widget.user!.id!,
                                name: selectedName!,
                                reqruitmentTime: reqruitmentTime.text,
                                evaluationTime: evaluation.text,
                                pelatihanTime: pelatihan.text,
                                produktivitas: kenaikan.text,
                                kepuasan: kepuasan.text,
                                kpiDate: DateFormat('dd/MM/yyyy')
                                    .format(DateTime.now()),
                                idpReady: selectedIdp.toString(),
                                idpStart: selectedIdpReady.toString())
                            .then((value) {
                          EasyLoading.dismiss();
                          if (value.status == RequestStatus.successRequest) {
                            showSnackbar(context,
                                title: 'Berhasil Menyimpan Data KPI',
                                customColor: Colors.green);
                            widget.onAdd();
                            widget.showForm.value = false;
                          } else {
                            showSnackbar(context,
                                title: 'Gagal Menyimpan Data KPI',
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
