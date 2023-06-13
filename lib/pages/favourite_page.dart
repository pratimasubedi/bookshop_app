import 'package:flutter/material.dart';
import '../utils/color_util.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<String> favoriteItems = [
    'Item 1',
    'Item 2',
    'Item 3',
  ];

  void addToFavorites(String item) {
    setState(() {
      favoriteItems.add(item);
    });
  }

  void removeFromFavorites(String item) {
    setState(() {
      favoriteItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Purple,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('My Favorite Page'),
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (BuildContext context, int index) {
          final item = favoriteItems[index];
          return ListTile(
            title: Text(item),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Purple,
              ),
              onPressed: () => removeFromFavorites(item),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Purple,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newItem = '';
              return AlertDialog(
                title: Text('Add to Favorites'),
                content: TextField(
                  onChanged: (value) {
                    newItem = value;
                  },
                ),
                actions: [
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Purple),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Add',
                      style: TextStyle(color: Purple),
                    ),
                    onPressed: () {
                      addToFavorites(newItem);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
