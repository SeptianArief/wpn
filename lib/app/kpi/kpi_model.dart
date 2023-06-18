class KPI {
  late String karyawanName;
  late String reqruitmentTime;
  late String evaluationValue;
  late String pelatihanTime;
  late String kenaikanProduktivitas;
  late String kepuasan;
  late String kpiDate;
  late int idpReady;
  late int idpStart;
  String? id;
  String? idPegawai;

  KPI.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    idPegawai = jsonMap['id_pegawai'].toString();
    karyawanName = jsonMap['name'];
    reqruitmentTime = jsonMap['reqruitment_time'];
    evaluationValue = jsonMap['evaluation_time'];
    pelatihanTime = jsonMap['pelatihan_time'];
    kenaikanProduktivitas = jsonMap['kenaikan_produktivitas'];
    kepuasan = jsonMap['kepuasan'];
    kpiDate = jsonMap['kpi_date'];
    idpReady = int.parse(jsonMap['idp_ready'].toString());
    idpStart = int.parse(jsonMap['idp_start'].toString());
  }

  KPI(
      {required this.karyawanName,
      required this.reqruitmentTime,
      required this.evaluationValue,
      required this.kpiDate,
      required this.pelatihanTime,
      required this.kenaikanProduktivitas,
      required this.kepuasan,
      required this.idpReady,
      required this.idpStart});
}
