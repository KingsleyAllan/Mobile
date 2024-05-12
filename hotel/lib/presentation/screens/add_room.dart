import 'package:flutter/material.dart';
import 'package:hotel/domain/models/room_model.dart';
import 'package:hotel/providers/room_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddRoomScreen extends StatefulWidget {
  final String hotelId;

  const AddRoomScreen({super.key, required this.hotelId});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final headlineController = TextEditingController();
  final detailsController = TextEditingController();
  final sizeController = TextEditingController();
  final locationController = TextEditingController();
  final amenitiesController = TextEditingController();
  final rateController = TextEditingController();
  final imageUrlController = TextEditingController();
  double capacity = 0;
  bool _hasExtraBed = false;
  bool _isAvailable = true;
  String? _selectedType;

  final List<String> _type = [
    'Suite',
    'Deluxe',
    'Junior Suite',
    'Executive Suite',
    'Primier',
    'Grand Primier'
  ];

  @override
  void dispose() {
    nameController.dispose();
    headlineController.dispose();
    detailsController.dispose();
    sizeController.dispose();
    locationController.dispose();
    amenitiesController.dispose();
    rateController.dispose();
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
            Icons.door_sliding_sharp,
            color: Colors.white,
            size: 27,
          ),
          title: Text(
            'ADD ROOM',
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
                  'ROOM NAME',
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
                Text(
                  'ROOM TYPE',
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
                  value: _selectedType,
                  onChanged: (value) => setState(() => _selectedType = value),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a room type';
                    }
                    return null;
                  },
                  items: _type.map((continent) {
                    return DropdownMenuItem<String>(
                      value: continent,
                      child: DefaultTextStyle(
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(),
                        child: Text(continent),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'HEADLINE',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: headlineController,
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
                      return 'Please enter a headline for the room';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'ROOM DETAILS',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: detailsController,
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
                      return 'Please enter room details';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'SIZE',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: sizeController,
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
                      return 'Please enter a room size';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),

                Text(
                  'ROOM CAPACITY',
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
                    valueIndicatorShape:
                        const PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: const Color.fromRGBO(9, 30, 61, 1.0),
                    valueIndicatorTextStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 12, color: Colors.white),
                  ),
                  child: Slider(
                    value: capacity,
                    min: 0,
                    max: 5,
                    divisions: 10,
                    label: '$capacity peolpe',
                    onChanged: (newRating) {
                      setState(() => capacity = newRating);
                    },
                  ),
                ),

                Text(
                  'FLOOR LOCATION',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12, color: Theme.of(context).primaryColor),
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
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a floor a room is located';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),

                Text(
                  'AMENITIES & SERVICES',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: amenitiesController,
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
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter room amenities & services';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'RATE PER NIGHT (USD)',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: rateController,
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
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter room rate per night';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
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

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Checkbox(
                      value: _hasExtraBed,
                      onChanged: (value) =>
                          setState(() => _hasExtraBed = value!),
                    ),
                    Text(
                      'EXTRA BED',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12, color: Theme.of(context).primaryColor),
                    ),
                    Checkbox(
                      value: _isAvailable,
                      onChanged: (value) =>
                          setState(() => _isAvailable = value!),
                    ),
                    Text(
                      'ROOM AVILABILITY',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),

                // Submit button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Access data from controllers
                      String name = nameController.text;
                      String headline = headlineController.text;
                      String details = detailsController.text;
                      int size = int.parse(sizeController.text);
                      String location = locationController.text;
                      String amenities = amenitiesController.text;
                      double rate = double.parse(rateController.text);
                      String imageUrl = imageUrlController.text;

                      // Generate a unique ID for the hotel
                      var uuid = const Uuid();
                      String id = uuid.v4();

                      // Create a new room object
                      Room room = Room(
                        hotelId: widget.hotelId,
                        name: name,
                        type: _selectedType!,
                        headline: headline,
                        details: details,
                        size: size,
                        capacity: capacity,
                        location: location,
                        extraBed: _hasExtraBed,
                        amenities: amenities,
                        rate: rate,
                        isAvailable: _isAvailable,
                        imageUrl: imageUrl,
                        id: id,
                      );
                      
                       // Access the provider
                      context.read<RoomProvider>().addRoom(room);
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
        ));
  }
}
