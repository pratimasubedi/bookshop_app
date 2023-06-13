import 'package:flutter/material.dart';
import '../utils/color_util.dart';
import 'homepage.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Purple,
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return CartItemWidget(item: item);
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${calculateTotalPrice()}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Purple),
              ),
              child: Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Dummy data
  List<CartItem> cartItems = [
    CartItem('Product 1', 2, 10.0),
    CartItem('Product 2', 1, 20.0),
    CartItem('Product 3', 3, 15.0),
  ];

  double calculateTotalPrice() {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.quantity * item.price;
    }
    return total;
  }
}

class CartItem {
  final String name;
  final int quantity;
  final double price;

  CartItem(this.name, this.quantity, this.price);
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.shopping_cart),
      title: Text(item.name),
      subtitle: Text('Quantity: ${item.quantity}'),
      trailing: Text('Price: \$${item.price}'),
    );
  }
}
