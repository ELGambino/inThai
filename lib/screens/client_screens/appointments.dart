import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widgets/client_navbar.dart';
import '../auth_helper.dart';
import 'date_selection_screen.dart';
import 'shop_screen.dart';
import 'client_screen.dart';
import 'user_screen.dart';
import 'appointment_details.dart'; // Dodaj import dla strony AppointmentDetails

class AppointmentScreen extends StatefulWidget {
  get selectedMassage => null;

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int _selectedIndex = 2;
  String _clientName = '';
  List<dynamic> _pastAppointments = [];
  List<dynamic> _futureAppointments = [];

  @override
  void initState() {
    super.initState();
    _fetchClientData();
    _fetchAppointments();
    _fetchOrders(); // Dodajemy wywołanie _fetchOrders
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
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserScreen()),
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

  Future<void> _fetchClientData() async {
    //final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE3NDExNTg0LCJleHAiOjE3MTc0OTc5ODR9.uUiAHy6LXQv_43brx7IrdV1Sb4STlMz6kaEMeb9BAz8";    //
    final String? token = await getJwtToken();  // Use the helper method


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

  Future<void> _fetchAppointments() async {
    //final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE3NDExNTg0LCJleHAiOjE3MTc0OTc5ODR9.uUiAHy6LXQv_43brx7IrdV1Sb4STlMz6kaEMeb9BAz8";    //
    final String? token = await getJwtToken();

    if (token != null) {
      try {
        final responseAppointments = await http.get(
          Uri.parse('https://inthai-backend.dev.codepred.pl/user/get-appointments'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        final responseOrders = await http.get(
          Uri.parse('https://inthai-backend.dev.codepred.pl/user/get-orders'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        print('Appointments Response: ${responseAppointments.body}');
        print('Orders Response: ${responseOrders.body}');

        if (responseAppointments.statusCode == 200 && responseOrders.statusCode == 200) {
          final List<dynamic> appointments = jsonDecode(responseAppointments.body);
          final List<dynamic> orders = jsonDecode(responseOrders.body);

          // Przypisanie produktów z zamówień do spotkań
          for (int i = 0; i < appointments.length; i++) {
            if (i < orders.length) {
              appointments[i]['product'] = orders[i]['product'];
            }
          }


          final DateTime now = DateTime.now();

          setState(() {
            _pastAppointments = appointments.where((appointment) {
              DateTime appointmentDateStart = DateTime.parse(appointment['appointmentDateStart']);
              return appointmentDateStart.isBefore(now);
            }).toList();

            _pastAppointments.sort((a, b) =>
                DateTime.parse(b['appointmentDateStart'])
                    .compareTo(DateTime.parse(a['appointmentDateStart'])));

            _futureAppointments = appointments.where((appointment) {
              DateTime appointmentDateStart = DateTime.parse(appointment['appointmentDateStart']);
              return appointmentDateStart.isAfter(now);
            }).toList();

            _futureAppointments.sort((a, b) =>
                DateTime.parse(a['appointmentDateStart'])
                    .compareTo(DateTime.parse(b['appointmentDateStart'])));
          });
        } else {
          // Obsługa błędu odpowiedzi
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load appointments or orders.'),
            ),
          );
        }
      } catch (e) {
        // Obsługa błędu sieciowego
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load appointments or orders.'),
          ),
        );
      }
    } else {
      // Obsługa braku tokenu
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No token found. Please log in again.'),
        ),
      );
    }
  }


  Future<void> _fetchOrders() async {
    //final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE3NDExNTg0LCJleHAiOjE3MTc0OTc5ODR9.uUiAHy6LXQv_43brx7IrdV1Sb4STlMz6kaEMeb9BAz8";    //
    final String? token = await getJwtToken();

    if (token != null) {
      try {
        final response = await http.get(
          Uri.parse('https://inthai-backend.dev.codepred.pl/user/get-orders'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        print('Orders Response: ${response.body}');

        if (response.statusCode == 200) {
          // Tutaj możesz przetwarzać dane odpowiedzi, np. deserializując je z JSON
        } else {
          // Obsługa błędu odpowiedzi
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load orders.'),
            ),
          );
        }
      } catch (e) {
        // Obsługa błędu sieciowego
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load orders.'),
          ),
        );
      }
    } else {
      // Obsługa braku tokenu
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No token found. Please log in again.'),
        ),
      );
    }
  }


  Future<String?> _getJwtToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken');
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment,
      {bool isPast = false}) {
    //final masseurName = appointment['masseur']['firstName']['firstName'];
    final DateTime appointmentDateStart =
    DateTime.parse(appointment['appointmentDateStart']);
    final String formattedTime =
        '${appointmentDateStart.hour}:${appointmentDateStart.minute.toString().padLeft(2, '0')}';
    final String formattedDate =
        '${appointmentDateStart.day.toString().padLeft(2, '0')}.${appointmentDateStart.month.toString().padLeft(2, '0')}.${appointmentDateStart.year.toString().substring(2, 4)}';

    return GestureDetector(
      onTap: () {
        if (!isPast) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AppointmentDetails(appointment: appointment),
            ),
          );
        }
      },

      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(236, 198, 167, 0.2),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isPast)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    //'M: $masseurName',
                    '${appointment['product']}',
                    style: GoogleFonts.bitter(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color.fromRGBO(57, 48, 45, 1),
                    ),
                  ),
                  Icon(Icons.arrow_forward,
                      size: 20, color: Color.fromRGBO(162, 102, 68, 1)),
                ],
              ),
            if (isPast)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${appointment['product']}',
                    style: GoogleFonts.bitter(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color.fromRGBO(57, 48, 45, 1),
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 14,
                              color: Color.fromRGBO(205, 152, 108, 1)),
                          SizedBox(width: 5),
                          Text(formattedTime,
                              style: GoogleFonts.bitter(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color.fromRGBO(205, 152, 108, 1),
                              )),
                        ],
                      ),
                      SizedBox(width: 10),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 14,
                              color: Color.fromRGBO(205, 152, 108, 1)),
                          SizedBox(width: 5),
                          Text(formattedDate,
                              style: GoogleFonts.bitter(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color.fromRGBO(205, 152, 108, 1),
                              )),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            if (!isPast)
              Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getDayOfWeek(appointmentDateStart.weekday),
                          style: GoogleFonts.bitter(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromRGBO(162, 102, 68, 1),
                          ),
                        ),
                        Row(children: [
                          Icon(Icons.access_time,
                              size: 14, color: Color.fromRGBO(162, 102, 68, 1)),
                          SizedBox(width: 5),
                          Text(formattedTime,
                              style: GoogleFonts.bitter(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color.fromRGBO(162, 102, 68, 1),
                              )),
                          SizedBox(width: 10),
                          Icon(Icons.calendar_today,
                              size: 14, color: Color.fromRGBO(162, 102, 68, 1)),
                          SizedBox(width: 5),
                          Text(formattedDate,
                              style: GoogleFonts.bitter(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color.fromRGBO(162, 102, 68, 1),
                              )),
                        ]),
                      ],
                    ),
                  ]
              )
            else if (isPast) ...[
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  String selectedMassage;
                  switch (appointment['product']) {
                    case 'Tajski-1h':
                      selectedMassage = 'Thai Massage 1';
                      break;
                    case 'Klasyczny-2h':
                      selectedMassage = 'Classic Massage 2';
                      break;
                    case 'Tajski-2h':
                      selectedMassage = 'Thai Massage 2';
                      break;
                    case 'Klasyczny-1h':
                      selectedMassage = 'Classic Massage 1';
                      break;
                    case 'Shiatsu-1h':
                      selectedMassage = 'Shiatsu Massage 1';
                      break;
                    case 'Shiatsu-2h':
                      selectedMassage = 'Shiatsu Massage 2';
                      break;
                    default:
                      selectedMassage = ''; // W przypadku innych rodzajów masażu
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DateSelectionScreen(selectedMassage: selectedMassage, massageName: selectedMassage),
                    ),
                  );
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          'UMÓW PONOWNIE   ',
                          style: GoogleFonts.cinzel(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color(0xFFF9F0EA),
                          ),
                        ),
                        Icon(Icons.arrow_forward,
                            color: Color(0xFFF9F0EA), size: 20),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ],
        ),
      ),
    );
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Poniedziałek';
      case 2:
        return 'Wtorek';
      case 3:
        return 'Środa';
      case 4:
        return 'Czwartek';
      case 5:
        return 'Piątek';
      case 6:
        return 'Sobota';
      case 7:
        return 'Niedziela';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 251, 248, 1),
      appBar: AppBar(
        title: Text('Client Panel'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.5, 40, 24.5, 36),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Text(
                  '  Następne wizyty:',
                  style: GoogleFonts.cinzel(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Color(0xFF39302D),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _futureAppointments.length,
                itemBuilder: (context, index) {
                  final appointment = _futureAppointments[index];
                  return _buildAppointmentCard(appointment);
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Text(
                  '  Ostatnie wizyty:',
                  style: GoogleFonts.cinzel(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Color(0xFF39302D),
                  ),

                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _pastAppointments.length,
                itemBuilder: (context, index) {
                  final appointment = _pastAppointments[index];
                  return _buildAppointmentCard(appointment, isPast: true);
                },
              ),
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
