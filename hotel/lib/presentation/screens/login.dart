// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:hotel/providers/auth_provider.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//   @override
//   State<LoginScreen> createState() => _CreateUserScreenState();
// }

// class _CreateUserScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 150,
//         flexibleSpace: const Image(
//           image: AssetImage('assets/images/home page header.png'),
//           fit: BoxFit.cover,
//         ),
//       ),

//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(30.0),
          
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start, // Left-align elements
//             children: [
//               const SizedBox(height: 20),
//               Text(
//                 'SIGN IN TO YOUR ACCOUNT',
//                 style: Theme.of(context).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 20,),
//                 textAlign:TextAlign.center,
//               ),
//               const SizedBox(height: 20),

//               TextField(
//   controller: _emailController,
//   decoration: InputDecoration(
//     labelText: 'EMAIL ADDRESS',
//     labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12,),
//     prefixIcon: const Icon(Icons.email_sharp),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(3.0),
//     ),
//     enabledBorder: OutlineInputBorder( // Border when the field is enabled
//       borderSide: const BorderSide(color: Colors.grey),
//       borderRadius: BorderRadius.circular(3.0),
//     ),
//     focusedBorder: OutlineInputBorder( // Border when the field is in focus
//       borderSide: const BorderSide(color: Colors.grey),
//       borderRadius: BorderRadius.circular(3.0),
//     ),
//   ),
//   keyboardType: TextInputType.emailAddress,
//   // Add validator for email field
//   validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your email';
//     }
//     if (!value.contains('@')) {
//       return 'Please provide a valid email address';
//     }
//     return null;
//   },
// ),
// const SizedBox(height: 16),

// TextField(
//   controller: _passwordController,
//   decoration: InputDecoration(
//     labelText: 'PASSWORD',
//     labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12,),
//     prefixIcon: const Icon(Icons.password), // Add password icon
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(3.0),
//     ),
//     enabledBorder: OutlineInputBorder( // Border when the field is enabled
//       borderSide: const BorderSide(color: Colors.grey),
//       borderRadius: BorderRadius.circular(3.0),
//     ),
//     focusedBorder: OutlineInputBorder( // Border when the field is in focus
//       borderSide: const BorderSide(color: Colors.grey),
//       borderRadius: BorderRadius.circular(3.0),
//     ),
//   ),
//   // Add validator for password field
//   validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your password';
//     }
//     if (value.length < 8) {
//       return 'Password must be at least 8 characters';
//     }
//     // Add more validation rules as needed
//     return null;
//   },
//   obscureText: true, // Obscure password by default
// ),


//               Row(
//                 // Align elements to the right for "Remember me" and "Forgot password?"
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Row(
//                     children: [
//                       // Checkbox(
//                       //   value: ,
//                       //   onChanged: (value) {
//                       //     // setState(() => _rememberMe = value!);
//                       //   },
//                       // ),
//                       Text('Remember me',),
//                     ],
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // Handle "Forgot password?" functionality (e.g., navigate to password reset)
//                     },
//                     child: const Text(
//                       'Forgot your password?',
//                       style: TextStyle(
//                         color: Color.fromRGBO(9, 30, 61, 1.0),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               ElevatedButton(
//                 onPressed: () async {
//                   String email = _emailController.text.trim();
//                   String password = _passwordController.text.trim();
//                   // Pass the current context to the AuthProvider
//                   await context
//                       .read<AuthProvider>()
//                       .signInWithEmailAndPassword(context, email, password);
//                   // Check if the user is created successfully
//                   if (context.read<AuthProvider>().user != null) {
//                     Navigator.pushNamed(context, '/profile');
//                   }
//                 },
//                 child: const Text('SIGN IN'),
//                 style: ElevatedButton.styleFrom(
                  
//                   minimumSize: const Size(double.infinity, 50), // Full width button
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Don\'t have an account?'),
//                   TextButton(
//                     onPressed: () => Navigator.pushNamed(context, '/signup'),
//                     child: const Text('Create New Account'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),

// ignore_for_file: use_build_context_synchronously

//     );
//   }
// }
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

                Row(
                  // Align elements to the right for "Remember me" and "Forgot password?"
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Optional checkbox for "Remember me" functionality
                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       value: _rememberMe,
                    //       onChanged: (value) {
                    //         setState(() => _rememberMe = value!);
                    //       },
                    //     ),
                        Text('Remember me',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16,)
                        ),
                    //   ],
                    // ),
                    TextButton(
                      onPressed: () {
                        // Handle "Forgot password?" functionality (e.g., navigate to password reset)
                        // You can use a navigation package like Navigator.pushNamed(context, '/forgotPassword');
                      },
                      child:  Text(
                        'Forgot your password?',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14,)
                      ),
                    ),
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
                        await context
                            .read<AuthProvider>()
                            .signInWithEmailAndPassword(context, email, password);
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
                  child:  Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',
                    style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: Text('Create New Account',
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

