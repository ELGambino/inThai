import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'phone_verification_screen.dart'; // Import the phone verification screen
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'signup_screen.dart'; // Import the signup screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();

  void _loginWithPhoneNumber() async {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your phone number.')),
      );
      return;
    }

    final phoneNumberData = {
      "phoneNumber": _phoneController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('https://inthai-backend.dev.codepred.pl/account/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(phoneNumberData),
      );

      if (response.statusCode == 200) {
        Future.delayed(Duration.zero, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhoneVerificationScreen(
                phoneNumber: _phoneController.text,
                userData: {},
              ),
            ),
          );
        });
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to login with phone number. Status code: ${response.statusCode}. Please try again.'),
          ),
        );
      }
    } catch (e) {
      print('Exception occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Failed to login with phone number. Exception: $e. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF39302D), // Dopasuj kolor tła
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.5, 40, 24.5, 36), // Dopasuj margines
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFFF9F0EA)), // Dodaj ikonę strzałki
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 1, 34.4), // Dopasuj margines
                child: Opacity(
                  opacity: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img.png'), // Zaktualizuj ścieżkę do obrazu
                      ),
                    ),
                    width: 137,
                    height: 124,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0), // Dopasuj padding
                child: Text(
                  'Zaloguj się, aby kontynuować',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFF9F0EA), // Dopasuj kolor tekstu
                  ),
                ),
              ),
              SizedBox(height: 50), // Dodaj odstęp między tekstem a polem tekstowym
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.grey, // Dopasuj kolor tekstu
                  ),
                  prefixIcon: SizedBox(
                    width: 20,
                    height: 20,
                      child: Icon(Icons.phone, color: Color(0xFFF9F0EA), size: 20)
                  ),
                  //Icon(Icons.phone, color: Color(0xFFF9F0EA)), // Dodaj ikonę
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFECC6A7), width: 1.0), // Dopasuj kolor i grubość linii
                    borderRadius: BorderRadius.circular(4.0), // Zaokrąglone rogi
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFBE7F27), width: 1.0), // Dopasuj kolor i grubość linii
                    borderRadius: BorderRadius.circular(4.0), // Zaokrąglone rogi
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Dopasuj padding wewnętrzny
                ),
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Color(0xFFF9F0EA)), // Dopasuj kolor tekstu
                textInputAction: TextInputAction.done,
                maxLines: 1,
                minLines: 1,
              ),
              SizedBox(height: 20), // Dodaj odstęp między polem tekstowym a przyciskiem
              ElevatedButton(
                onPressed: _loginWithPhoneNumber,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // Usuń padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0), // Ustaw promień na 0
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFBE7F27), // Kolor początkowy
                        Color(0xFFD7B613), // Kolor końcowy
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 51, // Stała wysokość
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color(0xFFF9F0EA), // Dopasuj kolor tekstu
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Dodaj odstęp między przyciskiem a tekstem
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Nie masz jeszcze konta? ',
                  style: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFF9F0EA),
                  ),
                  children: [
                    TextSpan(
                      text: 'Zarejestruj się',
                      style: GoogleFonts.bitter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xFFBE7F27), // Dopasuj kolor tekstu
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupScreen()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
