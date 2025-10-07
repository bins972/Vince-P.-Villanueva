import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _guestNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _specialRequestsController = TextEditingController();
  
  String _roomType = 'Standard';
  int _numberOfGuests = 1;
  DateTime _checkInDate = DateTime.now();
  TimeOfDay _checkInTime = TimeOfDay.now();
  DateTime _checkOutDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _checkOutTime = const TimeOfDay(hour: 11, minute: 0);
  bool _includeBreakfast = false;
  bool _includeParking = false;

  @override
  void dispose() {
    _guestNameController.dispose();
    _phoneController.dispose();
    _specialRequestsController.dispose();
    super.dispose();
  }

  Future<void> _selectCheckInDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkInDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _checkInDate) {
      setState(() {
        _checkInDate = picked;
      });
    }
  }

  Future<void> _selectCheckInTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _checkInTime,
    );
    if (picked != null && picked != _checkInTime) {
      setState(() {
        _checkInTime = picked;
      });
    }
  }

  Future<void> _selectCheckOutDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkOutDate,
      firstDate: _checkInDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _checkOutDate) {
      setState(() {
        _checkOutDate = picked;
      });
    }
  }

  Future<void> _selectCheckOutTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _checkOutTime,
    );
    if (picked != null && picked != _checkOutTime) {
      setState(() {
        _checkOutTime = picked;
      });
    }
  }

  Future<void> _saveBooking() async {
    if (_formKey.currentState!.validate()) {
      final booking = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'guestName': _guestNameController.text,
        'phone': _phoneController.text,
        'roomType': _roomType,
        'numberOfGuests': _numberOfGuests,
        'checkInDate': DateFormat('yyyy-MM-dd').format(_checkInDate),
        'checkInTime': _checkInTime.format(context),
        'checkOutDate': DateFormat('yyyy-MM-dd').format(_checkOutDate),
        'checkOutTime': _checkOutTime.format(context),
        'includeBreakfast': _includeBreakfast,
        'includeParking': _includeParking,
        'specialRequests': _specialRequestsController.text,
        'status': 'Confirmed',
        'amount': _calculateAmount(),
      };

      final prefs = await SharedPreferences.getInstance();
      final bookings = prefs.getStringList('bookings') ?? [];
      bookings.add(jsonEncode(booking));
      await prefs.setStringList('bookings', bookings);

      if (mounted) {
        Navigator.pushNamed(context, '/payment', arguments: booking);
      }
    }
  }

  double _calculateAmount() {
    double basePrice = 0;
    switch (_roomType) {
      case 'Standard':
        basePrice = 100;
        break;
      case 'Deluxe':
        basePrice = 150;
        break;
      case 'Suite':
        basePrice = 250;
        break;
    }
    
    if (_includeBreakfast) basePrice += 25;
    if (_includeParking) basePrice += 15;
    
    return basePrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Room'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _guestNameController,
                decoration: const InputDecoration(
                  labelText: 'Guest Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter guest name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _roomType,
                decoration: const InputDecoration(
                  labelText: 'Room Type',
                  border: OutlineInputBorder(),
                ),
                items: ['Standard', 'Deluxe', 'Suite'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _roomType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Number of Guests: '),
                  const SizedBox(width: 16),
                  DropdownButton<int>(
                    value: _numberOfGuests,
                    items: [1, 2, 3, 4].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _numberOfGuests = newValue!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Check-in', style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(DateFormat('yyyy-MM-dd').format(_checkInDate)),
                              trailing: const Icon(Icons.calendar_today),
                              onTap: _selectCheckInDate,
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(_checkInTime.format(context)),
                              trailing: const Icon(Icons.access_time),
                              onTap: _selectCheckInTime,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Check-out', style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(DateFormat('yyyy-MM-dd').format(_checkOutDate)),
                              trailing: const Icon(Icons.calendar_today),
                              onTap: _selectCheckOutDate,
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(_checkOutTime.format(context)),
                              trailing: const Icon(Icons.access_time),
                              onTap: _selectCheckOutTime,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Include Breakfast (+\$25)'),
                value: _includeBreakfast,
                onChanged: (bool? value) {
                  setState(() {
                    _includeBreakfast = value!;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Include Parking (+\$15)'),
                value: _includeParking,
                onChanged: (bool value) {
                  setState(() {
                    _includeParking = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _specialRequestsController,
                decoration: const InputDecoration(
                  labelText: 'Special Requests',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveBooking,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: Text('Proceed to Payment (\$${_calculateAmount().toStringAsFixed(2)})'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}