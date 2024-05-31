import 'package:flutter/material.dart';
import 'package:hotel/domain/models/hotel_model.dart';
import 'package:hotel/presentation/screens/hotel_details.dart';
import 'package:hotel/providers/hotel_provider.dart';
import 'package:provider/provider.dart';

class HotelList extends StatefulWidget {
  final String continent;

  const HotelList({super.key, required this.continent});

  @override
  State<HotelList> createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  late Future<List<Hotel>> futureHotels;

  @override
  void initState() {
    super.initState();
    Provider.of<HotelProvider>(context, listen: false).getHotelsByContinent(widget.continent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        flexibleSpace: const Image(
          image: AssetImage('assets/images/home page header.png'),
          fit: BoxFit.cover,
        ),
      ),

      body: Consumer<HotelProvider>(
        builder: (context, hotelProvider, child) {
          // ignore: unnecessary_null_comparison
          if (hotelProvider.hotels != null) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.continent,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: hotelProvider.hotels.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(hotelProvider.hotels[index].name,
                        style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text(hotelProvider.hotels[index].location,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15)
                        ),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HotelDetails(id: hotelProvider.hotels[index].id),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          }
        },
      ),
    ); 
  }
}
