import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'appointments.dart';
import 'date_selection_screen_voucher.dart';
import 'user_screen.dart';
import 'client_screen.dart';
import 'date_selection_screen.dart'; // Import date selection screen
import '../../widgets/client_navbar.dart';

class ShopScreenVoucher extends StatefulWidget {
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
  final String voucherType;

  const ShopScreenVoucher({
    Key? key,
    required this.name,
    required this.surname,
    required this.country,
    required this.region,
    required this.city,
    required this.postalCode,
    required this.street,
    required this.buildingNumber,
    required this.apartment,
    required this.email,
    required this.phone,
    required this.voucherType,
  }) : super(key: key);

  @override
  _ShopScreenVoucherState createState() => _ShopScreenVoucherState();
}

class _ShopScreenVoucherState extends State<ShopScreenVoucher> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
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
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClientScreen()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Wybierz masaż na prezent:',
                    style: GoogleFonts.cinzel(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.brown[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  MassageCard(
                    title: 'Thai Massage',
                    price: '250 zł',
                    duration: '50',
                    imageAsset: 'assets/massage_2.jpg',
                    massageName: 'Thai Massage 1',
                    voucherType: widget.voucherType,
                    name: widget.name,
                    surname: widget.surname,
                    country: widget.country,
                    region: widget.region,
                    city: widget.city,
                    postalCode: widget.postalCode,
                    street: widget.street,
                    buildingNumber: widget.buildingNumber,
                    apartment: widget.apartment,
                    email: widget.email,
                    phone: widget.phone,
                  ),
                  SizedBox(height: 20),
                  MassageCard(
                    title: 'Classic Massage',
                    price: '200 zł',
                    duration: '50',
                    imageAsset: 'assets/massage_3.jpg',
                    massageName: 'Classic Massage 1',
                    voucherType: widget.voucherType,
                    name: widget.name,
                    surname: widget.surname,
                    country: widget.country,
                    region: widget.region,
                    city: widget.city,
                    postalCode: widget.postalCode,
                    street: widget.street,
                    buildingNumber: widget.buildingNumber,
                    apartment: widget.apartment,
                    email: widget.email,
                    phone: widget.phone,
                  ),
                  SizedBox(height: 20),
                  MassageCard(
                    title: 'Shiatsu Massage',
                    price: '320 zł',
                    duration: '50',
                    imageAsset: 'assets/massage_1.png',
                    massageName: 'Shiatsu Massage 1',
                    voucherType: widget.voucherType,
                    name: widget.name,
                    surname: widget.surname,
                    country: widget.country,
                    region: widget.region,
                    city: widget.city,
                    postalCode: widget.postalCode,
                    street: widget.street,
                    buildingNumber: widget.buildingNumber,
                    apartment: widget.apartment,
                    email: widget.email,
                    phone: widget.phone,
                  ),
                  SizedBox(height: 20),
                  MassageCard(
                    title: 'Thai Massage',
                    price: '500 zł',
                    duration: '105',
                    imageAsset: 'assets/massage_2.jpg',
                    massageName: 'Thai Massage 2',
                    voucherType: widget.voucherType,
                    name: widget.name,
                    surname: widget.surname,
                    country: widget.country,
                    region: widget.region,
                    city: widget.city,
                    postalCode: widget.postalCode,
                    street: widget.street,
                    buildingNumber: widget.buildingNumber,
                    apartment: widget.apartment,
                    email: widget.email,
                    phone: widget.phone,
                  ),
                  SizedBox(height: 20),
                  MassageCard(
                    title: 'Classic Massage',
                    price: '400 zł',
                    duration: '105',
                    imageAsset: 'assets/massage_3.jpg',
                    massageName: 'Classic Massage 2',
                    voucherType: widget.voucherType,
                    name: widget.name,
                    surname: widget.surname,
                    country: widget.country,
                    region: widget.region,
                    city: widget.city,
                    postalCode: widget.postalCode,
                    street: widget.street,
                    buildingNumber: widget.buildingNumber,
                    apartment: widget.apartment,
                    email: widget.email,
                    phone: widget.phone,
                  ),
                  SizedBox(height: 20),
                  MassageCard(
                    title: 'Shiatsu Massage',
                    price: '640 zł',
                    duration: '105',
                    imageAsset: 'assets/massage_1.png',
                    massageName: 'Shiatsu Massage 2',
                    voucherType: widget.voucherType,
                    name: widget.name,
                    surname: widget.surname,
                    country: widget.country,
                    region: widget.region,
                    city: widget.city,
                    postalCode: widget.postalCode,
                    street: widget.street,
                    buildingNumber: widget.buildingNumber,
                    apartment: widget.apartment,
                    email: widget.email,
                    phone: widget.phone,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClientNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MassageCard extends StatelessWidget {
  final String title;
  final String price;
  final String duration;
  final String imageAsset;
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

  const MassageCard({
    Key? key,
    required this.title,
    required this.price,
    required this.duration,
    required this.imageAsset,
    required this.massageName,
    required this.voucherType,
    required this.name,
    required this.surname,
    required this.country,
    required this.region,
    required this.city,
    required this.postalCode,
    required this.street,
    required this.buildingNumber,
    required this.apartment,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color.fromRGBO(255, 251, 248, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: Color.fromRGBO(243, 224, 209, 1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              imageAsset,
              fit: BoxFit.cover,
              height: 200.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: GoogleFonts.bitter(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color.fromRGBO(57, 48, 45, 1),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Color.fromRGBO(205, 152, 108, 1), size: 15),
                    SizedBox(width: 5),
                    Text(
                      '$duration min',
                      style: GoogleFonts.bitter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color.fromRGBO(205, 152, 108, 1),
                      ),
                    ),
                    SizedBox(width: 20),
                    FaIcon(FontAwesomeIcons.tag, color: Color.fromRGBO(205, 152, 108, 1), size: 15),
                    SizedBox(width: 5),
                    Text(
                      price,
                      style: GoogleFonts.bitter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color.fromRGBO(205, 152, 108, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DateSelectionScreenVoucher(
                          selectedMassage: massageName,
                          massageName: title,
                          voucherType: voucherType,
                          name: name,
                          surname: surname,
                          country: country,
                          region: region,
                          city: city,
                          postalCode: postalCode,
                          street: street,
                          buildingNumber: buildingNumber,
                          apartment: apartment,
                          email: email,
                          phone: phone,
                        ),
                      ),
                    );
                  },
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
                            'WYBIERZ TERMIN    ',
                            style: GoogleFonts.cinzel(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFFF9F0EA),
                            ),
                          ),
                          Icon(Icons.arrow_forward, color: Color(0xFFF9F0EA), size: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
