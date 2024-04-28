
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<String> cartItems = [];
  List<String> price = [];

  void addToCart(String item, String rS) {
    setState(() {
      cartItems.add(item);
      price.add(rS);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 138, 170),
        title: const Center(
          child: Text(
            'Product List',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ProductItem(
            rS: "50",
            colorr: Colors.pinkAccent,
            itemName: 'Kurleez',
            onAddToCart: (itemName) {
              addToCart(itemName, "50");
            },
          ),
          const Divider(
            height: 7,
            color: Colors.pinkAccent,
          ),
          ProductItem(
            rS: "40",
            colorr: Colors.purpleAccent,
            itemName: 'Pista Biscuit',
            onAddToCart: (itemName) {
              addToCart(itemName, "40");
            },
          ),
          const Divider(
            height: 7,
            color: Colors.purpleAccent,
          ),
          ProductItem(
            rS: "60",
            colorr: Colors.black,
            itemName: 'Ringo',
            onAddToCart: (itemName) {
              addToCart(itemName, "60");
            },
          ),
          const Divider(
            height: 7,
            color: Colors.black,
          ),
          // Add more food items here...
        ],
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.pink,
        shape:
            const OvalBorder(side: BorderSide(color: Colors.white70, width: 2)),
        backgroundColor: const Color.fromARGB(255, 233, 138, 170),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShoppingCartScreen(
                cartItems: cartItems,
                price: price,
                quantities: List<int>.filled(cartItems.length, 1),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String itemName;
  final Function(String) onAddToCart;
  final Color colorr;
  final String rS;

  const ProductItem({
    Key? key,
    required this.rS,
    required this.colorr,
    required this.itemName,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 6,
        backgroundColor: colorr,
      ),
      subtitle: Text("PRICE: $rS"),
      title: Text(itemName),
      trailing: ElevatedButton(
        onPressed: () {
          onAddToCart(itemName);
        },
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(Colors.pink),
          overlayColor: MaterialStateProperty.all(
            Colors.pink,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Color.fromARGB(255, 252, 247, 247)),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            const Color.fromARGB(255, 233, 138, 170),
          ),
        ),
        child: const Text(
          'Add to Cart',
          style: TextStyle(color: Color.fromARGB(255, 252, 247, 247)),
        ),
      ),
    );
  }
}

class ShoppingCartScreen extends StatefulWidget {
  final List<String> cartItems;
  final List<int> quantities;
  final List<String> price;

  const ShoppingCartScreen({
    Key? key,
    required this.price,
    required this.quantities,
    required this.cartItems,
  }) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  void _removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
  }

  void increment(int index) {
    setState(() {
      if (widget.quantities[index] >= 0 && widget.quantities[index] < 10) {
        widget.quantities[index]++;
      }
    });
  }

  void decrement(int index) {
    setState(() {
      if (widget.quantities[index] > 0) {
        widget.quantities[index]--;
      }
    });
  }

  double _calculateItemTotalPrice(int index) {
    double itemPrice = double.parse(widget.price[index]);
    return itemPrice * widget.quantities[index];
  }

  double _calculateTotalBill() {
    double totalBill = 0;
    for (int i = 0; i < widget.cartItems.length; i++) {
      totalBill += _calculateItemTotalPrice(i);
    }
    return totalBill;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 138, 170),
        title: const Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                subtitle: Text('PRICE: ${widget.price[index]}'),
                leading: Text(
                  "${widget.quantities[index]}",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                title: Text(
                  widget.cartItems[index],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Total: \$${_calculateItemTotalPrice(index).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        increment(index);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        decrement(index);
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _removeItem(index);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.brown,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.green,
                height: 7,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Bill: \$${_calculateTotalBill().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement checkout functionality
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
