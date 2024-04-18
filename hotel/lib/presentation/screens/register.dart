// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotel/presentation/screens/profile.dart';
//import 'package:hotel/presentation/home/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     children: [
      //       const LogoWidget(),
      //       TextFormField(
      //         controller: _emailController,
      //         decoration: const InputDecoration(
      //           labelText: 'Email',
      //         ),
      //         validator: (value) {
      //           // Check if email input is empty
      //           if (value!.isEmpty) {
      //             return 'Please enter your email';
      //           }

      //           if (!value.contains('@')) {
      //             return 'Please provide a valid Email address';
      //           }

      //           return null;
      //         },
      //       ),
      //       const SizedBox(height: 16),
      //       TextFormField(
      //         controller: _passwordController,
      //         decoration: const InputDecoration(
      //           labelText: 'Password',
      //         ),
      //         validator: (value) {
      //           if (value!.isEmpty) {
      //             return 'Please enter your password';
      //           }
      //           // Check if the password meets the criteria
      //           if (value.length < 8) {
      //             return 'Password must be at least 8 characters';
      //           }
      //           if (!value.contains(RegExp(r'[A-Z]'))) {
      //             return 'Password must contain at least one uppercase letter';
      //           }
      //           if (!value.contains(RegExp(r'[a-z]'))) {
      //             return 'Password must contain at least one lowercase letter';
      //           }
      //           if (!value.contains(RegExp(r'[0-9]'))) {
      //             return 'Password must contain at least one number';
      //           }

      //           return null;
      //         },
      //         obscureText: true,
      //       ),
      //       ElevatedButton(
      //         onPressed: () async {
      //           String email = _emailController.text.trim();
      //           String password = _passwordController.text.trim();
      //           // Pass the current context to the AuthProvider
      //           await context
      //               .read<AuthProvider>()
      //               .createUserWithEmailAndPassword(context, email, password);
      //           // Check if the user is created successfully
      //           if (context.read<AuthProvider>().user != null) {
      //             // Navigator.pushReplacement(
      //             //     context,
      //             //     MaterialPageRoute(
      //             //         builder: (context) => const ProfileScreen()));
      //             Navigator.pushNamed(context, '/profile');
      //           }
      //         },
      //         child: const Text('Sign Up'),
      //       ),
      //     ],
      //   ),
      // ),
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
                  'CREATE AN ACCOUNT',
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
                      borderSide: const BorderSide(color: Color.fromRGBO(9, 30, 61, 1.0),),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email address.';
                    }

                    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$").hasMatch(value)) {
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
                    prefixIcon: const Icon(Icons.password), // Add password icon
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromRGBO(9, 30, 61, 1.0),),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    // Add a suffix icon for toggling password visibility (optional)
                    // suffixIcon: IconButton(
                    //   icon: Icon(
                    //     _showPassword ? Icons.visibility_off : Icons.visibility,
                    //   ),
                    //   onPressed: () {
                    //     setState(() => _showPassword = !_showPassword);
                    //   },
                    // ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password.';
                    }

                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long.';
                    }

                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return 'Password must contain at least one uppercase letter.';
                    }
                    if (!RegExp(r'[a-z]').hasMatch(value)) {
                      return 'Password must contain at least one lowercase letter.';
                    }
                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return 'Password must contain at least one number.';
                    }

                    return null; // No error
                  },
                  obscureText: true, // Obscure password by default
                ),
                const SizedBox(height: 20),

                Text('By creating an account and clicking Create, I authorise Rosewood Hotel Group and any owner or developer of a project managed by or under one of Rosewood Hotel Group/s brands, to access, share, and use my profile, preferences, and personal information to provide me services in accordance with the Privacy Policy',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),                 

                ElevatedButton(
                  onPressed: () async {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
                    // Pass the current context to the AuthProvider
                    await context
                        .read<AuthProvider>()
                        .createUserWithEmailAndPassword(context, email, password);
                    // Check if the user is created successfully
                    if (context.read<AuthProvider>().user != null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                      Navigator.pushNamed(context, '/profile');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor, 
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Reduce the roundness of the borders
                    ),
                  ),
                  child:  Text(
                    'CREATE',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have An Account?',
                    style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                      child: Text('Login',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14,)
                        
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