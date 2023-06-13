import 'package:flutter/material.dart';
import '../utils/color_util.dart';
import 'loginpage.dart';
import 'signup.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulating a delay to show the preloader
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Purple),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Black,
                  //   ],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // ),
                  ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 80, horizontal: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 250,
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
                      SizedBox(height: 30),
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget nulla vitae lorem mattis interdum nec in risus. Curabitur aliquet mi ac nisl viverra eleifend. Phasellus consequat elit vitae lacinia aliquam. Quisque vel justo sit amet neque dignissim pulvinar. Maecenas mattis pellentesque orci, nec euismod dolor accumsan ac.',
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
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Purple,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Purple,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
