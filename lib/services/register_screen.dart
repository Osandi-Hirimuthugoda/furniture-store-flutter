import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _apiService.register(_usernameController.text, _emailController.text, _passwordController.text);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register - Furniture Store')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _usernameController, decoration: InputDecoration(labelText: 'Username'), validator: (v) => v!.isEmpty ? 'Enter username' : null),
              TextFormField(controller: _emailController, decoration: InputDecoration(labelText: 'Email'), validator: (v) => v!.isEmpty ? 'Enter email' : null),
              TextFormField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true, validator: (v) => v!.isEmpty ? 'Enter password' : null),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _register, child: Text('Register')),
              TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())), child: Text('Login')),
            ],
          ),
        ),
      ),
    );
  }
}