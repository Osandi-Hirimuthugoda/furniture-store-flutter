import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  ProductFormScreen({this.product});

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.toString();
      _quantityController.text = widget.product!.quantity.toString();
    }
  }

  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: widget.product?.id,
        name: _nameController.text,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
      );
      try {
        if (widget.product == null) {
          await _apiService.createProduct(product);
        } else {
          await _apiService.updateProduct(widget.product!.id!, product);
        }
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Save failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product == null ? 'Add Product' : 'Edit Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _nameController, decoration: InputDecoration(labelText: 'Name'), validator: (v) => v!.isEmpty ? 'Enter name' : null),
              TextFormField(controller: _priceController, decoration: InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Enter price' : null),
              TextFormField(controller: _quantityController, decoration: InputDecoration(labelText: 'Quantity'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Enter quantity' : null),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _saveProduct, child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}