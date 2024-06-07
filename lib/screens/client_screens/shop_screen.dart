import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'appointments.dart';
import 'user_screen.dart';
import 'client_screen.dart';
import 'date_selection_screen.dart'; // Import date selection screen
import '../../widgets/client_navbar.dart';
import 'shop_screen_voucher.dart'; // Import the voucher screen

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _selectedIndex = 1;
  int _selectedCategoryIndex = 0;
  bool _isVoucherCategorySelected = false; // Track if the voucher category is selected
  final List<String> _categories = ['Masaże', 'Produkty Premium', 'Vouchery'];

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

  void _onCategoryTapped(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _isVoucherCategorySelected = index == 2; // Check if the voucher category is selected
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0), // Add padding from the top
            child: Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _onCategoryTapped(index),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedCategoryIndex == index
                                ? Color(0xFFBE7F27)
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text(
                        _categories[index],
                        style: GoogleFonts.cinzel(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: _selectedCategoryIndex == index
                              ? Colors.brown[800]
                              : Colors.brown[600],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: _isVoucherCategorySelected ? VoucherForm() : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MassageCard(
                    title: 'Thai Massage',
                    price: '250 zł',
                    duration: '50',
                    imageAsset: 'assets/massage_2.jpg',
                    massageName: 'Thai Massage 1', // Add massage name
                  ),
                  SizedBox(height: 20),
                  MassageCard(
                    title: 'Classic Massage',
                    price: '200 zł',
                    duration: '50',
                    imageAsset: 'assets/massage_3.jpg',
                    massageName: 'Classic Massage 1', // Add massage name
                  ),
                  SizedBox(height: 20),
                  MassageCard(
                    title: 'Shiatsu Massage',
                    price: '320 zł',
                    duration: '50',
                    imageAsset: 'assets/massage_1.png',
                    massageName: 'Shiatsu Massage 1', // Add massage name
                  ),
                  SizedBox(height: 20),
                  MassageCard(
                    title: 'Thai Massage',
                    price: '500 zł',
                    duration: '105',
                    imageAsset: 'assets/massage_2.jpg',
                    massageName: 'Thai Massage 2', // Add massage name
                  ),
                  SizedBox(height: 20),
                  MassageCard(
                    title: 'Classic Massage',
                    price: '400 zł',
                    duration: '105',
                    imageAsset: 'assets/massage_3.jpg',
                    massageName: 'Classic Massage 2', // Add massage name
                  ),
                  SizedBox(height: 20),
                  MassageCard(
                    title: 'Shiatsu Massage',
                    price: '640 zł',
                    duration: '105',
                    imageAsset: 'assets/massage_1.png',
                    massageName: 'Shiatsu Massage 2', // Add massage name
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
  final String massageName; // Add massage name

  const MassageCard({
    Key? key,
    required this.title,
    required this.price,
    required this.duration,
    required this.imageAsset,
    required this.massageName, // Add massage name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, // Remove card shadow
      color: Color.fromRGBO(255, 251, 248, 1), // Change card background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: Color.fromRGBO(243, 224, 209, 1), width: 1), // Add brown border
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
                      //bitter
                      style: GoogleFonts.bitter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color.fromRGBO(205, 152, 108, 1),
                      ),
                    ),
                    SizedBox(width: 20),
                    FaIcon(FontAwesomeIcons.tag, color: Color.fromRGBO(205, 152, 108, 1), size: 15), // Use the tag icon from Font Awesome
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
                        builder: (context) => DateSelectionScreen(selectedMassage: massageName, massageName: title),
                      ),
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFBE7F27), // Starting color
                          Color(0xFFD7B613), // Ending color
                        ],
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 51, // Fixed height
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Text(
                            'WYBIERZ TERMIN    ',
                            style: GoogleFonts.cinzel(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFFF9F0EA), // Adjust text color
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
            ),
          ),
        ],
      ),
    );
  }
}

class VoucherForm extends StatefulWidget {
  const VoucherForm({Key? key}) : super(key: key);

  @override
  _VoucherFormState createState() => _VoucherFormState();
}

class _VoucherFormState extends State<VoucherForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingNumberController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _voucherType;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Wybierz rodzaj vouchera:',
            style: GoogleFonts.cinzel(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.brown[800],
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: Text('Fizyczny', style: GoogleFonts.bitter(fontSize: 16)),
                  value: 'fizyczny',
                  groupValue: _voucherType,
                  onChanged: (value) {
                    setState(() {
                      _voucherType = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: Text('Wirtualny', style: GoogleFonts.bitter(fontSize: 16)),
                  value: 'wirtualny',
                  groupValue: _voucherType,
                  onChanged: (value) {
                    setState(() {
                      _voucherType = value;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Dane odbiorcy vouchera:',
            style: GoogleFonts.cinzel(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.brown[800],
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Name',
              hintStyle: GoogleFonts.bitter(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFFA3A3A3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            ),
            style: TextStyle(color: Colors.grey[800]),
            textInputAction: TextInputAction.done,
            maxLines: 1,
            minLines: 1,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _surnameController,
            decoration: InputDecoration(
              hintText: 'Surname',
              hintStyle: GoogleFonts.bitter(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Color(0xFFA3A3A3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            ),
            style: TextStyle(color: Color(0xFFA3A3A3)),
            textInputAction: TextInputAction.done,
            maxLines: 1,
            minLines: 1,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _countryController,
            decoration: InputDecoration(
              hintText: 'Country',
              hintStyle: GoogleFonts.bitter(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Color(0xFFA3A3A3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            ),
            style: TextStyle(color: Color(0xFFA3A3A3)),
            textInputAction: TextInputAction.done,
            maxLines: 1,
            minLines: 1,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _regionController,
            decoration: InputDecoration(
              hintText: 'Region',
              hintStyle: GoogleFonts.bitter(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Color(0xFFA3A3A3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            ),
            style: TextStyle(color: Color(0xFFA3A3A3)),
            textInputAction: TextInputAction.done,
            maxLines: 1,
            minLines: 1,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _cityController,
            decoration: InputDecoration(
              hintText: 'City',
              hintStyle: GoogleFonts.bitter(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Color(0xFFA3A3A3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            ),
            style: TextStyle(color: Color(0xFFA3A3A3)),
            textInputAction: TextInputAction.done,
            maxLines: 1,
            minLines: 1,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _postalCodeController,
            decoration: InputDecoration(
              hintText: 'Postal Code',
              hintStyle: GoogleFonts.bitter(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Color(0xFFA3A3A3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            ),
            style: TextStyle(color: Color(0xFFA3A3A3)),
            textInputAction: TextInputAction.done,
            maxLines: 1,
            minLines: 1,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _streetController,
            decoration: InputDecoration(
              hintText: 'Street',
              hintStyle: GoogleFonts.bitter(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Color(0xFFA3A3A3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            ),
            style: TextStyle(color: Color(0xFFA3A3A3)),
            textInputAction: TextInputAction.done,
            maxLines: 1,
            minLines: 1,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _buildingNumberController,
            decoration: InputDecoration(
              hintText: 'Building Number',
              hintStyle: GoogleFonts.bitter(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Color(0xFFA3A3A3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            ),
            style: TextStyle(color: Color(0xFFA3A3A3)),
            textInputAction: TextInputAction.done,
            maxLines: 1,
            minLines: 1,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _apartmentController,
            decoration: InputDecoration(
              hintText: 'Apartment',
              hintStyle: GoogleFonts.bitter(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Color(0xFFA3A3A3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            ),
            style: TextStyle(color: Color(0xFFA3A3A3)),
            textInputAction: TextInputAction.done,
            maxLines: 1,
            minLines: 1,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: GoogleFonts.bitter(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Color(0xFFA3A3A3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            ),
            style: TextStyle(color: Color(0xFFA3A3A3)),
            textInputAction: TextInputAction.done,
            maxLines: 1,
            minLines: 1,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              hintText: 'Phone',
              hintStyle: GoogleFonts.bitter(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Color(0xFFA3A3A3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFECC6A7), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBE7F27), width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            ),
            style: TextStyle(color: Color(0xFFA3A3A3)),
            textInputAction: TextInputAction.done,
            maxLines: 1,
            minLines: 1,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isEmpty ||
                  _surnameController.text.isEmpty ||
                  _countryController.text.isEmpty ||
                  _regionController.text.isEmpty ||
                  _cityController.text.isEmpty ||
                  _postalCodeController.text.isEmpty ||
                  _streetController.text.isEmpty ||
                  _buildingNumberController.text.isEmpty ||
                  _emailController.text.isEmpty ||
                  _phoneController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please fill all the fields.')),
                );
              }
              else if (!_emailController.text.contains('@')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter a valid email address.')),
                );
              }
              else if (_phoneController.text.length < 9) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter a valid phone number.')),
                );
              }
              else if  (_voucherType == null) {
                // Pokaż ostrzeżenie, jeśli nie wybrano typu vouchera
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Proszę wybrać rodzaj vouchera')),
                );
              }
              else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopScreenVoucher( // Navigate to the voucher screen
                    name: _nameController.text,
                    surname: _surnameController.text,
                    country: _countryController.text,
                    region: _regionController.text,
                    city: _cityController.text,
                    postalCode: _postalCodeController.text,
                    street: _streetController.text,
                    buildingNumber: _buildingNumberController.text,
                    apartment: _apartmentController.text,
                    email: _emailController.text,
                    phone: _phoneController.text,
                    voucherType: _voucherType!,
                  )),
                );

              }

            },
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
                  'Wybierz masaż',
                  style: GoogleFonts.cinzel(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Color(0xFFF9F0EA), // Dopasuj kolor tekstu
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

