import 'package:flutter/material.dart';
import 'package:hotel/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a GlobalKey for the form
  bool _showPassword = false; // State variable for password visibility
  bool _rememberMe = false; // State variable for remember me

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        flexibleSpace: const Image(
          image: AssetImage('assets/images/home page header.png'),
          fit: BoxFit.cover,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey, // Apply the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Left-align elements
              children: [
                const SizedBox(height: 20),
                Text(
                  'SIGN IN TO YOUR ACCOUNT',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'EMAIL ADDRESS',
                    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                    prefixIcon: const Icon(Icons.email_sharp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromRGBO(9, 30, 61, 1.0)),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email address.';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address.';
                    }

                    return null; // No error
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                    prefixIcon: const Icon(Icons.password),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromRGBO(9, 30, 61, 1.0)),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility_off : Icons.visibility,
                        color:  const Color.fromRGBO(9, 30, 61, 1.0),
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password.';
                    }

                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long.';
                    }

                    return null; // No error
                  },
                  obscureText: !_showPassword, // Toggle password visibility
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                        Text(
                          'Remember me',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     // Handle "Forgot password?" functionality
                    //     // You can use a navigation package like Navigator.pushNamed(context, '/forgotPassword');
                    //   },
                    //   child: Text(
                    //     'Forgot your password?',
                    //     style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String email = _emailController.text.trim();
                      String password = _passwordController.text.trim();
                      // Pass the current context and email/password to the AuthProvider
                      try {
                        await context.read<AuthProvider>().signInWithEmailAndPassword(context, email, password);
                        // Check if the user is signed in successfully
                        if (context.read<AuthProvider>().user != null) {
                          Navigator.pushNamed(context, '/profile');
                        }
                      } catch (error) {
                        // Handle login errors (e.g., show a snackbar or dialog)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error.toString()),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Reduce the roundness of the borders
                    ),
                  ),
                  child: Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: Text(
                        'Create New Account',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
