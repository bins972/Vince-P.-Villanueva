import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  List<Map<String, dynamic>> _reservations = [];

  @override
  void initState() {
    super.initState();
    _loadReservations();
  }

  Future<void> _loadReservations() async {
    final prefs = await SharedPreferences.getInstance();
    final bookings = prefs.getStringList('bookings') ?? [];
    
    setState(() {
      _reservations = bookings.map((booking) => 
        jsonDecode(booking) as Map<String, dynamic>
      ).toList();
    });
  }

  Future<void> _cancelReservation(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final bookings = prefs.getStringList('bookings') ?? [];
    
    bookings.removeWhere((booking) {
      final bookingData = jsonDecode(booking) as Map<String, dynamic>;
      return bookingData['id'] == id;
    });
    
    await prefs.setStringList('bookings', bookings);
    _loadReservations();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reservation cancelled')),
      );
    }
  }

  void _showReservationDetails(Map<String, dynamic> reservation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reservation ${reservation['id']}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Guest: ${reservation['guestName']}'),
                Text('Phone: ${reservation['phone']}'),
                Text('Room: ${reservation['roomType']}'),
                Text('Guests: ${reservation['numberOfGuests']}'),
                Text('Check-in: ${reservation['checkInDate']} ${reservation['checkInTime']}'),
                Text('Check-out: ${reservation['checkOutDate']} ${reservation['checkOutTime']}'),
                if (reservation['includeBreakfast']) const Text('✓ Breakfast included'),
                if (reservation['includeParking']) const Text('✓ Parking included'),
                if (reservation['specialRequests']?.isNotEmpty == true)
                  Text('Special Requests: ${reservation['specialRequests']}'),
                const Divider(),
                Text('Status: ${reservation['status']}'),
                Text('Amount: \$${reservation['amount'].toStringAsFixed(2)}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reservations'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: _reservations.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hotel_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No reservations found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Book a room to see your reservations here',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _reservations.length,
              itemBuilder: (context, index) {
                final reservation = _reservations[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.hotel),
                    ),
                    title: Text('${reservation['roomType']} Room'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Guest: ${reservation['guestName']}'),
                        Text('${reservation['checkInDate']} - ${reservation['checkOutDate']}'),
                        Text('Status: ${reservation['status']}'),
                        Text('Amount: \$${reservation['amount'].toStringAsFixed(2)}'),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: PopupMenuButton<String>(
                      onSelected: (String value) {
                        switch (value) {
                          case 'view':
                            _showReservationDetails(reservation);
                            break;
                          case 'modify':
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Modify feature coming soon')),
                            );
                            break;
                          case 'cancel':
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Cancel Reservation'),
                                  content: const Text('Are you sure you want to cancel this reservation?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _cancelReservation(reservation['id']);
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          value: 'view',
                          child: Text('View Details'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'modify',
                          child: Text('Modify'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'cancel',
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/booking');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}