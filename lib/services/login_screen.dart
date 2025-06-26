import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/register_screen.dart';
import '../services/api_service.dart';
import 'product_list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _apiService.login(_emailController.text, _passwordController.text);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductListScreen()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login - Furniture Store')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _emailController, decoration: InputDecoration(labelText: 'Email'), validator: (v) => v!.isEmpty ? 'Enter email' : null),
              TextFormField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true, validator: (v) => v!.isEmpty ? 'Enter password' : null),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: Text('Login')),
              TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())), child: Text('Register')),
            ],
          ),
        ),
      ),
    );
  }
}