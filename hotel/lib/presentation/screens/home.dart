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
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
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

            // Padding(
            //   padding: const EdgeInsets.all(10.0), // Adjust the value as needed
            //   child: SizedBox(
            //     height: 200, // Adjust height as needed
            //     child: ListView(
            //       // This next line does the trick.
            //       scrollDirection: Axis.horizontal,
            //       children: <Widget>[
            //         Container(
            //           width: 200,
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start, //Align text to the left
            //             children: [
            //               // Image at the top
            //               ClipRRect(
            //                 child: Image.asset(
            //                   'images/littledixbay.png',
            //                   width: double.infinity,
            //                   height: 120,
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //               const SizedBox(height: 10),
            //               Text(
            //                 'Virgin Gorda, BVI',
            //                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
            //                   fontSize: 11,
            //                 )
                            
            //               ),
            //               Text(
            //                 'ROSEWOOD LITTLE DIX BAY',
            //                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 17,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         const SizedBox(width: 15),
            //         Container(
            //           width: 200,
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start, //Align text to the left
            //             children: [
            //               // Image at the top
            //               ClipRRect(
            //                 child: Image.asset(
            //                   'images/miramar.png',
            //                   width: double.infinity,
            //                   height: 120,
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //               const SizedBox(height: 10),
            //               Text(
            //                 'Montecito, CA. USA',
            //                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
            //                   fontSize: 11,
            //                 )
                            
            //               ),
            //               Text(
            //                 'ROSEWOOD MIRAMAR BEACH',
            //                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 17,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         const SizedBox(width: 15,),
            //         Container(
            //           width: 200,
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start, //Align text to the left
            //             children: [
            //               // Image at the top
            //               ClipRRect(
            //                 child: Image.asset(
            //                   'images/georgia.png',
            //                   width: double.infinity,
            //                   height: 120,
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //               const SizedBox(height: 10),
            //               Text(
            //                 'Vancouver, BC. Canada',
            //                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
            //                   fontSize: 11,
            //                 )
                            
            //               ),
            //               Text(
            //                 'ROSEWOOD HOTEL GEORGIA',
            //                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 17,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // )

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/adminlogin');
                  },
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('Sign up'),
                ),
              ],
            ),
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
