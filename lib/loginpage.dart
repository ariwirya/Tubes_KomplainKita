import 'package:flutter/material.dart';
import 'package:asesmen3/homepage.dart';
import 'package:asesmen3/profile.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String username = usernameController.text;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomepageScreen(username: username),
        ),
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose(); // Dispose usernameController
    passwordController.dispose(); // Dispose passwordController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    child: Column(
                      children: [
                        Image.asset(
                          'images/logo.png',
                          width: 300,
                          height: 300,
                        ),
                        SizedBox(height: 16),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                          child: TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Kolom ini harus diisi';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    margin: EdgeInsets.only(top: 3),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Kolom ini harus diisi';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _login(context);
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'atau login dengan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 13, top: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            // Login with Google
                          },
                          child: Image.asset(
                            'images/google logo.png',
                            width: 24,
                            height: 24,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 13, top: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            // Login with Facebook
                          },
                          child: Image.asset(
                            'images/facebook logo.png',
                            width: 24,
                            height: 24,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
