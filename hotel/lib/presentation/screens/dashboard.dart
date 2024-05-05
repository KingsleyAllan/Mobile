import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final String title;

  const Dashboard({required this.title, super.key});

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
            // Image.asset(
            //   'images/rosewood.png',
            //   fit: BoxFit.cover,
            //   width: double.infinity,
            //   height: 240,
            // ),
            // const SizedBox(height: 10),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'DASHBOARD',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            ElevatedButton(
              onPressed: ()  {
                Navigator.pushNamed(context, '/addhotel');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor, 
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Reduce the roundness of the borders
                ),
              ),
              child:  Text(
                'ADD A NEW HOTEL',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30,),

            ElevatedButton(
              onPressed: () async {
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor, 
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Reduce the roundness of the borders
                ),
              ),
              child:  Text(
                'MANAGE HOTELS',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),

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
