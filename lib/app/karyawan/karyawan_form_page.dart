import 'package:dashboard_wpn/app/karyawan/karyawan_model.dart';
import 'package:dashboard_wpn/app/karyawan/karyawan_service.dart';
import 'package:dashboard_wpn/app/user/user_model.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/wigdets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class KaryawanFormPage extends StatefulWidget {
  final KaryawanModel? data;
  final ValueNotifier<bool> showForm;
  final Function() onAdd;
  final Function(KaryawanModel) onEdit;
  KaryawanFormPage(
      {Key? key,
      this.data,
      required this.showForm,
      required this.onAdd,
      required this.onEdit})
      : super(key: key);

  @override
  _KaryawanFormPageState createState() => _KaryawanFormPageState();
}

class _KaryawanFormPageState extends State<KaryawanFormPage> {
  // final picker = ImagePicker();

  TextEditingController nameController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  DateTime? startDateController;
  TextEditingController keteranganController = TextEditingController();
  DateTime? birthDateController;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  bool showPassword = false;
  bool showPreLoadedImage = false;
  // Uint8List? _image;
  // Uint8List? _preloadImage;
  int selectedStatus = 0;
  int selectedEducation = 0;
  int selectedFamily = 0;
  int selectedLevel = 1;
  int selectedDivision = 0;
  int selectedPosition = 0;
  int selectedGender = 0;
  int selectedReligion = 0;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      nameController.text = widget.data!.name;
      selectedGender = 0;
      selectedDivision = widget.data!.division;
      selectedPosition = widget.data!.position;
      selectedStatus = widget.data!.status;
      nikController.text = widget.data!.nik;
      birthController.text = widget.data!.ttl.replaceAll(' ', '').split(',')[0];
      selectedEducation = widget.data!.pendidikan;
      selectedReligion = widget.data!.agama;
      selectedFamily = widget.data!.familyStatus;
      keteranganController.text = widget.data!.keterangan;
      startDateController =
          DateFormat('dd/MM/yyyy').parse(widget.data!.startWork);
      birthDateController = DateFormat('dd/MM/yyyy')
          .parse(widget.data!.ttl.replaceAll(' ', '').split(',')[1]);

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
                  'Karyawan Form',
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
              'Nama Pegawai',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: 'Masukkan Nama Lengkap Pegawai',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 20),
            Text(
              'Jenis Kelamin',
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
                  hint: Text('Jenis Kelamin'),
                  underline: Container(),
                  value: selectedGender,
                  isExpanded: true,
                  onChanged: (int? value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Laki-laki'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Perempuan'),
                    ),
                  ]),
            ),
            SizedBox(height: 20),
            Text(
              'Divisi',
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
                  hint: Text('Divisi'),
                  underline: Container(),
                  value: selectedDivision,
                  isExpanded: true,
                  onChanged: (int? value) {
                    setState(() {
                      selectedDivision = value!;
                    });
                  },
                  items: List.generate(divisionData.length, (index) {
                    return DropdownMenuItem(
                      value: index,
                      child: Text(divisionData[index]),
                    );
                  })),
            ),
            SizedBox(height: 20),
            Text(
              'Jabatan',
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
                  hint: Text('Jabatan'),
                  underline: Container(),
                  value: selectedPosition,
                  isExpanded: true,
                  onChanged: (int? value) {
                    setState(() {
                      selectedPosition = value!;
                    });
                  },
                  items: List.generate(positionData[selectedDivision].length,
                      (index2) {
                    return DropdownMenuItem(
                      value: index2,
                      child: Text(positionData[selectedDivision][index2]),
                    );
                  })),
            ),
            SizedBox(height: 20),
            Text(
              'Status',
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
                  hint: Text('Status'),
                  underline: Container(),
                  value: selectedStatus,
                  isExpanded: true,
                  onChanged: (int? value) {
                    setState(() {
                      selectedStatus = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Bulanan'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Borongan'),
                    ),
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'NIK',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: nikController,
              decoration: InputDecoration(
                  hintText: 'Masukkan NIK Pegawai',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Tempat Lahir',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: birthController,
              decoration: InputDecoration(
                  hintText: 'Masukkan Tempat Tanggal Lahir Pegawai',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Tanggal Lahir',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: birthDateController ?? DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(Duration(days: 356 * 55)),
                        lastDate: DateTime.now())
                    .then((value) {
                  setState(() {
                    birthDateController = value;
                  });
                });
              },
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black26, width: 0.1.w)),
                  child: Text(
                    birthDateController == null
                        ? 'Pilih tanggal lahir'
                        : DateFormat('dd/MM/yyyy').format(birthDateController!),
                    style: TextStyle(
                        color: birthDateController == null
                            ? Colors.black54
                            : Colors.black87),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Tanggal Masuk Kerja',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: startDateController ?? DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(Duration(days: 356 * 55)),
                        lastDate: DateTime.now().add(Duration(days: 356 * 15)))
                    .then((value) {
                  setState(() {
                    startDateController = value;
                  });
                });
              },
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black26, width: 0.1.w)),
                  child: Text(
                    startDateController == null
                        ? 'Pilih tanggal Mulai Bekerja'
                        : DateFormat('dd/MM/yyyy').format(startDateController!),
                    style: TextStyle(
                        color: startDateController == null
                            ? Colors.black54
                            : Colors.black87),
                  )),
            ),
            SizedBox(height: 20),
            Text(
              'Pendidikan',
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
                  hint: Text('Pendidikan'),
                  underline: Container(),
                  value: selectedEducation,
                  isExpanded: true,
                  onChanged: (int? value) {
                    setState(() {
                      selectedEducation = value!;
                    });
                  },
                  items: List.generate(educationMasterData.length, (index) {
                    return DropdownMenuItem(
                      value: index,
                      child: Text(educationMasterData[index]),
                    );
                  })),
            ),
            SizedBox(height: 20),
            Text(
              'Agama',
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
                  hint: Text('Agama'),
                  underline: Container(),
                  value: selectedReligion,
                  isExpanded: true,
                  onChanged: (int? value) {
                    setState(() {
                      selectedReligion = value!;
                    });
                  },
                  items: List.generate(religionMasterData.length, (index) {
                    return DropdownMenuItem(
                      value: index,
                      child: Text(religionMasterData[index]),
                    );
                  })),
            ),
            SizedBox(height: 20),
            Text(
              'Status Keluarga',
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
                  hint: Text('Status Keluarga'),
                  underline: Container(),
                  value: selectedFamily,
                  isExpanded: true,
                  onChanged: (int? value) {
                    setState(() {
                      selectedFamily = value!;
                    });
                  },
                  items: List.generate(familyStatusMasterData.length, (index) {
                    return DropdownMenuItem(
                      value: index,
                      child: Text(familyStatusMasterData[index]),
                    );
                  })),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Keterangan',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: keteranganController,
              decoration: InputDecoration(
                  hintText: 'Keterangan Pegawai',
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
                      if (widget.data == null) {
                        EasyLoading.show(status: 'Mohon Tunggu');
                        KaryawanService.createKaryawan(
                          agama: selectedReligion.toString(),
                          division: selectedDivision.toString(),
                          familyStatus: selectedFamily.toString(),
                          keterangan: keteranganController.text,
                          name: nameController.text,
                          nik: nikController.text,
                          pendidikan: selectedEducation.toString(),
                          position: selectedPosition.toString(),
                          status: selectedStatus.toString(),
                          tempatLahir: birthController.text,
                          tanggalLahir: DateFormat('dd/MM/yyyy')
                              .format(birthDateController!),
                          startWork: DateFormat('dd/MM/yyyy')
                              .format(startDateController!),
                        ).then((value) {
                          EasyLoading.dismiss();
                          if (value.status == RequestStatus.successRequest) {
                            showSnackbar(context,
                                title: 'Berhasil Menambah Data Karyawan',
                                customColor: Colors.green);
                            widget.showForm.value = false;
                            widget.onAdd();
                          } else {
                            showSnackbar(context,
                                title: 'Gagal Menyimpan Data Karyawan',
                                customColor: Colors.orange);
                          }
                        });
                      } else {
                        print('update kesini');

                        EasyLoading.show(status: 'Mohon Tunggu');
                        KaryawanService.updateKaryawan(
                          agama: selectedReligion.toString(),
                          id: widget.data!.id.toString(),
                          division: selectedDivision.toString(),
                          familyStatus: selectedFamily.toString(),
                          keterangan: keteranganController.text,
                          name: nameController.text,
                          nik: nikController.text,
                          pendidikan: selectedEducation.toString(),
                          position: selectedPosition.toString(),
                          status: selectedStatus.toString(),
                          tempatLahir: birthController.text,
                          tanggalLahir: DateFormat('dd/MM/yyyy')
                              .format(birthDateController!),
                          startWork: DateFormat('dd/MM/yyyy')
                              .format(startDateController!),
                        ).then((value) {
                          EasyLoading.dismiss();
                          if (value.status == RequestStatus.successRequest) {
                            showSnackbar(context,
                                title: 'Berhasil Menyimpan Data Karyawan',
                                customColor: Colors.green);
                            widget.showForm.value = false;
                            widget.onAdd();
                          } else {
                            showSnackbar(context,
                                title: 'Gagal Menyimpan Data Karyawan',
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
