import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_thai_mobile/screens/client_screens/shop_screen.dart';
import 'package:in_thai_mobile/screens/client_screens/user_screen.dart';
import '../../widgets/client_navbar.dart';
import 'client_screen.dart';

class AppointmentDetails extends StatelessWidget {
  final Map<String, dynamic> appointment;

  AppointmentDetails({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final DateTime appointmentDateStart =
    DateTime.parse(appointment['appointmentDateStart']);
    final String formattedTime =
        '${appointmentDateStart.hour}:${appointmentDateStart.minute.toString().padLeft(2, '0')}';
    final String formattedDate =
        '${appointmentDateStart.day.toString().padLeft(2, '0')}.${appointmentDateStart.month.toString().padLeft(2, '0')}.${appointmentDateStart.year.toString().substring(2, 4)}';
    final masseurName = appointment['masseur']['firstName']['firstName'];

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 251, 248, 1), // Ustaw kolor tła
      appBar: AppBar(
        title: Text('Szczegóły wizyty'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.5, 40, 24.5, 36),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(236, 198, 167, 0.2),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Szczegóły wizyty',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color(0xFF39302D),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Data:',
                          style: GoogleFonts.bitter(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color.fromRGBO(57, 48, 45, 1),
                          ),
                        ),
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
                            SizedBox(width: 10),
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
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Masażysta: $masseurName',
                      style: GoogleFonts.bitter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color.fromRGBO(57, 48, 45, 1),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Dodaj inne szczegóły wizyty tutaj
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClientNavBar(
        currentIndex: 2,
        onTap: (index) {
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
        },
      ),
    );
  }
}
