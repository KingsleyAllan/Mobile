import 'package:flutter/material.dart';
import 'package:hotel/providers/guest_count_provider.dart';
import 'package:hotel/providers/select_date_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({super.key});

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  late final SelectedDate _selectedDateProvider;
  late final GuestCountProvider _guestCountProvider;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  int _adults = 1;
  int _children = 0;

  @override
  void initState() {
    super.initState();
    _selectedDateProvider = Provider.of<SelectedDate>(context, listen: false);
    _guestCountProvider =
        Provider.of<GuestCountProvider>(context, listen: false);
  }

  void _incrementAdults() {
    _guestCountProvider.incrementAdults();
  }

  void _decrementAdults() {
    _guestCountProvider.decrementAdults();
  }

  void _incrementChildren() {
    _guestCountProvider.incrementChildren();
  }

  void _decrementChildren() {
    _guestCountProvider.decrementChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).primaryColor,
        leading: const Icon(
          Icons.calendar_month_sharp,
          color: Colors.white,
          size: 27,
        ),
        title: Text(
          'BOOKING CALENDAR',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar<DateTime>(
              firstDay: DateTime.utc(2020, 4, 1),
              focusedDay: _focusedDay,
              lastDay: DateTime.utc(2040, 12, 31),
              calendarFormat: _calendarFormat,
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                if (_rangeStart == null || _rangeEnd != null) {
                  _rangeStart = selectedDay;
                  _rangeEnd = null;
                } else if (_rangeEnd == null) {
                  _rangeEnd = selectedDay;
                }
                _selectedDateProvider.setSelectedDate(selectedDay);
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  _rangeStart = start;
                  _rangeEnd = end;
                  _focusedDay = focusedDay;
                  _selectedDay = null; // Clear the selected day
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Theme.of(context).primaryColor),
                weekendStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.15),
                  shape: BoxShape.rectangle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.rectangle,
                ),
                rangeStartDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.rectangle,
                ),
                rangeEndDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.rectangle,
                ),
                withinRangeDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.15),
                  shape: BoxShape.rectangle,
                ),
                rangeHighlightColor:
                    Theme.of(context).primaryColor.withOpacity(0.15),
                outsideDaysVisible: false,
                defaultTextStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                weekendTextStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                disabledTextStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'SELECT GUESTS',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Adults',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: Theme.of(context).primaryColor,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            iconSize: 18.0,
                            onPressed: _decrementAdults,
                          ),
                          Container(
                            width: 40.0,
                            height: 40.0,
                            child: Center(
                              child: Text(
                                '$_adults',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontSize: 16.0,
                                    ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).primaryColor,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            iconSize: 18.0,
                            onPressed: _incrementAdults,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Children',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: Theme.of(context).primaryColor,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            iconSize: 18.0,
                            onPressed: _decrementChildren,
                          ),
                          Container(
                            width: 40.0,
                            height: 40.0,
                            child: Center(
                              child: Text(
                                '$_children',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontSize: 16.0,
                                    ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).primaryColor,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            iconSize: 18.0,
                            onPressed: _incrementChildren,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle booking confirmation
                  if (_rangeStart != null && _rangeEnd != null) {
                    // Proceed with booking for the selected range
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
                  'CONFIRM',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
