import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signup_screen.dart';
import 'login_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF39302D), // Dopasuj kolor tła
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.5, 84, 24.5, 36), // Dopasuj margines
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                  width: 240,
                  height: 215.6,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 0), // Dopasuj padding
              child: Text(
                'Osiągnij pełną relaksację i odprężenie',
                textAlign: TextAlign.center,
                style: GoogleFonts.bitter(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFFF9F0EA), // Dopasuj kolor tekstu
                ),
              ),
            ),
            Spacer(), // Dodaj odstęp aby przyciski były na dole ekranu
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero, // Usuń padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0), // Dodaj zaokrąglenie
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
                        'LOGOWANIE',
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
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // Usuń padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0), // Ustaw promień na 0
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 51, // Stała wysokość
                    alignment: Alignment.center,
                    child: Text(
                      'REJESTRACJA',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color(0xFFF9F0EA), // Dopasuj kolor tekstu
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
