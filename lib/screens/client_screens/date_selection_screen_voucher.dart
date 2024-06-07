import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../auth_helper.dart'; // Import the auth helper
import '../webview_screen.dart'; // Import the WebViewScreen
import 'appointments.dart';

class DateSelectionScreenVoucher extends StatefulWidget {
  final String selectedMassage;
  final String massageName;
  final String voucherType;
  final String name;
  final String surname;
  final String country;
  final String region;
  final String city;
  final String postalCode;
  final String street;
  final String buildingNumber;
  final String apartment;
  final String email;
  final String phone;


  const DateSelectionScreenVoucher(
      {Key? key, required this.selectedMassage, required this.massageName, required this.voucherType, required this.name, required this.surname, required this.country, required this.region, required this.city, required this.postalCode, required this.street, required this.buildingNumber, required this.apartment, required this.email, required this.phone})
      : super(key: key);

  @override
  _DateSelectionScreenVoucherState createState() => _DateSelectionScreenVoucherState();
}

class _DateSelectionScreenVoucherState extends State<DateSelectionScreenVoucher> {
  late DateTime _selectedDate;
  late int _massageDuration;
  late List<int> _availableHours;
  int? _selectedHour;
  List<dynamic> _masseurs = [];
  dynamic _selectedMasseur;

  @override
  void initState() {
    super.initState();
    _fetchMasseurs();
    _selectedDate = DateTime.now();
    _massageDuration = widget.selectedMassage.endsWith('2') ? 2 : 1;
    _initializeAvailableHours();
    _selectedHour = _availableHours.isNotEmpty ? _availableHours.first : null;
    //_checkAvailableHours();
  }

  void _initializeAvailableHours() {
    final now = DateTime.now();
    _availableHours = List<int>.generate(
        9, (index) => index + 12); // Lista godzin od 12 do 20

    if (_selectedDate.isSameDate(now)) {
      // Jeśli wybrany dzień to dzisiaj, usuń wcześniejsze godziny
      _availableHours.removeWhere((hour) => hour <= now.hour);
    }

    if (_massageDuration == 2) {
      _availableHours
          .remove(20); // Usunięcie godziny 20:00 jeśli masaż trwa 2 godziny
    }

    _selectedHour = _availableHours.isNotEmpty ? _availableHours.first : null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _initializeAvailableHours(); // Aktualizacja listy dostępnych godzin
      });
      await _checkAvailableHours();
    }
  }

  Future<void> _fetchMasseurs() async {
    final String? token = await getJwtToken();
    //final String? token =
    //   "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE3NDExNTg0LCJleHAiOjE3MTc0OTc5ODR9.uUiAHy6LXQv_43brx7IrdV1Sb4STlMz6kaEMeb9BAz8";

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No token found. Please log in again.'),
        ),
      );
      return;
    }

    final Uri url =
    Uri.parse('https://inthai-backend.dev.codepred.pl/user/get-masseurs');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _masseurs = jsonDecode(response.body);
        if (_masseurs.isNotEmpty) {
          _selectedMasseur =
              _masseurs.first; // Automatycznie wybierz pierwszą masażystkę
          _initializeAvailableHours();
          _checkAvailableHours();
        }
        print('Fetched masseurs: $_masseurs');
      });
    } else {
      print('Failed to fetch masseurs, status code: ${response.statusCode}');
    }
  }

  Future<void> _checkAvailableHours() async {
    final String? token = await getJwtToken();
    //final String? token =
    //    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE3NDExNTg0LCJleHAiOjE3MTc0OTc5ODR9.uUiAHy6LXQv_43brx7IrdV1Sb4STlMz6kaEMeb9BAz8";

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No token found. Please log in again.'),
        ),
      );
      return;
    }

    if (_selectedMasseur == null) {
      print('No masseur selected.');
      return;
    }

    List<int> availableHours = [];

    for (int hour in _availableHours) {
      final String formattedDateTime =
          '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}T${hour.toString().padLeft(2, '0')}:00:00';
      final Uri url = Uri.parse(
          'https://inthai-backend.dev.codepred.pl/user/is-already-booked');
      final String masseurDataJson = jsonEncode(_selectedMasseur);

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'localDateTime': formattedDateTime,
          'masseur': _selectedMasseur,
        }),
      );

      print(
          'Checking availability for $hour:00 and masseur: $_selectedMasseur');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final bool isBooked = jsonDecode(response.body) as bool;
          if (!isBooked) {
            availableHours.add(hour);
          }
        } catch (e) {
          print('Error decoding response: $e');
        }
      } else if (response.statusCode == 401) {
        print('Unauthorized request. Please check your token.');
      } else {
        print(
            'Failed to check availability for $hour:00, status code: ${response.statusCode}');
      }
    }

    setState(() {
      _availableHours = availableHours;
      if (_availableHours.isNotEmpty) {
        _selectedHour = _availableHours.first;
      } else {
        _selectedHour = null;
      }
    });
  }

  Future<void> _postAppointment() async {
    final String? token = await getJwtToken();
    //final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE3NDExNTg0LCJleHAiOjE3MTc0OTc5ODR9.uUiAHy6LXQv_43brx7IrdV1Sb4STlMz6kaEMeb9BAz8";

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No token found. Please log in again.'),
        ),
      );
      return;
    }

    if (_selectedHour == null) {
      print('No available hours to book.');
      return;
    }

    final String formattedDateTime =
        '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}T${_selectedHour.toString().padLeft(2, '0')}:00:00';

    Map<String, String> massageToUrl;
    if (widget.voucherType == 'fizyczny') {
      massageToUrl = {
        'Shiatsu Massage 1': 'https://inthai-backend.dev.codepred.pl/user/buy-product/physical-voucher',
        'Shiatsu Massage 2': 'https://inthai-backend.dev.codepred.pl/user/buy-product/physical-voucher',
        'Classic Massage 1': 'https://inthai-backend.dev.codepred.pl/user/buy-product/physical-voucher',
        'Classic Massage 2': 'https://inthai-backend.dev.codepred.pl/user/buy-product/physical-voucher',
        'Thai Massage 1': 'https://inthai-backend.dev.codepred.pl/user/buy-product/physical-voucher',
        'Thai Massage 2': 'https://inthai-backend.dev.codepred.pl/user/buy-product/physical-voucher',
      };
    } else if (widget.voucherType == 'wirtualny') {
      massageToUrl = {
        'Shiatsu Massage 1': 'https://inthai-backend.dev.codepred.pl/user/buy-product/digital-voucher',
        'Shiatsu Massage 2': 'https://inthai-backend.dev.codepred.pl/user/buy-product/digital-voucher',
        'Classic Massage 1': 'https://inthai-backend.dev.codepred.pl/user/buy-product/digital-voucher',
        'Classic Massage 2': 'https://inthai-backend.dev.codepred.pl/user/buy-product/digital-voucher',
        'Thai Massage 1': 'https://inthai-backend.dev.codepred.pl/user/buy-product/digital-voucher',
        'Thai Massage 2': 'https://inthai-backend.dev.codepred.pl/user/buy-product/digital-voucher',
      };
    } else {
      massageToUrl = {}; // Domyślna, pusta mapa, gdy nie pasuje żaden warunek
    }

    final String? redirectUrl = massageToUrl[widget.selectedMassage];
    print('Redirect URL: $redirectUrl');

    if (redirectUrl == null) {
      print('Invalid massage type selected.');
      return;
    }

    final response = await http.post(
      Uri.parse(redirectUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'localDateTime': formattedDateTime,
        'masseur': _selectedMasseur,
        'firstName': {'firstName': widget.name},
        'lastName': {'lastName': widget.surname},
        'address': {
          'country': widget.country,
          'region': widget.region,
          'city': widget.city,
          'postal_code': widget.postalCode,
          'streetName': widget.street,
          'buildingNumber': widget.buildingNumber,
          'apartment': widget.apartment,
        },
        'phoneNumber': {'phoneNumber': widget.phone},
        'userEmail': {'userEmail': widget.email},
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print('Response headers: ${response.headers}');
    print(jsonEncode({
    'localDateTime': formattedDateTime,
    'masseur': _selectedMasseur,
    'firstName': {'firstName': widget.name},
    'lastName': {'lastName': widget.surname},
    'address': {
    'country': widget.country,
    'region': widget.region,
    'city': widget.city,
    'postal_code': widget.postalCode,
    'streetName': widget.street,
    'buildingNumber': widget.buildingNumber,
    'apartment': widget.apartment,
    },
    'phoneNumber': {'phoneNumber': widget.phone},
    'userEmail': {'userEmail': widget.email},
    }));
    print('Token: $token');

    final userData = {

      'firstName': {'firstName': widget.name},
      'lastName': {'lastName': widget.surname},
      'address': {
        'country': widget.country,
        'region': widget.region,
        'city': widget.city,
        'postal_code': widget.postalCode,
        'streetName': widget.street,
        'buildingNumber': widget.buildingNumber,
        'apartment': widget.apartment,
      },
      'phoneNumber': {'phoneNumber': widget.phone},
      'userEmail': {'userEmail': widget.email},
    };

    if (response.statusCode == 302) {
      final String? redirectedUrl = response.headers['location'];

      if (redirectedUrl != null) {
        print('Redirecting to: $redirectedUrl');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(
              url: redirectedUrl,
              token: token,
              formattedDateTime: formattedDateTime,
              selectedMasseur: _selectedMasseur,
              userData: userData,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Redirect URL not found in response headers.'),
          ),
        );
      }
    } else if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppointmentScreen(), // Replace with your AppointmentScreen
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create appointment.'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${widget.massageName}',
                    style: GoogleFonts.bitter(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromRGBO(57, 48, 45, 1),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Wybierz masażystę/kę:',
                    style: GoogleFonts.bitter(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color.fromRGBO(57, 48, 45, 1),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if (_masseurs.isEmpty)
                  Text(
                    'Brak dostępnych masażystów.',
                    style: GoogleFonts.bitter(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color.fromRGBO(57, 48, 45, 1),
                    ),
                  ),
                Row(
                  children: [
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _masseurs.map((masseur) {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedMasseur = masseur;
                              _initializeAvailableHours();
                              _checkAvailableHours();
                              print('Selected Masseur: $_selectedMasseur');
                            });
                          },
                          style: ButtonStyle(
                            surfaceTintColor: MaterialStateProperty.all(
                              _selectedMasseur == masseur
                                  ? Color(0xFFBE7F27)
                                  : Colors.white,
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                                side: BorderSide(
                                  color: Color.fromRGBO(243, 224, 209, 1),
                                  width: 1,
                                ),
                              ),
                            ),
                            backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                  if (states.contains(MaterialState.pressed) ||
                                      _selectedMasseur == masseur) {
                                    return Color(0xFFBE7F27);
                                  }
                                  return Colors.white;
                                }),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '${masseur['firstName']['firstName']} ${masseur['lastName']['lastName']}',
                              style: GoogleFonts.bitter(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: _selectedMasseur == masseur
                                    ? Colors.white
                                    : Color.fromRGBO(205, 152, 108, 1),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime(2100),
                  focusedDay: _selectedDate,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDate, day);
                  },
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Color(0xFFBE7F27)),
                    weekendStyle: TextStyle(color: Color(0xFFBE7F27)),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate = selectedDay;
                    });
                    _initializeAvailableHours();
                    _checkAvailableHours();
                  },
                  calendarBuilders: CalendarBuilders(
                    selectedBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFBE7F27),
                            Color(0xFFD7B613),
                          ],
                        ),
                      ),
                      child: Text(
                        '${date.day}',
                        style: TextStyle().copyWith(color: Colors.white),
                      ),
                    ),
                    todayBuilder: (context, date, _) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.transparent,
                      ),
                      child: Text(
                        '${date.day}',
                        style: TextStyle().copyWith(
                          color: isSameDay(date, DateTime.now())
                              ? Color(0xFFBE7F27)
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Dostępne godziny:',
                    style: GoogleFonts.bitter(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color.fromRGBO(57, 48, 45, 1),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if (_availableHours.isEmpty || _masseurs.isEmpty)
                  Text(
                    'Brak dostępnych godzin na ten dzień.',
                    style: GoogleFonts.bitter(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color.fromRGBO(57, 48, 45, 1),
                    ),
                  ),
                if (_availableHours.isNotEmpty && _masseurs.isNotEmpty)
                  Column(
                    children: [
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _availableHours.map((hour) {
                          return ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedHour = hour;
                                print('Selected Hour: $_selectedHour');
                              });
                            },
                            style: ButtonStyle(
                              surfaceTintColor: MaterialStateProperty.all(
                                _selectedHour == hour
                                    ? Color(0xFFBE7F27)
                                    : Colors.white,
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                  side: BorderSide(
                                    color: Color.fromRGBO(243, 224, 209, 1),
                                    width: 1,
                                  ),
                                ),
                              ),
                              backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                    if (states.contains(MaterialState.pressed) ||
                                        _selectedHour == hour) {
                                      return Color(0xFFBE7F27);
                                    }
                                    return Colors.white;
                                  }),
                            ),
                            child: Text(
                              '$hour:00',
                              style: GoogleFonts.bitter(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: _selectedHour == hour
                                    ? Colors.white
                                    : Color.fromRGBO(205, 152, 108, 1),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                SizedBox(height: 20),
                if (_availableHours.isNotEmpty && _masseurs.isNotEmpty)
                  ElevatedButton(
                    onPressed: () => _postAppointment(),

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
                          'Submit Appointment',
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
        ),
      ),
    );
  }
}

// Helper method to check if two DateTime objects represent the same date
extension DateHelpers on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
