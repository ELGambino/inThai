import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MassageCatalogScreen extends StatelessWidget {
  const MassageCatalogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Massage Catalog'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MassageCard(
                title: 'Thai Massage',
                price: '250 zl',
                imageAsset: 'assets/massage_2.jpg',
                onPressed: () {
                  _purchaseMassage('https://buy.stripe.com/test_9AQ29naoSeGH9CEfYY');
                },
              ),
              SizedBox(height: 20),
              MassageCard(
                title: 'Classic Massage',
                price: '200 zl',
                imageAsset: 'assets/massage_3.jpg',
                onPressed: () {
                  _purchaseMassage('https://buy.stripe.com/test_9AQ29naoSeGH9CEfYY');
                },
              ),
              SizedBox(height: 20),
              MassageCard(
                title: 'Shiatsu Massage',
                price: '320 zl',
                imageAsset: 'assets/massage_1.png',
                onPressed: () {
                  _purchaseMassage('https://buy.stripe.com/test_9AQ29naoSeGH9CEfYY');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _purchaseMassage(String paymentLink) async {
    try {
      if (await canLaunch(paymentLink)) {
        await launch(paymentLink);
        print('Opening payment link: $paymentLink');
      } else {
        print('Could not launch $paymentLink');
      }
    } catch (e) {
      print('Error opening payment link: $e');
    }
  }
}

class MassageCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageAsset;
  final VoidCallback onPressed;

  const MassageCard({
    Key? key,
    required this.title,
    required this.price,
    required this.imageAsset,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Price: $price',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
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

void main() {
  runApp(MaterialApp(
    home: MassageCatalogScreen(),
  ));
}
