import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https; 
import 'package:venue_drive/CommonFiles/common.dart';
import 'package:venue_drive/dashboard.dart';

void main() {
  runApp(const LoginScreen());
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

 Future<void> _login(String email, String password, BuildContext context) async {
  try {
    var url = "$baseUrl/loginUser";
    var response = await https.post(
      Uri.parse(url),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    // ignore: use_build_context_synchronously
    HideLoader(context);

    if  (response.statusCode == 200) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Login Successful')),
  );
  
  // Navigate to SelectClubScreen after showing the snackbar
  Future.delayed(const Duration(seconds: 1), () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  });
    } else {
      // Show popup for other errors (e.g., wrong password, network error)
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Incorrect email or password. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  } catch (e) {
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Network Error'),
        content: const Text('Please check your internet connection and try again.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF000000),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.fitWidth,
                  width: 250,
                  alignment: Alignment.topCenter,
                ),
                const SizedBox(height: 10),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) => email = value,
                  decoration: InputDecoration(
                    labelText: 'Email or username',
                    labelStyle: const TextStyle(color: Colors.white),
                    hintText: 'Enter your full name',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                PasswordField(onChanged: (value) => password = value),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Sign In'),
                  onPressed: () {
                    _login(email, password, context);
                    ShowLoader(context); // Call login method on button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    minimumSize: const Size(375, 40),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
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

class PasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const PasswordField({Key? key, required this.onChanged}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      onChanged: widget.onChanged,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(color: Colors.white),
        hintText: 'Enter your password',
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
    );
  }
}
