// import 'package:flutter/material.dart';
// import 'package:quran_connect/components/home_screen.dart'; // Pastikan ini ada!

// class AuthScreen extends StatefulWidget {
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isSignup = true;

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_isSignup ? 'Quran-Connect' : 'Quran-Connect'),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//         ),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Image.asset(
//                   'lib/assets/quran-1.png',
//                   height: 200,
//                 ),
//                 SizedBox(height: 30),
//                 Text(
//                   _isSignup ? 'Sign Up' : 'Sign In',
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 30),
//                 // Email field container
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       hintText: 'Email',
//                       hintStyle: TextStyle(color: Colors.black54),
//                       contentPadding:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                       border: InputBorder.none,
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Password field container
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       hintText: 'Password',
//                       hintStyle: TextStyle(color: Colors.black54),
//                       contentPadding:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                       border: InputBorder.none,
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your password';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 // Elevated Button
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       // After form validation, navigate to HomeScreen
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => HomeScreen()),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromARGB(255, 0, 124, 112),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                     minimumSize: Size(double.infinity, 50),
//                   ),
//                   child: Text(
//                     _isSignup ? 'Register' : 'Login',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 // Toggle between sign-up and sign-in
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       _isSignup = !_isSignup;
//                     });
//                   },
//                   child: Text(
//                     _isSignup
//                         ? 'Already have an account? Sign In'
//                         : 'Don’t have an account? Sign Up',
//                     style: TextStyle(color: Colors.black87, fontSize: 14),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_connect/components/home_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSignup = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isSignup ? 'Quran-Connect' : 'Quran-Connect',
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
      body: Form(
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
                // Email field container
                Container(
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
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: GoogleFonts.poppins(color: Colors.black54),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Password field container
                Container(
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
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: GoogleFonts.poppins(color: Colors.black54),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30),
                // Elevated Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Skip user validation and navigate to HomeScreen directly
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 124, 112),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
                // Toggle between sign-up and sign-in
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
}
