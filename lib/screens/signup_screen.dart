import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'phone_verification_screen.dart'; // Import the phone verification screen
import 'login_screen.dart'; // Import the login screen

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingNumberController =
      TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _sendVerificationCode() async {
    if (_nameController.text.isEmpty ||
        _surnameController.text.isEmpty ||
        _countryController.text.isEmpty ||
        _regionController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _postalCodeController.text.isEmpty ||
        _streetController.text.isEmpty ||
        _buildingNumberController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the fields.')),
      );
      return;
    }
    if (_phoneController.text.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Phone number must be at least 9 characters long.')),
      );
      return;
    }

    final userData = {
      'firstName':  _nameController.text,
      'lastName': _surnameController.text,
      'address': {
        'streetName': _streetController.text,
        'buildingNumber': _buildingNumberController.text,
        'apartment': _apartmentController.text,
        'postal_code': _postalCodeController.text,
        'city': _cityController.text,
        'country': _countryController.text,
        'region': _regionController.text,

      },
      'phoneNumber':  _phoneController.text,
      'email':  _emailController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(
            'https://inthai-backend.dev.codepred.pl/account/create-client'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PhoneVerificationScreen(
                    phoneNumber: _phoneController.text,
                    userData: userData,
                  )),
        );
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to create user. Status code: ${response.statusCode}. Please try again.')),
        );
      }
    } catch (e) {
      print('Exception occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Failed to create user. Exception: $e. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF39302D),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.5, 40, 24.5, 36),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFFF9F0EA)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 1, 34.4),
                child: Opacity(
                  opacity: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img.png'),
                      ),
                    ),
                    width: 137,
                    height: 124,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Text(
                  'Zarejestruj się, aby kontynuować',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFF9F0EA),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFA3A3A3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                style: TextStyle(color: Color(0xFFA3A3A3)),
                textInputAction: TextInputAction.done,
                maxLines: 1,
                minLines: 1,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _surnameController,
                decoration: InputDecoration(
                  hintText: 'Surname',
                  hintStyle: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFA3A3A3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                style: TextStyle(color: Color(0xFFA3A3A3)),
                textInputAction: TextInputAction.done,
                maxLines: 1,
                minLines: 1,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(
                  hintText: 'Country',
                  hintStyle: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFA3A3A3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                style: TextStyle(color: Color(0xFFA3A3A3)),
                textInputAction: TextInputAction.done,
                maxLines: 1,
                minLines: 1,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _regionController,
                decoration: InputDecoration(
                  hintText: 'Region',
                  hintStyle: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFA3A3A3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                style: TextStyle(color: Color(0xFFA3A3A3)),
                textInputAction: TextInputAction.done,
                maxLines: 1,
                minLines: 1,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  hintText: 'City',
                  hintStyle: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFA3A3A3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                style: TextStyle(color: Color(0xFFA3A3A3)),
                textInputAction: TextInputAction.done,
                maxLines: 1,
                minLines: 1,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _postalCodeController,
                decoration: InputDecoration(
                  hintText: 'Postal Code',
                  hintStyle: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFA3A3A3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                style: TextStyle(color: Color(0xFFA3A3A3)),
                textInputAction: TextInputAction.done,
                maxLines: 1,
                minLines: 1,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(
                  hintText: 'Street',
                  hintStyle: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFA3A3A3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                style: TextStyle(color: Color(0xFFA3A3A3)),
                textInputAction: TextInputAction.done,
                maxLines: 1,
                minLines: 1,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _buildingNumberController,
                decoration: InputDecoration(
                  hintText: 'Building Number',
                  hintStyle: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFA3A3A3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                style: TextStyle(color: Color(0xFFA3A3A3)),
                textInputAction: TextInputAction.done,
                maxLines: 1,
                minLines: 1,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _apartmentController,
                decoration: InputDecoration(
                  hintText: 'Apartment',
                  hintStyle: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFA3A3A3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                style: TextStyle(color: Color(0xFFA3A3A3)),
                textInputAction: TextInputAction.done,
                maxLines: 1,
                minLines: 1,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFA3A3A3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                style: TextStyle(color: Color(0xFFA3A3A3)),
                textInputAction: TextInputAction.done,
                maxLines: 1,
                minLines: 1,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  hintText: 'Phone',
                  hintStyle: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFA3A3A3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                style: TextStyle(color: Color(0xFFA3A3A3)),
                textInputAction: TextInputAction.done,
                maxLines: 1,
                minLines: 1,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _sendVerificationCode,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // Usuń padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(0.0), // Ustaw promień na 0
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
                      'ZAREJESTRUJ SIĘ',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color(0xFFF9F0EA), // Dopasuj kolor tekstu
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  style: GoogleFonts.bitter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFFF9F0EA),
                  ),
                  children: [
                    TextSpan(
                      text: 'Log in',
                      style: GoogleFonts.bitter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xFFBE7F27),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
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
