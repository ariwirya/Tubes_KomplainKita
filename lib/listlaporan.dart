import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListlaporanScreen extends StatefulWidget {
  @override
  _ListlaporanScreenState createState() => _ListlaporanScreenState();
}

class _ListlaporanScreenState extends State<ListlaporanScreen> {
  List<dynamic> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://komplainkita.000webhostapp.com'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;

      // Filter data dengan nama instansi "Kantor Kepala Desa"
      final filteredData = jsonData.where((data) => data['instansi_dilaporkan'] == 'Kantor Kepala Desa').toList();

      setState(() {
        dataList = filteredData;
      });
    } else {
      print('Gagal mendapatkan data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Laporan Kantor Kepala Desa'),
        automaticallyImplyLeading: false, // Menghilangkan tombol back
      ),
      body: dataList.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final data = dataList[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                data['nama_pelapor'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Pekerjaan Pelapor: ${data['pekerjaan_pelapor']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Laporan atau Keluhan: ${data['laporan']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
