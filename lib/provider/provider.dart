import 'package:bookshop_app/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}

class ProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          foregroundColor: Purple,
          backgroundColor: Colors.transparent,
          title: Text('Flutter Provider')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Counter Value:', style: TextStyle(fontSize: 24)),
            Text('${counter.count}', style: TextStyle(fontSize: 48)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Increment'),
                  onPressed: counter.increment,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  child: Text('Decrement'),
                  onPressed: counter.decrement,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
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
