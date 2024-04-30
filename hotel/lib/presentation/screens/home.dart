import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({required this.title, super.key});

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

      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset(
              'images/rosewood.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 240,
            ),
            const SizedBox(height: 10),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Discover a global collection of one-of-a-kind luxury hotels, resorts and residences, each inspired by our A Sense of Place® philosophy to reflect the local culture and spirit of a destination.',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0), // Adjust the value as needed
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'UNITED STATES / CANADA',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0), // Adjust the value as needed
              child: SizedBox(
                height: 200, // Adjust height as needed
                child: ListView(
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      width: 200,
                      color: Colors.white,
                      

                    ),
                    const SizedBox(width: 15),
                    Container(
                      width: 200,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 15,),
                    Container(
                      width: 200,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            )

            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         Navigator.pushNamed(context, '/login');
            //       },
            //       child: const Text('Login'),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {
            //         Navigator.pushNamed(context, '/signup');
            //       },
            //       child: const Text('Sign up'),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.search_sharp), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.bed_sharp), label: 'Settings'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person_outline_sharp), label: 'Profile')
      //   ],
      // ),
    );
  }
}
