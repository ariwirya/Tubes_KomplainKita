import 'package:flutter/material.dart';
import 'package:asesmen3/loginpage.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: ProfilePage(
        username: username,
        onLogout: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final String username;
  final VoidCallback onLogout;

  ProfilePage({required this.username, required this.onLogout});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _password = "****";
  String _newPassword = "";
  bool _isEditingPassword = false;
  bool _isSaving = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 120),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundImage: AssetImage('images/aku.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  widget.username,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                _isEditingPassword ? _buildPasswordTextField() : _buildEditPasswordButton(),
                SizedBox(height: 10),
                _isEditingPassword ? _buildSaveButton() : SizedBox(),
                SizedBox(height: 10),
                _isSaving ? CircularProgressIndicator() : SizedBox(),
                SizedBox(height: 20),
                _buildLogoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditPasswordButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _isEditingPassword = true;
            });
          },
          child: Center(
            child: Text(
              'Ganti Password',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Container(
        width: 300,
        height: 50,
        child: TextField(
          onChanged: (value) {
            setState(() {
              _newPassword = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Password Baru',
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          if (_newPassword.isEmpty) {
            _showSnackbar("Password tidak boleh kosong");
          } else {
            setState(() {
              _isSaving = true;
              _password = _newPassword;
              _isEditingPassword = false;
              _newPassword = "";
              _isSaving = false;
              _showSnackbar("Password anda berhasil diperbarui");
            });
          }
        },
        child: SizedBox(
          width: double.infinity,
          child: Text(
            'Simpan Password',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return _isEditingPassword ? SizedBox() : Container(
      margin: EdgeInsets.only(top: 10),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Konfirmasi Logout'),
                    content: Text('Apakah anda yakin ingin logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Ya'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('Tidak'),
                      ),
                    ],
                  );
                },
              ).then((value) {
                if (value == true) {
                  widget.onLogout(); // Panggil fungsi onLogout saat logout dikonfirmasi
                }
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            child: Text('Logout'),
          ),
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
