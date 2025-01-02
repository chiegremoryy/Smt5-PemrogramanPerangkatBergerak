import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_connect/components/home_screen.dart';
import 'package:quran_connect/components/user_dao.dart';
import 'package:quran_connect/models/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Tambahan untuk loader
import 'package:crypto/crypto.dart'; // Untuk hashing password
import 'dart:convert'; // Untuk utf8.encode

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSignup = true;
  bool _isLoading = false; // Loader state
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserDao _userDao = UserDao();

  // Fungsi hashing password
  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quran-Connect',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: _isLoading
          ? Center(
              child: SpinKitFadingCircle(color: Colors.green, size: 50.0),
            )
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Image.asset(
                        'lib/assets/quran-1.png',
                        height: 200,
                      ),
                      SizedBox(height: 30),
                      Text(
                        _isSignup ? 'Sign Up' : 'Sign In',
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      _buildTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'Invalid email format';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 124, 112),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(
                          _isSignup ? 'Register' : 'Login',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isSignup = !_isSignup;
                          });
                        },
                        child: Text(
                          _isSignup
                              ? 'Already have an account? Sign In'
                              : 'Don’t have an account? Sign Up',
                          style: GoogleFonts.poppins(
                              color: Colors.black87, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(color: Colors.black54),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          border: InputBorder.none,
        ),
        validator: validator,
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text;
      final hashedPassword = _hashPassword(_passwordController.text);

      if (_isSignup) {
        final newUser = User(email: email, password: hashedPassword);
        await _userDao.insertUser(newUser);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        final user = await _userDao.getUser(email, hashedPassword);
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid email or password')),
          );
        }
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}
