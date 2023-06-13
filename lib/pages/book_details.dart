import 'package:bookshop_app/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cart.dart';

class BookDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Purple,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Book Details',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
                child: Icon(
                  Icons.shopping_cart,
                  color: Purple,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/book.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'The Book Title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Author: John Doe',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10),
            Text(
              'Price: \$19.99',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                fontFamily: 'Times New Roman',
                letterSpacing: 1.2,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Purple,
                    ),
                    child: Text('Add to Cart'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      String urlScheme = 'esewa://payment';

                      if (await canLaunch(urlScheme)) {
                        await launch(urlScheme);
                      } else {
                        String androidAppUrl = 'https://esewa.com.np/#/home';
                        if (await canLaunch(androidAppUrl)) {
                          await launch(androidAppUrl);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Action Not Supported'),
                              content: Text(
                                  'Please install the eSewa app from the Play Store to proceed with the payment.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      'Buy Now',
                      style: TextStyle(color: Purple),
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
