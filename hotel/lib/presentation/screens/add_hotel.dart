import 'package:flutter/material.dart';
import 'package:hotel/domain/models/hotel_model.dart';
import 'package:hotel/domain/services/image_service.dart';
import 'package:hotel/presentation/screens/manage_hotels.dart';
// import 'package:hotel/presentation/screens/dashboard.dart';
import 'package:hotel/providers/hotel_provider.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _picker = ImagePicker();
  double rating = 0.0;
  String? _selectedContinent;

  String? _imagePath;

  final List<String> _continents = [
    'Europe',
    'The America',
    'Middle East',
    'Asia and Pacific',
  ];

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    descriptionController.dispose();
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
                  activeTrackColor: const Color.fromRGBO(9, 30, 61, 1.0),
                  inactiveTrackColor: Colors.grey,
                  trackHeight: 3.0,
                  thumbColor: const Color.fromRGBO(9, 30, 61, 1.0),
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                  overlayColor: const Color.fromRGBO(9, 30, 61, 0.3),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 20.0),
                  tickMarkShape:
                      const RoundSliderTickMarkShape(tickMarkRadius: 2.0),
                  activeTickMarkColor: const Color.fromRGBO(9, 30, 61, 1.0),
                  inactiveTickMarkColor: Colors.grey,
                  valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: const Color.fromRGBO(9, 30, 61, 1.0),
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

              ElevatedButton(
                onPressed: () async {
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery, // or ImageSource.camera
                  );
                  if (image != null) {
                    setState(() => _imagePath = image.path);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'SELECT A HOTEL IMAGE',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 12, color: Theme.of(context).primaryColor),
                ),
              ),
              const SizedBox(height: 10),

              Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _imagePath != null) {
                      // Access data from controllers
                      String name = nameController.text;
                      String location = locationController.text;
                      String description = descriptionController.text;

                      final imageService =
                          Provider.of<ImageService>(context, listen: false);
                      String? downloadUrl =
                          await imageService.uploadImage(_imagePath!);

                      // ignore: unnecessary_null_comparison
                      if (downloadUrl != null) {
                        // Generate a unique ID for the hotel
                        var uuid = const Uuid();
                        String id = uuid.v4();

                        // Create a new hotel object
                        Hotel hotel = Hotel(
                          name: name,
                          continent: _selectedContinent!,
                          location: location,
                          description: description,
                          imageUrl: downloadUrl,
                          rating: rating,
                          id: id,
                        );

                        // Access the provider
                        context.read<HotelProvider>().addHotel(hotel);

                        //if successful redirect to the homepage
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ManageHotel()));
                      } else {
                        // Show a message if image is not picked or form is invalid
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please pick an image and fill in all fields'),
                          ),
                        );
                      }
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
                );
              })

              // Submit button
            ],
          ),
        ),
      ),
    );
  }
}
