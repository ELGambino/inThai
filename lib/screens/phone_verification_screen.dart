import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'admin_screen.dart'; // Import the admin screen
import 'package:shared_preferences/shared_preferences.dart';
import 'client_screens/client_screen.dart'; // Import the client screen

class PhoneVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final Map<String, dynamic> userData;

  const PhoneVerificationScreen({
    Key? key,
    required this.phoneNumber,
    required this.userData,
  }) : super(key: key);

  @override
  _PhoneVerificationScreenState createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  TextEditingController _codeController = TextEditingController();

  void _sendVerificationCode() async {
    final codeData = {
      'phoneNumber': widget.phoneNumber,
      'password': _codeController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('https://inthai-backend.dev.codepred.pl/account/verify'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(codeData),
      );

      // Display response from the server
      print('Response: ${response.body}');
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String jwtToken = data['jwt'];
        print('JWT Token: $jwtToken');

        if (jwtToken.isNotEmpty) {
          // Save the token in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwtToken', jwtToken);

          // Verify the token is saved correctly
          String? savedToken = prefs.getString('jwtToken');
          print('Saved Token: $savedToken');

          if (savedToken != null && savedToken.isNotEmpty) {
            // Navigate to ClientScreen if token is present
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ClientScreen(),
              ),
            );
          } else {
            // Handle case where token is not saved correctly
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to save token. Please try again.'),
              ),
            );
          }
        } else {
          // Handle incorrect password
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Incorrect password. Please try again.'),
            ),
          );
        }
      } else {
        // Handle verification failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to verify phone number. Please try again.'),
          ),
        );
      }
    } catch (e) {
      // Handle network error
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to verify phone number. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF39302D), // Background color
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.5, 40, 24.5, 36), // Adjust padding
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFFF9F0EA)), // Add back arrow icon
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 1, 34.4), // Adjust margin
                child: Opacity(
                  opacity: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img.png'), // Update image path
                      ),
                    ),
                    width: 137,
                    height: 124,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0), // Adjust padding
                child: Text(
                  'Potwierdź swoje konto.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFFF9F0EA), // Text color
                  ),
                ),
              ),
              SizedBox(height: 20), // Add spacing
              Container(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0), // Adjust padding
                child: Text(
                  'Wprowadź kod, który wysłaliśmy na podany numer telefonu.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFF9F0EA), // Text color
                  ),
                ),
              ),
              SizedBox(height: 50), // Add spacing
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(
                  hintText: 'Kod z wiadomości SMS',
                  hintStyle: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.grey, // Hint text color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFECC6A7), width: 1.0), // Border color
                    borderRadius: BorderRadius.circular(4.0), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFBE7F27), width: 1.0), // Focused border color
                    borderRadius: BorderRadius.circular(4.0), // Rounded corners
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Padding inside input
                ),
                keyboardType: TextInputType.text, // Assuming password is text
                obscureText: true, // Hide password characters
                style: TextStyle(color: Color(0xFFF9F0EA)), // Text color
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendVerificationCode,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0), // Set radius to 0
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFBE7F27), // Start color
                        Color(0xFFD7B613), // End color
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 51, // Fixed height
                    child: Text(
                      'Verify',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color(0xFFF9F0EA), // Text color
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
