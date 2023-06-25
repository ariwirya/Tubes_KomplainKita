import 'package:flutter/material.dart';

void main() {
  runApp(BeritaScreen());
}

class BeritaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, // Mengatur warna utama (primary color) menjadi blueGrey
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Berita Desa Terkini'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0), // Menambahkan padding pada body
          child: SingleChildScrollView(
            child: Column(
              children: [
                NewsItem(
                  imageAsset: 'images/news1.jpg',
                  mainDescription: 'Aturan Pemberhentian Perangkat Desa, '
                      '15 Kades Terpilih Tidak Boleh Asal Pecat Perangkat Desa',
                  subDescription: 'Sebab para Kades terpilih tidak memiliki kewenangan penuh untuk pengangkatan maupun pemberhentian perangkat desa, ini dikarenakan sudah dikeluarkannya Perbup terkait kebijakan perangkat desa,'
                      'untuk mengangkat maupun memberhentikan perangkat desa, '
                      'harus mendapat rekomendasi dari masing-masing camat.',
                  mainFontSize: 16.0, // Ukuran font untuk deskripsi utama
                  subFontSize: 14.0, // Ukuran font untuk deskripsi tambahan
                  mainFontWeight: FontWeight.bold, // Ketebalan font untuk deskripsi utama
                  subFontWeight: FontWeight.normal, // Ketebalan font untuk deskripsi tambahan
                ),
                SizedBox(height: 24.0), // Menambahkan jarak antara berita 1 dengan berita 2
                NewsItem(
                  imageAsset: 'images/news2.jpg',
                  mainDescription: 'Calon Kades Dari 27 Desa di Bandung Gelar Deklarasi Pilkades Damai',
                  subDescription: 'Melalui deklarasi Pilkades Damai itu, masyarakat Blora terutama para calon kepala'
                      ' desa berharap dapat mengubah paradigma Pilkades sering kali yang menjadi momen yang memicu tensi politik tinggi, '
                      'perpecahan sosial, dan konflik di tingkat lokal, menjadi Pilkades yang lancar dan damai. Para calon yang ikut dalam P'
                      'ilkades menyampaikan komitmen mereka untuk menjaga sikap yang santun, tidak melakukan kampanye negatif, '
                      'dan berfokus pada visi dan program kerja yang dapat membawa perubahan positif bagi masyarakat desa.',
                  mainFontSize: 16.0, // Ukuran font untuk deskripsi utama
                  subFontSize: 12.0, // Ukuran font untuk deskripsi tambahan
                  mainFontWeight: FontWeight.bold, // Ketebalan font untuk deskripsi utama
                  subFontWeight: FontWeight.normal, // Ketebalan font untuk deskripsi tambahan
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final String imageAsset;
  final String mainDescription;
  final String subDescription;
  final double mainFontSize;
  final double subFontSize;
  final FontWeight mainFontWeight;
  final FontWeight subFontWeight;

  NewsItem({
    required this.imageAsset,
    required this.mainDescription,
    required this.subDescription,
    this.mainFontSize = 14.0,
    this.subFontSize = 12.0,
    this.mainFontWeight = FontWeight.normal,
    this.subFontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            imageAsset,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    mainDescription,
                    style: TextStyle(
                      fontSize: mainFontSize,
                      fontWeight: mainFontWeight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 8.0), // Memberikan jarak antara deskripsi utama dan tambahan
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: subFontSize,
                      fontWeight: subFontWeight,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: subDescription),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}