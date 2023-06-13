import 'package:bookshop_app/pages/loginpage.dart';
import 'package:bookshop_app/pages/settings_page.dart';
import 'package:bookshop_app/todo_functionality/todomain.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bookshop_app/pages/storage_service.dart';

import '../about_us/about_us_screen.dart';
import '../api/api_fetch.dart';
import '../bloc/bloc.dart';
import '../cubit/cubit_screen.dart';
import '../firebase_signin/firebase_signin.dart';
import '../firebasefirestore_multiple/firestore_multiple.dart';
import '../firestore/firebase_firestore.dart';
import '../pagination/cubit/cubitpage.dart';
import '../pagination/data/repositories/posts_respository.dart';
import '../pagination/data/services/posts_service.dart';
import '../provider/provider.dart';
import '../realtime_database/realtime_database.dart';
import 'book.dart';
import 'book_details.dart';
import 'cart.dart';
import 'database_storage.dart';
import 'favourite_page.dart';
import 'users_details.dart';
import '../utils/color_util.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  // final FirebaseApp appInstance = Firebase.app();

  final List<String> carouselImages = [
    'assets/images/book.jpg',
    'assets/images/book2.jpg',
    'assets/images/book3.jpg',
    'assets/images/book4.jpg',
    'assets/images/book5.jpg',
  ];

  final auth = FirebaseAuth.instance;
  // FirebaseApp bookshopApp = Firebase.app('BookshopApp');
  final Storage storage = Storage();

  // void _logout() async {
  //   await signOut();
  // }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Purple,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Book Shop',
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
              GestureDetector(
                onTap: () {
                  auth.signOut().then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  });
                },
                child: Icon(
                  Icons.logout_outlined,
                  color: Purple,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Purple,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/user.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      SizedBox(width: 90),
                      Positioned(
                        bottom: 0,
                        left: 20,
                        child: ElevatedButton(
                          onPressed: () async {
                            final results = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['png', 'jpg'],
                            );
                            if (results == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No file has been selected'),
                                ),
                              );
                              return null;
                            }
                            final path = results.files.single.path!;
                            final fileName = results.files.single.name;

                            storage.uploadFile(path, fileName).then((value) {
                              print('Done');
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Image selected'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Purple,
                                        ),
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            });

                            print(path);
                            print(fileName);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Purple,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'a@a.com',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.verified_user,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('Users',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDetailsPage(
                            name: 'Pratima Subedi',
                            email: 'a@a.com',
                          )),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('Settings', style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('Favourite', style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritePage()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.storage,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('Database Storage',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DatabaseStorage()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.storage_sharp,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('Realtime Database',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RealtimeDatabase()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.today_outlined,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('TODO', style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodoPage()),
                );
              },
            ),
            // ListTile(
            //   title: Row(
            //     children: [
            //       Icon(
            //         Icons.today_outlined,
            //         color: Purple,
            //       ),
            //       SizedBox(width: 8),
            //       Text('Database', style: TextStyle(color: Colors.black)),
            //     ],
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => CustomDatabase(
            //                 app: bookshopApp,
            //               )),
            //     );
            //   },
            // ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.data_usage,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('Firestore', style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FireStore()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.signpost_outlined,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('Firebase Signin',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FirebaseSignInPage()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.storage,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('Multiple Firestore',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirestoreMultiple()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.api,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('API', style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApiFetch()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('Provider', style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProviderPage()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('Bloc', style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BlocPage()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.block,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('Bloc Cubit', style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CubitScreen()),
                );
              },
            ),

            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('Pagination with Bloc/Cubit',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaginationApp(
                            repository: PostsRepository(PostsService()),
                          )),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('AboutAPI', style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUsBody()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Purple,
                  ),
                  SizedBox(width: 8),
                  Text('LogOut', style: TextStyle(color: Colors.black)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, bottom: 10),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: carouselImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Categories',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TimesNewRoman'),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Purple, width: 3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetails()),
                              );
                            },
                            child: const Text(
                              'Comic Book or Graphic Novel',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TimesNewRoman',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Purple, width: 3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetails()),
                              );
                            },
                            child: const Text(
                              'Mystery',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TimesNewRoman',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Purple, width: 3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetails()),
                              );
                            },
                            child: const Text(
                              'Poetry',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TimesNewRoman',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Purple, width: 3),
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetails()),
                              );
                            },
                            child: const Text(
                              'Western',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TimesNewRoman',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Purple, width: 3),
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetails()),
                              );
                            },
                            child: const Text(
                              'Fiction',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TimesNewRoman',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Purple, width: 3),
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetails()),
                              );
                            },
                            child: Text(
                              'Action and Adventure',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TimesNewRoman',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Purple, width: 3),
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetails()),
                              );
                            },
                            child: Text(
                              'Classics',
                              style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TimesNewRoman',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Purple, width: 3),
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetails()),
                              );
                            },
                            child: Text(
                              'Fantasy',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TimesNewRoman',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular Now',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'TimesNewRoman',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookPage()),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'View All',
                                  style: TextStyle(
                                    color: Purple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'TimesNewRoman',
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Purple,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Column 1
                            Container(
                              width: 200,
                              height: 400,
                              child: Card(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          'assets/images/book.jpg',
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: 150,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          'Vintage Beloved ',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'TimesNewRoman'),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Now 48% Off',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Category:Classics',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Price:Rs:900',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BookPage()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Purple,
                                        ),
                                        child: const Text('Order Now'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Column 2
                            Container(
                              height: 400,
                              width: 200,
                              child: Card(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          'assets/images/book2.jpg',
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: 150,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          'The Walking Dead: Compendium One',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'TimesNewRoman'),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        'Now 35% Off',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        'Category:Comic Book or Graphic Novel',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        'Price:Rs500',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const BookPage()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Purple,
                                        ),
                                        child: const Text('Order Now'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Column 3
                            Container(
                              height: 400,
                              width: 200,
                              child: Card(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          'assets/images/book3.jpg',
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: 150,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          'And Then There Were None',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'TimesNewRoman'),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Category:Mystery',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Price:Rs200',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14),
                                      ),
                                      SizedBox(height: 5),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BookPage()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Purple,
                                        ),
                                        child: const Text('Order Now'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Column 4
                            Container(
                              height: 400,
                              width: 200,
                              child: Card(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          'assets/images/book4.jpg',
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: 150,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          'Circe',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'TimesNewRoman',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Category:Fantasy ',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Price:Rs200 ',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BookPage()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Purple,
                                        ),
                                        child: const Text('Order Now'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Column 5
                            Container(
                              width: 200,
                              height: 400,
                              child: Card(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          'assets/images/book5.jpg',
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: 150,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          'The Help ',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'TimesNewRoman'),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Now 45% off ',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Category:Historical Fiction ',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Price:Rs1500',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BookPage()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Purple,
                                        ),
                                        child: const Text('Order Now'),
                                      ),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
