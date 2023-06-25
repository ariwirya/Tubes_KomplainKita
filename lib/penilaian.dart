import 'package:flutter/material.dart';
import 'package:asesmen3/homepage.dart';

class PenilaianScreen extends StatefulWidget {
  final String username;

  const PenilaianScreen({required this.username});

  @override
  _PenilaianScreenState createState() => _PenilaianScreenState();
}

class _PenilaianScreenState extends State<PenilaianScreen> {
  List<int> selectedOptionIndices = List.filled(5, -1);
  List<String> questions = [
    '1. Bagaimana penilaian Anda secara keseluruhan terhadap kualitas layanan yang diberikan oleh kantor-kantor pelayanan masyarakat desa?',
    '2. Bagaimana penilaian Anda terhadap aksesibilitas layanan yang disediakan oleh kantor-kantor pelayanan masyarakat desa?',
    '3. Seberapa efektif kinerja kantor-kantor pelayanan masyarakat desa dalam memenuhi kebutuhan masyarakat secara umum?',
    '4. Bagaimana penilaian Anda terhadap tingkat profesionalisme dan keramahan staf yang bekerja di kantor-kantor pelayanan masyarakat desa?',
    '5. Bagaimana tingkat kepuasan Anda terhadap ketersediaan sarana dan prasarana yang memadai di kantor-kantor pelayanan masyarakat desa?',
  ];
  List<List<String>> options = [
    ['Baik', 'Cukup', 'Buruk'],
    ['Baik', 'Cukup', 'Buruk'],
    ['Baik', 'Cukup', 'Buruk'],
    ['Baik', 'Cukup', 'Buruk'],
    ['Baik', 'Cukup', 'Buruk'],
  ];
  List<bool> isQuestionAnswered = List.filled(5, false);

  void setSelectedOptionIndex(int index, int questionIndex) {
    setState(() {
      if (selectedOptionIndices[questionIndex] != index) {
        // Jika opsi yang dipilih tidak sama dengan opsi sebelumnya
        selectedOptionIndices[questionIndex] = index;
      } else {
        // Jika opsi yang dipilih sama dengan opsi sebelumnya
        selectedOptionIndices[questionIndex] = -1; // Reset pilihan
      }

      isQuestionAnswered[questionIndex] = selectedOptionIndices[questionIndex] != -1;
    });
  }

  Widget buildQuestion(int index) {
    Widget questionWidget;

    if (index == 0) {
      questionWidget = Column(
        children: [
          SizedBox(height: 10),
          Text(
            questions[index],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else {
      questionWidget = Column(
        children: [
          Text(
            questions[index],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Tambahkan border dengan warna abu-abu
        borderRadius: BorderRadius.circular(8), // Tambahkan radius border
        // Anda dapat menyesuaikan properti lain seperti warna dan lebar border
      ),
      padding: EdgeInsets.all(8), // Atur padding di dalam container
      child: Column(
        children: [
          questionWidget,
          Column(
            children: List.generate(options[index].length, (optionIndex) {
              return RadioListTile<int>(
                value: optionIndex,
                groupValue: selectedOptionIndices[index] == optionIndex ? optionIndex : null,
                onChanged: (value) {
                  setSelectedOptionIndex(value!, index);
                },
                title: Text(options[index][optionIndex]),
              );
            }),
          ),
        ],
      ),
    );
  }

  bool isAllQuestionsAnswered() {
    for (var answered in isQuestionAnswered) {
      if (!answered) {
        return false;
      }
    }
    return true;
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin menyimpan penilaian?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog konfirmasi
                _savePenilaian(); // Panggil metode untuk menyimpan penilaian
              },
              child: Text('Ya'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog konfirmasi
              },
              child: Text('Tidak'),
            ),
          ],
        );
      },
    );
  }

  void _savePenilaian() {
    // Periksa apakah semua pertanyaan telah dijawab sebelum menyimpan
    if (isAllQuestionsAnswered()) {
      // Kode untuk menyimpan penilaian
      // ...

      // Setelah penyimpanan berhasil, navigasi ke halaman utama
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomepageScreen(username: widget.username),
        ),
      );
    } else {
      // Tampilkan pesan validasi jika ada pertanyaan yang belum dijawab
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Harap isi semua pertanyaan sebelum menyimpan penilaian.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog validasi
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penilaian Layanan'),
        automaticallyImplyLeading: false, // Menghilangkan tombol kembali (back button)
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16), // Ubah konfigurasi padding di sini
        child: ListView(
          children: [
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Image.asset('images/penilaian.png'),
            ),
            ListView.builder(
              padding: EdgeInsets.zero, // Hapus padding ListView
              shrinkWrap: true, // Atur shrinkWrap ke true
              physics: NeverScrollableScrollPhysics(), // Nonaktifkan scroll di dalam ListView
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: buildQuestion(index),
                );
              },
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: 200,
                height: 45,
                child: InkWell(
                  onTap: () {
                    _showConfirmationDialog();
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Simpan Penilaian',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
