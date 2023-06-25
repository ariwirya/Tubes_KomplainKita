import 'package:flutter/material.dart';

void main() {
  runApp(AboutScreen());
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Page',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: AboutPage(),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Kami'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Image.asset(
                'images/logo.png',
                width: 300.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'KOMPLAINKITA',
                style: TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Aplikasi KOMPLAINKITA dirancang dengan tujuan untuk '
                    'meningkatkan kualitas hidup di desa dan menciptakan kesejahteraan bagi '
                    'penduduknya. Melalui aplikasi ini, masyarakat dapat dengan mudah melaporkan '
                    'masalah atau keluhan terkait berbagai layanan desa kepada instansi terkait. '
                    'Fitur utama aplikasi ini mencakup pelaporan instansi, di mana pengguna dapat '
                    'menyampaikan keluhan atau masalah yang mereka hadapi, dan laporan ini akan '
                    'diteruskan ke instansi yang bersangkutan untuk ditindaklanjuti.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Image.asset(
                'images/layananmas.jpg',
                width: 1000.0,
                height: 300.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Selain itu, '
                    'aplikasi ini juga menyediakan fitur penilaian layanan untuk menilai'
                    'sebuah layanan instansi, sehingga memberikan kesempatan bagi masyarakat untuk '
                    'berpartisipasi langsung dalam penilaian instansi layanan masyarakat di desa.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 20.0), // Spacing
          ],
        ),
      ),
    );
  }
}
