import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widgets/client_navbar.dart';
import 'date_selection_screen.dart';
import 'shop_screen.dart';
import 'appointments.dart';
import 'user_screen.dart';
import '../auth_helper.dart'; // Import the auth helper

class ClientScreen extends StatefulWidget {
  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  int _selectedIndex = 0;
  String _clientName = '';
  int _rewardPoints = 0; // Zmienna do przechowywania punktów

  @override
  void initState() {
    super.initState();
    _fetchClientData();
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
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserScreen()),
        );
        break;
    }
  }

  Future<void> _fetchClientData() async {
    final String? token = await getJwtToken();  // Use the helper method
    //final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE3NDExNTg0LCJleHAiOjE3MTc0OTc5ODR9.uUiAHy6LXQv_43brx7IrdV1Sb4STlMz6kaEMeb9BAz8";    //

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
            _clientName = data['firstName']['firstName'] ?? 'Client';
            _rewardPoints = data['rewardPoints'] ?? 0;
          });
        } else {
          // Handle error response
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load client data.'),
            ),
          );
        }
      } catch (e) {
        // Handle network error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load client data.'),
          ),
        );
      }
    } else {
      // Handle missing token
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No token found. Please log in again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ustaw kolor tła na biały
      body: SingleChildScrollView(
        // Umożliwienie przewijania całej strony
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.5, 70, 24.5, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cześć, $_clientName',
                style: GoogleFonts.cinzel(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Color(0xFF39302D), // Kolor tekstu
                ),
              ),
              SizedBox(height: 20), // Dodaj odstęp między tekstem a przyciskami
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShopScreen()),
                  );
                }, // Dodaj funkcję do obsługi przycisku
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
                      'Szybka rezerwacja',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color(0xFFF9F0EA), // Dopasuj kolor tekstu
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Dodaj odstęp między przyciskami
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppointmentScreen()),
                  );
                }, // Dodaj funkcję do obsługi przycisku
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
                      'Ostatnie wizyty',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color(0xFFF9F0EA), // Dopasuj kolor tekstu
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Dodaj odstęp między przyciskami
              Divider(
                color: Color.fromRGBO(236, 198, 167, 0.4), // Kolor linii
                thickness: 1.0, // Grubość linii
                indent: 0.0, // Odstęp od lewej krawędzi
                endIndent: 0.0, // Odstęp od prawej krawędzi
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(236, 198, 167, 0.4),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Twoje punkty:',
                        style: GoogleFonts.cinzel(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color(0xFF39302D), // Dopasuj kolor tekstu
                        ),
                      ),
                      SizedBox(height: 10),
                      // Dodaj odstęp między tekstem a liczbą punktów
                      SizedBox(
                        width: double.infinity,
                        child: Container(
//bottom text
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white, // Ustaw kolor tła na biały
                          ),
                          child: Row(
                            children: [
                              Text(
                                '$_rewardPoints ',
                                style: GoogleFonts.bitter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 27,
                                  color:
                                      Color(0xFF39302D), // Dopasuj kolor tekstu
                                ),
                              ),
                              Text(
                                'punktów',
                                style: GoogleFonts.bitter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 23,
                                  color:
                                      Color(0xFF39302D), // Dopasuj kolor tekstu
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_rewardPoints >= 500) ...[
                SizedBox(height: 20),
                Text(
                  'Dostępnę nagrody:',
                  style: GoogleFonts.cinzel(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Color(0xFF39302D),
                  ),
                ),
                SizedBox(height: 10),
                MassageCard(
                  title: 'Thai Massage',
                  price: '500 pkt',
                  duration: '50',
                  imageAsset: 'assets/massage_2.jpg',
                  massageName: 'Thai Massage pkt 1', // Dodanie nazwy masażu
                ),
                SizedBox(height: 10),
                MassageCard(
                  title: 'Classic Massage',
                  price: '500 zł',
                  duration: '50',
                  imageAsset: 'assets/massage_2.jpg',
                  massageName: 'Classic Massage pkt 1', // Dodanie nazwy masażu
                ),
                SizedBox(height: 10),
                MassageCard(
                  title: 'Shiatsu Massage',
                  price: '250 zł',
                  duration: '50',
                  imageAsset: 'assets/massage_2.jpg',
                  massageName: 'Shiatsu Massage pkt 1', // Dodanie nazwy masażu
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClientNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
