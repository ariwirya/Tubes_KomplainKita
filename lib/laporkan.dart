import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(LaporkanScreen());
}

class LaporkanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Laporkan',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController namaController = TextEditingController();
  TextEditingController pekerjaanController = TextEditingController();
  String? selectedDaftarinstansi;
  TextEditingController laporanController = TextEditingController();

  List<String> daftarinstansi = [
    'Kantor Kepala Desa',
    'Kantor Kelurahan',
    'Kantor Polisi',
    'Kantor Pemadam Kebakaran',
    'Kantor BUMDes',
  ];

  @override
  void dispose() {
    namaController.dispose();
    pekerjaanController.dispose();
    laporanController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    String nama_pelapor = namaController.text;
    String pekerjaan_pelapor = pekerjaanController.text;
    String instansi_dilaporkan = selectedDaftarinstansi ?? '';
    String laporan = laporanController.text;

    // Buat Map untuk mengirim data form
    Map<String, dynamic> data = {
      'nama_pelapor': nama_pelapor,
      'pekerjaan_pelapor': pekerjaan_pelapor,
      'instansi_dilaporkan': instansi_dilaporkan,
      'laporan': laporan,
    };

    // Proses pengiriman data form
    final response = await http.post(
      Uri.parse('https://komplainkita.000webhostapp.com/'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Tampilkan Snackbar
      final snackBar = SnackBar(
        content: Text('Laporan telah berhasil dikirim!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Clear the form fields
      namaController.clear();
      pekerjaanController.clear();
      laporanController.clear();
      setState(() {
        selectedDaftarinstansi = null;
      });
    } else {
      // Tampilkan Snackbar
      final snackBar = SnackBar(
        content: Text('Gagal mengirim laporan'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      print('Gagal mengirim laporan: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Laporan'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(10.0, 50.0, 12.0, 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 25.0),
                child: Image.asset('images/alaala.png'),
              ),
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Pelapor',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: pekerjaanController,
                decoration: InputDecoration(
                  labelText: 'Pekerjaan Pelapor',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedDaftarinstansi,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDaftarinstansi = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Daftar Instansi',
                  border: OutlineInputBorder(),
                ),
                items: daftarinstansi.map((organization) {
                  return DropdownMenuItem<String>(
                    value: organization,
                    child: Text(organization),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: laporanController,
                decoration: InputDecoration(
                  labelText: 'Laporan',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
