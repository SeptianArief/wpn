List<String> divisionData = [
  'Office Departement',
  'Production Departement',
  'Forestry Departement',
  'Logistik Departement',
  'Mechanic Departement',
  'Scaller'
];

List<List<String>> positionData = [
  [
    'Camp Manager',
    'Keuangan',
    'Kantin',
    'Humas',
    'Juru Masak',
    'Bagian Umum',
    'Ka Logpond',
    'Pembantu Dapur',
    'Umum',
    'Boomstik',
    'Mantri Camp'
  ],
  [
    'Mandor Hauling',
    'Mandor Produksi',
    'Driver Truk',
    'Operator Loader',
    'Operator Excavator',
    'Driver Mobil Kecil',
    'Operator Chainsaw',
    'Operator Tractor',
    'Help Trac Rally',
    'Driver Logging',
    'Help Logging',
    'Kupas Kulit',
    'Operator Engkel',
    'Operator Louder',
    'Helper Loader',
    'Helper Excavator',
    'Helper Chainsaw',
    'Operator Treming',
    'Helper Tractor',
    'Helper Dozer',
  ],
  ['Logistik', 'BBM', 'Time Keeper'],
  [
    'Mekanik',
    'Welder',
    'Operator Genset',
    'Assistant Welder',
    'Assistant Mekanik'
  ],
  [
    'Scaller',
    'Ka Tuk',
  ]
];

List<String> statusMasterData = ['Bulanan', 'Borongan'];

List<String> educationMasterData = [
  'SD',
  'SMP',
  'SMA / SMK',
  'S-1',
  'S-2',
  'S-3'
];

List<String> familyStatusMasterData = [
  'BK',
  'K0',
  'K1',
  'K2',
  'K3',
  'K4',
  'K5'
];

List<String> religionMasterData = ['Islam', 'Kristen', 'Hindu', 'Budha'];

class KaryawanModel {
  late int id;
  late String name;
  late int division;
  late int position;
  late int status;
  late String nik;
  late String ttl;
  late String startWork;
  late int pendidikan;
  late int agama;
  late int familyStatus;
  late String keterangan;

  KaryawanModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    division = jsonMap['division'];
    position = jsonMap['position'];
    status = jsonMap['status'];
    nik = jsonMap['nik'];
    ttl = jsonMap['tempat_lahir'] + ', ' + jsonMap['tanggal_lahir'];
    startWork = jsonMap['start_work'];
    pendidikan = jsonMap['pendidikan'];
    agama = jsonMap['agama'];
    familyStatus = jsonMap['family_status'];
    keterangan = jsonMap['keterangan'];
  }

  KaryawanModel(
      {required this.id,
      required this.name,
      required this.division,
      required this.position,
      required this.status,
      required this.nik,
      required this.ttl,
      required this.startWork,
      required this.pendidikan,
      required this.agama,
      required this.familyStatus,
      required this.keterangan});
}
