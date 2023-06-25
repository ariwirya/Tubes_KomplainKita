class Komplain {
  final int id_pelapor;
  final String nama_pelapor;
  final String pekerjaan_pelapor;
  final String instansi_dilaporkan;
  final String laporan;

  Komplain({required this.id_pelapor, required this.nama_pelapor, required this.pekerjaan_pelapor, required this.instansi_dilaporkan, required this.laporan});

  factory Komplain.fromJson(Map<String, dynamic> json) {
    return Komplain(
      id_pelapor: json['id_pelapor'],
      nama_pelapor: json['nama_pelapor'],
      pekerjaan_pelapor: json['pekerjaan_pelapor'],
      instansi_dilaporkan: json['instansi_dilaporkan'],
      laporan: json['laporan'],
    );
  }
}