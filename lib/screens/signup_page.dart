import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/firebase/auth_methods.dart';
import 'package:newapp/screens/home_page.dart';
import 'package:newapp/utils/colors.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool obscureText = true;

  void signUp() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all the fields')),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      phone_no: _phoneController.text,
      name: _nameController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (res == 'Success') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occured signing up')),
      );
    }
  }

  Widget _buildTextField(
    TextEditingController controller,
    String labelText,
    IconData icon, {
    bool isPassword = false,
    bool readOnly = false,
    VoidCallback? toggleObscureText,
    VoidCallback? onTap,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: blue),
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: blue,
                  ),
                  onPressed: toggleObscureText,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.05),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "SIGN UP",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: blue,
                ),
              ),
            ),
            Form(
              child: Column(
                children: [
                  _buildTextField(_nameController, 'Name', Icons.person),
                  _buildTextField(_phoneController, 'Phone', Icons.call),
                  _buildTextField(_emailController, 'Email', Icons.email),
                  _buildTextField(
                    _passwordController,
                    "Password",
                    Icons.lock,
                    isPassword: true,
                    obscureText: obscureText,
                    toggleObscureText: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: signUp,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(size.width * 0.8, 50),
                            backgroundColor: blue2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ), // Ensure button is filled with the primary color
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
