// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../auth_helper.dart'; // Import the auth helper
// import '../webview_screen.dart'; // Import the WebViewScreen
//
// class DateSelectionScreen extends StatefulWidget {
//   final String selectedMassage;
//   final String massageName;
//
//   const DateSelectionScreen({Key? key, required this.selectedMassage, required this.massageName})
//       : super(key: key);
//
//   @override
//   _DateSelectionScreenState createState() => _DateSelectionScreenState();
// }
//
// class _DateSelectionScreenState extends State<DateSelectionScreen> {
//   late DateTime _selectedDate;
//   late int _massageDuration;
//   late List<int> _availableHours;
//   int? _selectedHour;
//   List<dynamic> _masseurs = [];
//   dynamic _selectedMasseur;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchMasseurs();
//     _selectedDate = DateTime.now();
//     _massageDuration = widget.selectedMassage.endsWith('2') ? 2 : 1;
//     _initializeAvailableHours();
//     _selectedHour = _availableHours.isNotEmpty ? _availableHours.first : null;
//     _checkAvailableHours();
//   }
//
//   void _initializeAvailableHours() {
//     final now = DateTime.now();
//     _availableHours = List<int>.generate(9, (index) => index + 12); // Lista godzin od 12 do 20
//
//     if (_selectedDate.isSameDate(now)) {
//       // Jeśli wybrany dzień to dzisiaj, usuń wcześniejsze godziny
//       _availableHours.removeWhere((hour) => hour <= now.hour);
//     }
//
//     if (_massageDuration == 2) {
//       _availableHours.remove(20); // Usunięcie godziny 20:00 jeśli masaż trwa 2 godziny
//     }
//
//     _selectedHour = _availableHours.isNotEmpty ? _availableHours.first : null;
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//         _initializeAvailableHours(); // Aktualizacja listy dostępnych godzin
//       });
//       await _checkAvailableHours();
//     }
//   }
//
//   Future<void> _fetchMasseurs() async {
//     //final String? token = await getJwtToken();
//     final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE2OTg0MDczLCJleHAiOjE3MTcwNzA0NzN9.aFhl9TCCaG8iYYxU1P6vb1cRYowKXgbDdMg-nNjvw_E";
//
//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('No token found. Please log in again.'),
//         ),
//       );
//       return;
//     }
//
//     final Uri url = Uri.parse('https://inthai-backend.dev.codepred.pl/user/get-masseurs');
//     final response = await http.get(
//       url,
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       setState(() {
//         _masseurs = jsonDecode(response.body);
//         print('Fetched masseurs: $_masseurs');
//       });
//     } else {
//       print('Failed to fetch masseurs, status code: ${response.statusCode}');
//     }
//   }
//
//   Future<void> _checkAvailableHours() async {
//     //final String? token = await getJwtToken();
//     final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE2OTg0MDczLCJleHAiOjE3MTcwNzA0NzN9.aFhl9TCCaG8iYYxU1P6vb1cRYowKXgbDdMg-nNjvw_E";
//
//
//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('No token found. Please log in again.'),
//         ),
//       );
//       return;
//     }
//
//     List<int> availableHours = [];
//
//     for (int hour in _availableHours) {
//       final String formattedDateTime =
//           '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}T${hour.toString().padLeft(2, '0')}:00:00';
//       final Uri url = Uri.parse(
//           'https://inthai-backend.dev.codepred.pl/user/is-already-booked?dateTime=$formattedDateTime');
//
//       final response = await http.get(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       print('Checking availability for $hour:00');
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         try {
//           final bool isBooked = jsonDecode(response.body) as bool;
//           if (!isBooked) {
//             availableHours.add(hour);
//           }
//         } catch (e) {
//           print('Error decoding response: $e');
//         }
//       } else if (response.statusCode == 401) {
//         print('Unauthorized request. Please check your token.');
//       } else {
//         print('Failed to check availability for $hour:00, status code: ${response.statusCode}');
//       }
//     }
//
//     setState(() {
//       _availableHours = availableHours;
//       if (_availableHours.isNotEmpty) {
//         _selectedHour = _availableHours.first;
//       } else {
//         _selectedHour = null;
//       }
//     });
//   }
//
//   Future<void> _postAppointment() async {
//     //final String? token = await getJwtToken();
//     final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE2OTg0MDczLCJleHAiOjE3MTcwNzA0NzN9.aFhl9TCCaG8iYYxU1P6vb1cRYowKXgbDdMg-nNjvw_E";
//
//
//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('No token found. Please log in again.'),
//         ),
//       );
//       return;
//     }
//
//     if (_selectedHour == null) {
//       print('No available hours to book.');
//       return;
//     }
//
//     final String formattedDateTime =
//         '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}T${_selectedHour.toString().padLeft(2, '0')}:00:00';
//
//     final Map<String, String> massageToUrl = {
//       'Thai Massage 1': 'https://inthai-backend.dev.codepred.pl/user/buy-product/tajski/1h',
//       'Classic Massage 2': 'https://inthai-backend.dev.codepred.pl/user/buy-product/klasyczny/2h',
//       'Thai Massage 2': 'https://inthai-backend.dev.codepred.pl/user/buy-product/tajski/2h',
//       'Classic Massage 1': 'https://inthai-backend.dev.codepred.pl/user/buy-product/klasyczny/1h',
//       'Shiatsu Massage 1': 'https://inthai-backend.dev.codepred.pl/user/buy-product/shiatsu/1h',
//       'Shiatsu Massage 2': 'https://inthai-backend.dev.codepred.pl/user/buy-product/shiatsu/2h',
//     };
//
//     final String? redirectUrl = massageToUrl[widget.selectedMassage];
//
//     if (redirectUrl == null) {
//       print('Invalid massage type selected.');
//       return;
//     }
//
//     final response = await http.post(
//       Uri.parse(redirectUrl),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode({
//         'localDateTime': formattedDateTime,
//         'masseurId': _selectedMasseur['id'], // Dodanie id masażystki do żądania
//       }),
//     );
//
//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');
//
//     if (response.statusCode == 302) {
//       final String? redirectedUrl = response.headers['location'];
//
//       if (redirectedUrl != null) {
//         print('Redirecting to: $redirectedUrl');
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => WebViewScreen(
//               url: redirectedUrl,
//               token: token,
//               formattedDateTime: formattedDateTime,
//             ),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Redirect URL not found in response headers.'),
//           ),
//         );
//       }
//     } else if (response.statusCode == 200) {
//       // Navigate to payment screen or show success message
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to create appointment.'),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Date'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 '${widget.massageName}',
//                 style: GoogleFonts.bitter(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 20,
//                   color: Color.fromRGBO(57, 48, 45, 1),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _masseurs.length,
//                   itemBuilder: (context, index) {
//                     final masseur = _masseurs[index];
//                     return ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           _selectedMasseur = masseur;
//                           print('Selected Masseur: $_selectedMasseur');
//                         });
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.zero, // Usuń padding
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0.0), // Ustaw promień na 0
//                         ),
//                         backgroundColor: _selectedMasseur == masseur
//                             ? Colors.orange // Zmień kolor, jeśli wybrano masażystkę
//                             : null,
//                       ),
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: 51, // Stała wysokość
//                         child: Text(
//                           '${masseur['firstName']['firstName']} ${masseur['lastName']['lastName']}',
//                           style: GoogleFonts.cinzel(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 20,
//                             color: Color(0xFF030303), // Dopasuj kolor tekstu
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//               TableCalendar(
//                 firstDay: DateTime.now(),
//                 lastDay: DateTime(2100),
//                 focusedDay: _selectedDate,
//                 selectedDayPredicate: (day) {
//                   return isSameDay(_selectedDate, day);
//                 },
//                 startingDayOfWeek: StartingDayOfWeek.monday, // Rozpocznij tydzień od poniedziałku
//                 daysOfWeekStyle: DaysOfWeekStyle(
//                   weekdayStyle: TextStyle(color: Color(0xFFBE7F27)), // Kolor dni tygodnia
//                   weekendStyle: TextStyle(color: Color(0xFFBE7F27)), // Kolor dni weekendowych
//                 ),
//                 calendarBuilders: CalendarBuilders(
//                   selectedBuilder: (context, date, events) => Container(
//                     margin: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(4.0),
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Color(0xFFBE7F27), // Kolor początkowy
//                           Color(0xFFD7B613), // Kolor końcowy
//                         ],
//                       ),
//                     ),
//                     child: Text(
//                       '${date.day}',
//                       style: TextStyle().copyWith(color: Colors.white),
//                     ),
//                   ),
//                   todayBuilder: (context, date, _) => Container(
//                     margin: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(4.0),
//                       color: Colors.transparent, // Przezroczysty kolor tła dla dzisiejszego dnia
//                     ),
//                     child: Text(
//                       '${date.day}',
//                       style: TextStyle().copyWith(
//                         color: isSameDay(date, DateTime.now()) ? Color(0xFFBE7F27) : Colors.black,
//                         // Pomarańczowy kolor dla dzisiejszego dnia, czarny dla innych dni
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               if (_selectedHour != null)
//                 DropdownButton<int>(
//                   value: _selectedHour,
//                   items: _availableHours
//                       .map<DropdownMenuItem<int>>(
//                         (hour) => DropdownMenuItem<int>(
//                       value: hour,
//                       child: Text(
//                         '$hour:00',
//                         style: GoogleFonts.bitter(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 18,
//                           color: Color.fromRGBO(57, 48, 45, 1),
//                         ),
//                       ),
//                     ),
//                   )
//                       .toList(),
//                   onChanged: (newValue) {
//                     setState(() {
//                       _selectedHour = newValue;
//                       print('Selected Hour: $_selectedHour');
//                     });
//                   },
//                 ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => _postAppointment(), // Dodaj funkcję do obsługi przycisku
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.zero, // Usuń padding
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(0.0), // Ustaw promień na 0
//                   ),
//                 ),
//                 child: Ink(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         Color(0xFFBE7F27), // Kolor początkowy
//                         Color(0xFFD7B613), // Kolor końcowy
//                       ],
//                     ),
//                   ),
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: 51, // Stała wysokość
//                     child: Text(
//                       'Submit Appointment',
//                       style: GoogleFonts.cinzel(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 20,
//                         color: Color(0xFFF9F0EA), // Dopasuj kolor tekstu
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Helper method to check if two DateTime objects represent the same date
// extension DateHelpers on DateTime {
//   bool isSameDate(DateTime other) {
//     return this.year == other.year && this.month == other.month && this.day == other.day;
//   }
// }
