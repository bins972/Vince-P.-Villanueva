import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final itemCount = context.watch<CartProvider>().itemCount; // rebuilds on change
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Cart ($itemCount)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => context.read<CartProvider>().clear(), // no rebuild for the button itself
            tooltip: 'Clear cart',
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cart, _) {
                if (cart.items.isEmpty) {
                  return const Center(child: Text('No items. Add some food.'));
                }
                return ListView(
                  children: cart.items.values.map((item) {
                    return ListTile(
                      leading: const Icon(Icons.fastfood),
                      title: Text(item.name),
                      subtitle: Text('Qty: ${item.quantity} • ₱${item.price.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => context.read<CartProvider>().removeItem(item.id),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<CartProvider>(
                  builder: (context, cart, _) => Text(
                    'Total: ₱${cart.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Add sample food'),
                  onPressed: () {
                    // Using read to perform action without triggering rebuild for this button
                    context.read<CartProvider>().addItem('food_${DateTime.now().millisecondsSinceEpoch}', 'Burger', 149.0);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}