import 'package:flutter/material.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({Key? key}) : super(key: key);

  @override
  _PasswordRecoveryScreenState createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Recovery'),
        backgroundColor: Colors.white, // Set app bar background color to white
        iconTheme: IconThemeData(color: Colors.black), // Set app bar icon color to black
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.black), // Set label text color to black
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), // Set border color to black
                  ),
                ),
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.black), // Set input text color to black
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement logic to send password to provided phone number
                  _sendPassword();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Colors.white54, // Change button color to black
                ),
                child: Text(
                  'Send Password',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black54, // Change button text color to white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendPassword() {
    String phoneNumber = phoneNumberController.text;
    // Implement logic to send password to provided phone number
    print('Sending password to $phoneNumber');
    // You can add Firebase authentication or other backend logic here
  }
}
