import 'package:flutter/material.dart';
import 'book_details.dart';
import '../utils/color_util.dart';

class BookPage extends StatelessWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Book Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'TimesNewRoman',
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Purple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SizedBox(
          height: 350,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              'assets/images/book.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vintage Beloved',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'TimesNewRoman',
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Now 48% Off',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Category: Classics',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Price: Rs 900',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookDetails()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Purple,
                                ),
                                child: const Text(
                                  'View More',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              'assets/images/book2.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'The Walking Dead: Compendium One',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'TimesNewRoman',
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Now 35% Off',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Category: Comic Book or Graphic Novel',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Price: Rs 500',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookDetails()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Purple,
                                ),
                                child: const Text(
                                  'View More',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              'assets/images/book3.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'And Then There Were None',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'TimesNewRoman',
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Category: Mystery',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Price: Rs 200',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookDetails()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Purple,
                                ),
                                child: const Text(
                                  'View More',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
