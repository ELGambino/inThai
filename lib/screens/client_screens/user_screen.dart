import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:in_thai_mobile/screens/client_screens/appointments.dart';
import 'package:in_thai_mobile/screens/client_screens/shop_screen.dart';
import 'dart:convert';

import '../../widgets/client_navbar.dart';
import '../auth_helper.dart';
import 'client_screen.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Map<String, dynamic>? _userData;
  bool _isLoading = false;
  int _selectedIndex = 3;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _buildingNumberController = TextEditingController();
  TextEditingController _apartmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    // Zwalnianie kontrolerów
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _countryController.dispose();
    _regionController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _streetController.dispose();
    _buildingNumberController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShopScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AppointmentScreen()),
        );
        break;
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClientScreen()),
        );
        break;
    }
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
    });
    //final String? token = await getJwtToken();  // Use the helper method
    final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE3NDExNTg0LCJleHAiOjE3MTc0OTc5ODR9.uUiAHy6LXQv_43brx7IrdV1Sb4STlMz6kaEMeb9BAz8";    //


    if (token != null) {
      try {
        final response = await http.get(
          Uri.parse('https://inthai-backend.dev.codepred.pl/user/me'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        print('Response: ${response.body}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            _userData = data;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load user data.'),
            ),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load user data.'),
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No token found. Please log in again.'),
        ),
      );
    }
  }

  Future<void> _updateUserData() async {
    if (_userData != null) {
      if (_firstNameController.text.isEmpty ||
          _lastNameController.text.isEmpty ||
          _countryController.text.isEmpty ||
          _regionController.text.isEmpty ||
          _cityController.text.isEmpty ||
          _postalCodeController.text.isEmpty ||
          _streetController.text.isEmpty ||
          _buildingNumberController.text.isEmpty ||
          _apartmentController.text.isEmpty ||
          _phoneNumberController.text.isEmpty ||
          _emailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill in all fields.'),
          ),
        );
        return;
      }
      try {
        //final String? token = await getJwtToken();  // Use the helper method

        final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE3NDExNTg0LCJleHAiOjE3MTc0OTc5ODR9.uUiAHy6LXQv_43brx7IrdV1Sb4STlMz6kaEMeb9BAz8";    //


        final response = await http.put(
          Uri.parse(
              'https://inthai-backend.dev.codepred.pl/user/update-user-data'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'firstName': _firstNameController.text,
            'lastName': _lastNameController.text,
            'address': {
              'country': _countryController.text,
              'region': _regionController.text,
              'city': _cityController.text,
              'postal_code': _postalCodeController.text,
              'streetName': _streetController.text,
              'buildingNumber': _buildingNumberController.text,
              'apartment': _apartmentController.text,
            },
            'phoneNumber': _phoneNumberController.text,
            'email': _emailController.text,
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User data updated successfully.'),
            ),
          );
        } else {
          print('Failed to update user data.');
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update user data.'),
            ),
          );
        }
      } catch (e) {
        print('Exception occurred: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update user data.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User data is not available.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _fetchUserData();
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _userData != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Information',
                          style: GoogleFonts.cinzel(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Color(0xFF39302D),
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildUserDataField(
                            'First Name', _userData!['firstName']['firstName'],
                            editable: true, controller: _firstNameController),
                        _buildUserDataField(
                            'Last Name', _userData!['lastName']['lastName'],
                            editable: true, controller: _lastNameController),
                        _buildUserDataField(
                            'Email (not editable)', _userData!['userEmail']['userEmail'],
                            editable: false, controller: _emailController),
                        _buildUserDataField('Phone Number (not editable)',
                            _userData!['phoneNumber']['phoneNumber'],
                            editable: false,
                            controller: _phoneNumberController),
                        _buildUserDataField(
                            'Country', _userData!['address']['country'],
                            editable: true, controller: _countryController),
                        _buildUserDataField(
                            'Region', _userData!['address']['region'],
                            editable: true, controller: _regionController),
                        _buildUserDataField(
                            'City', _userData!['address']['city'],
                            editable: true, controller: _cityController),
                        _buildUserDataField(
                            'Postal Code', _userData!['address']['postal_code'],
                            editable: true, controller: _postalCodeController),
                        _buildUserDataField(
                            'Street', _userData!['address']['streetName'],
                            editable: true, controller: _streetController),
                        _buildUserDataField('Building Number',
                            _userData!['address']['buildingNumber'],
                            editable: true,
                            controller: _buildingNumberController),
                        _buildUserDataField(
                            'Apartment', _userData!['address']['apartment'],
                            editable: true, controller: _apartmentController),
                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            _updateUserData();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFBE7F27),
                                  Color(0xFFD7B613),
                                ],
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 51,
                              child: Text(
                                'Update User Data',
                                style: GoogleFonts.cinzel(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: Color(0xFFF9F0EA),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Text('User data is not available.'),
                ),
      bottomNavigationBar: ClientNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildUserDataField(String label, dynamic value,
      {bool editable = false, required TextEditingController controller}) {
    controller.text = value.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.bitter(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Color.fromRGBO(57, 48, 45, 1),
          ),
        ),
        SizedBox(height: 4),
        TextFormField(
          style: GoogleFonts.bitter(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.brown,
          ),
          controller: controller,
          readOnly: !editable,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromRGBO(236, 198, 167, 0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            setState(() {
// Aktualizacja wartości w stanie komponentu po wprowadzeniu zmian przez użytkownika
              switch (label) {
                case 'First Name':
                  _userData!['firstName']['firstName'] = value;
                  break;
                case 'Last Name':
                  _userData!['lastName']['lastName'] = value;
                  break;
                case 'Country':
                  _userData!['address']['country'] = value;
                  break;
                case 'Region':
                  _userData!['address']['region'] = value;
                  break;
                case 'City':
                  _userData!['address']['city'] = value;
                  break;
                case 'Postal Code':
                  _userData!['address']['postal_code'] = value;
                  break;
                case 'Street':
                  _userData!['address']['streetName'] = value;
                  break;
                case 'Building Number':
                  _userData!['address']['buildingNumber'] = value;
                  break;
                case 'Apartment':
                  _userData!['address']['apartment'] = value;
                  break;

// Dodaj pozostałe przypadki dla kolejnych pól
              }
            });
          },
        ),
        SizedBox(height: 6),
      ],
    );
  }
}
