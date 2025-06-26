import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import 'product_form_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = _apiService.getProducts();
  }

  void _refresh() {
    setState(() {
      _products = _apiService.getProducts();
    });
  }

  void _deleteProduct(String id) async {
    try {
      await _apiService.deleteProduct(id);
      _refresh();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Furniture Inventory')),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
          if (!snapshot.hasData || snapshot.data!.isEmpty) return Center(child: Text('No products'));
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final product = snapshot.data![index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('Price: \$${product.price}, Quantity: ${product.quantity}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: Icon(Icons.edit), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductFormScreen(product: product))).then((_) => _refresh())),
                    IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteProduct(product.id!)),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductFormScreen())).then((_) => _refresh()),
        child: Icon(Icons.add),
      ),
    );
  }
}