import 'package:flutter/material.dart';
import 'package:hotel/domain/models/hotel_model.dart';
import 'package:hotel/presentation/screens/manage_hotels.dart';
// import 'package:hotel/presentation/screens/dashboard.dart';
import 'package:hotel/providers/hotel_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddHotelScreen extends StatefulWidget {
  const AddHotelScreen({super.key});

  @override
  State<AddHotelScreen> createState() => _AddHotelScreenState();
}

class _AddHotelScreenState extends State<AddHotelScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  double rating = 0.0;
  String? _selectedContinent;

  final List<String> _continents = [
    'Europe',
    'The Americas',
    'Middle East',
    'Asia and Pacific',
  ];

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).primaryColor,
        leading: const Icon(
          Icons.home_outlined,
          color: Colors.white,
          size: 27,
        ),
        title: Text(
          'ADD HOTEL',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HOTEL NAME',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12, color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 5),

              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(9, 30, 61, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),

              //

              Text(
                'CONTINENT',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 5),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(9, 30, 61, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                value: _selectedContinent,
                onChanged: (value) =>
                    setState(() => _selectedContinent = value),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a continent';
                  }
                  return null;
                },
                items: _continents.map((continent) {
                  return DropdownMenuItem<String>(
                    value: continent,
                    child: DefaultTextStyle(
                      style:
                          Theme.of(context).textTheme.displayLarge!.copyWith(),
                      child: Text(continent),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10.0,
              ),

              Text(
                'LOCATION',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 5),

              TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(9, 30, 61, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),

              Text(
                'DESCRIPTION',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 5),

              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(9, 30, 61, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a hotel description';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),

              Text(
                'RATINGS',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 5),

              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Color.fromRGBO(9, 30, 61, 1.0),
                  inactiveTrackColor: Colors.grey,
                  trackHeight: 3.0,
                  thumbColor: Color.fromRGBO(9, 30, 61, 1.0),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                  overlayColor: Color.fromRGBO(9, 30, 61, 0.3),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 2.0),
                  activeTickMarkColor: Color.fromRGBO(9, 30, 61, 1.0),
                  inactiveTickMarkColor: Colors.grey,
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: Color.fromRGBO(9, 30, 61, 1.0),
                  valueIndicatorTextStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 12, color: Colors.white),
                ),
                child: Slider(
                  value: rating,
                  min: 0.0,
                  max: 5.0,
                  divisions: 10,
                  label: '$rating',
                  onChanged: (newRating) {
                    setState(() => rating = newRating);
                  },
                ),
              ),

              Text(
                'UPLOAD IMAGE',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 5),

              TextFormField(
                controller: imageUrlController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(9, 30, 61, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid image url';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Access data from controllers
                    String name = nameController.text;
                    String location = locationController.text;
                    String description = descriptionController.text;
                    String imageUrl = imageUrlController.text;

                    var uuid = const Uuid();
                    String id = uuid.v4();
                    // Create a new hotel object
                    Hotel hotel = Hotel(
                        name: name,
                        continent: _selectedContinent!,
                        location: location,
                        description: description,
                        imageUrl: imageUrl,
                        rating: rating,
                        id: id);
                    // Access the provider
                    context.read<HotelProvider>().addHotel(hotel);

                    //if successful redirect to the homepage
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ManageHotel()));
                    Navigator.pushNamed(context, '/manegehotel');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'ADD HOTEL',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
