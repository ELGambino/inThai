import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
                paymentLink: 'https://buy.stripe.com/test_3csaFTfJc9mn3eg28a',
              ),
              SizedBox(height: 20),
              MassageCard(
                title: 'Classic Massage',
                price: '200 zl',
                imageAsset: 'assets/massage_3.jpg',
                paymentLink: 'https://buy.stripe.com/test_7sI3drgNg7efaGI4gh',
              ),
              SizedBox(height: 20),
              MassageCard(
                title: 'Shiatsu Massage',
                price: '320 zl',
                imageAsset: 'assets/massage_1.png',
                paymentLink: 'https://buy.stripe.com/test_9AQ29naoSeGH9CEfYY',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MassageCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageAsset;
  final String paymentLink;

  const MassageCard({
    Key? key,
    required this.title,
    required this.price,
    required this.imageAsset,
    required this.paymentLink,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentWebView(paymentLink: paymentLink),
                      ),
                    );
                  },
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

class PaymentWebView extends StatelessWidget {
  final String paymentLink;

  const PaymentWebView({Key? key, required this.paymentLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: WebView(
        initialUrl: paymentLink,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MassageCatalogScreen(),
  ));
}
