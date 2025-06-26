import 'dart:convert';
import "package:http/http.dart" as http;
import '../models/user.dart';
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api';

  Future<User> register(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'email': email, 'password': password}),
    );
    if (response.statusCode == 201) return User.fromJson(jsonDecode(response.body));
    throw Exception('Failed to register');
  }

  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) return User.fromJson(jsonDecode(response.body));
    throw Exception('Failed to login');
  }

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((j) => Product.fromJson(j)).toList();
    }
    throw Exception('Failed to load products');
  }

  Future<Product> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode == 201) return Product.fromJson(jsonDecode(response.body));
    throw Exception('Failed to create product');
  }

  Future<Product> updateProduct(String id, Product product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode == 200) return Product.fromJson(jsonDecode(response.body));
    throw Exception('Failed to update product');
  }

  Future<void> deleteProduct(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode != 200) throw Exception('Failed to delete product');
  }
}