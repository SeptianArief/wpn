import 'package:dashboard_wpn/app/karyawan/karyawan_model.dart';
import 'package:flutter/material.dart';

class KaryawanDetailPage extends StatefulWidget {
  final ValueNotifier<bool> showForm;
  final KaryawanModel data;
  KaryawanDetailPage({Key? key, required this.showForm, required this.data})
      : super(key: key);

  @override
  _KaryawanDetailPageState createState() => _KaryawanDetailPageState();
}

class _KaryawanDetailPageState extends State<KaryawanDetailPage> {
  Widget buildDataSummary({required String title, required String desc}) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                title,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 7,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                desc,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(children: [
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
                'Detail Karyawan',
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
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black38)),
            child: Column(
              children: [
                buildDataSummary(title: 'Nama Pegawai', desc: widget.data.name),
                buildDataSummary(title: 'Jenis Kelamin', desc: 'Laki-laki'),
                buildDataSummary(
                    title: 'Divisi', desc: divisionData[widget.data.division]),
                buildDataSummary(
                    title: 'Jabatan',
                    desc: positionData[widget.data.division]
                        [widget.data.position]),
                buildDataSummary(
                    title: 'Status',
                    desc: statusMasterData[widget.data.status]),
                buildDataSummary(title: 'NIK', desc: widget.data.nik),
                buildDataSummary(
                    title: 'Tempat, Tanggal Lahir', desc: widget.data.ttl),
                buildDataSummary(
                    title: 'Tanggal Masuk', desc: widget.data.startWork),
                buildDataSummary(
                    title: 'Pendidikan',
                    desc: educationMasterData[widget.data.pendidikan]),
                buildDataSummary(
                    title: 'Agama',
                    desc: religionMasterData[widget.data.agama]),
                buildDataSummary(
                    title: 'Status Keluarga',
                    desc: familyStatusMasterData[widget.data.familyStatus]),
              ],
            ),
          )
        ]));
  }
}
