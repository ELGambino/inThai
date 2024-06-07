import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'client_screens/appointments.dart'; // Import AppointmentScreen

import 'auth_helper.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String token;
  final String formattedDateTime;
  final dynamic selectedMasseur;
  final Map<String, dynamic>? userData;


  WebViewScreen({
    required this.url,
    required this.token,
    required this.formattedDateTime,
    required this.selectedMasseur,
    this.userData,
  });

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  bool _tokenSent = false; // flag to track if the token has been sent

  @override
  void initState() {
    super.initState();
    if (WebView.platform == null) {
      WebView.platform = SurfaceAndroidWebView(); // Ensure WebView is properly initialized for Android
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView'),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
            navigationDelegate: (NavigationRequest request) async {
              print('Navigating to: ${request.url}');
              if (request.url.startsWith('http://localhost:8021/success') && !_tokenSent) {
                final updatedUrl = request.url.replaceFirst(
                    'http://localhost:8021/success',
                    'https://inthai-backend.dev.codepred.pl/user/success');

                await _sendTokenAndDate(updatedUrl);
                _tokenSent = true; // set flag to true after sending token
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
              _tokenSent = false; // reset flag after page finishes loading
            },
          ),
          if (_tokenSent)
            Center(
              child: Container(
                color: Colors.white, // White background color
                child: SizedBox(
                  width: 320,
                  height: 450,
                  child: Container(
                    color: Color.fromRGBO(236, 198, 167, 0.4),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Transakcja powiodła się',
                            style: GoogleFonts.bitter(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(162, 102, 68, 1),
                            ),
                          ),

                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AppointmentScreen()), // Navigate to AppointmentScreen
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
                              child: Text(
                                'Przejdź do rezerwacji',
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
            ),
        ],
      ),
    );
  }
  Future<void> _sendTokenAndDate(String url) async {
    final String? token = await getJwtToken(); // Use the same method to fetch the token
    //final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE3NDExNTg0LCJleHAiOjE3MTc0OTc5ODR9.uUiAHy6LXQv_43brx7IrdV1Sb4STlMz6kaEMeb9BAz8";    //

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No token found. Please log in again.'),
        ),
      );
      return;
    }

    final String formattedDateTime = widget.formattedDateTime;
    final dynamic selectedMasseur = widget.selectedMasseur; // Set the selected masseur
    print('Sending token and date to: $url');
    print('Selected Date: $formattedDateTime');
    print('Selected Masseur: $selectedMasseur');
    print('Widget token: $token'); // Use the fetched token

    //final String selectedMasseur1 = widget.selectedMasseur; // Set the selected masseur

    final Uri newUrl = Uri.parse(url);
    print('New URL: $newUrl');

    final Map<String, dynamic> body = {
      'localDateTime': formattedDateTime,
      'masseur': selectedMasseur,
      if (widget.userData != null) ...widget.userData!,
    };

    final response = await http.post(
      newUrl,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Use the fetched token in the header
      },
      body: jsonEncode(body),
    );
    print('Body: $body');

    if (response.statusCode == 200) {
      print('Token and date sent successfully to: $url');
      setState(() {
        _tokenSent = true; // Update state to show success overlay
      });
    } else {
      print('Failed to send token and date to: $url');
      print('Error status code: ${response.statusCode}');
      print('Error response body: ${response.body}');
    }
  }
}
