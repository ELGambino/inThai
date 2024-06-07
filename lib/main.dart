import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:in_thai_mobile/screens/phone_verification_screen.dart';
import 'screens/start_screen.dart'; // Importujemy ekran startowy
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'screens/client_screens/client_screen.dart';
import 'screens/client_screens/appointment_details.dart';
import 'screens/client_screens/shop_screen.dart';
//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTMzNDU2ODQiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNzE3Njc0NjUyLCJleHAiOjE3MTc3NjEwNTJ9.XXqadhpIucniOVmYpa7Ul4apGv7i56N27ZwuQ3syvGk

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51P7cUXC4mluOO4qIbvHE7MdWLUbBmVKhEsGFvdZwY2bVjsngMVn2bb7diFDqbZ1aOuJ5NuxCmxtbSwJoGVDeFgUG004CR0y9xc";
  //Stripe.publishableKey = "pk_test_51P81iA2MC2mFQLNQgPwoDbCD28Aze8McwraGm4TyXBxnVV386VOqZp7SyxNQwHEUeuFqobt9IGjSKAeJHgkIWiDL00m5YFIe64";
  await dotenv.load(fileName: "assets/.env");

  runApp(MyApp(preferredLocale: Locale('en', 'EN')));
}

class MyApp extends StatelessWidget {
  final Locale preferredLocale;

  const MyApp({Key? key, required this.preferredLocale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: preferredLocale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      //home: PhoneVerificationScreen(phoneNumber: '123123123', userData: {},)
      home: StartScreen(), // Zmiana na ekran startowy
      //home: ClientScreen()
      //home: ShopScreen()
    );
  }
}


Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
  try {
    final body = {
      'amount': amount,
      'currency': currency,
    };

    final response = await http.post(
      //Uri.parse('https://api.stripe.com/v1/payment_intents'),
      Uri.parse('https://api.stripe.com/v3/'),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );
    return json.decode(response.body);
  } catch (err) {
    throw Exception(err.toString());
  }
}

Future<void> displayPaymentSheet() async {
  try {
    await Stripe.instance.presentPaymentSheet();
  } catch (e) {
    print('Error displaying payment sheet: $e');
  }
}