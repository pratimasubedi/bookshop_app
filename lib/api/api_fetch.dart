// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// import 'models/model.dart';

// class Api extends StatefulWidget {
//   const Api({super.key});

//   @override
//   State<Api> createState() => _ApiState();
// }

// class _ApiState extends State<Api> {
//   List<UserDetails> userDetails = [];
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: getData(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
//               padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//               itemCount: userDetails.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                   margin: const EdgeInsets.only(bottom: 10),
//                   height: 200,
//                   decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       getText(index, 'ID', userDetails[index].id.toString()),
//                       getText(
//                           index, 'Name', userDetails[index].name.toString()),
//                       getText(
//                           index, 'Email', userDetails[index].email.toString()),
//                       getText(
//                           index, 'Phone', userDetails[index].phone.toString()),
//                       getText(index, 'Website',
//                           userDetails[index].website.toString()),
//                       getText(index, 'Company Name',
//                           userDetails[index].company.name.toString()),
//                       getText(index, 'Address',
//                           '${userDetails[index].address.suite.toString()},${userDetails[index].address.street.toString()}${userDetails[index].address.city.toString()}-${userDetails[index].address.zipcode.toString()}'),
//                     ],
//                   ),
//                 );
//               });
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }

//   Text getText(int index, String fieldName, String content) {
//     return Text.rich(TextSpan(children: [
//       TextSpan(
//           text: fieldName,
//           style: (const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
//       TextSpan(
//           text: content,
//           style: (const TextStyle(
//             fontSize: 16,
//           )))
//     ]));
//   }

//   Future<List<UserDetails>> getData() async {
//     final response =
//         await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//     var data = jsonDecode(response.body.toString());
//     if (response.statusCode == 200) {
//       for (Map<String, dynamic> index in data) {
//         userDetails.add(UserDetails.fromJson(index));
//       }
//       return userDetails;
//     } else {
//       return userDetails;
//     }
//   }
// }
import 'package:bookshop_app/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/model.dart';

class ApiFetch extends StatefulWidget {
  ApiFetch({Key? key}) : super(key: key);

  // final String title;

  @override
  State<ApiFetch> createState() => _ApiFetchState();
}

Future<DataModel?> submitData(String job) async {
  var response = await http.post(
    Uri.https('reqres.in', 'api/users'),
    body: {'job': job},
  );
  var data = response.body;
  print(data);
  if (response.statusCode == 201) {
    String responseString = response.body;
    return dataModelFromJson(responseString);
  } else {
    return null;
  }
}

class _ApiFetchState extends State<ApiFetch> {
  late DataModel _dataModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Purple,
        backgroundColor: Colors.transparent,
        title: Text('API'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter name here...',
                ),
                controller: nameController,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter job title here...',
                ),
                controller: jobController,
              ),
              ElevatedButton(
                onPressed: () async {
                  String job = jobController.text;
                  DataModel? data = await submitData(job);
                  // setState(() {
                  //   _dataModel = data ?? DataModel();
                  // });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Purple,
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
