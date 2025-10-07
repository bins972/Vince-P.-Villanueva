import 'package:flutter/material.dart';

class MediaDemoScreen extends StatelessWidget {
  const MediaDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final foods = [
      // Network images to avoid 404s when assets are not bundled
      'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=400&q=60',
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=60',
      'https://images.unsplash.com/photo-1481931715705-36f78a68d4b3?auto=format&fit=crop&w=400&q=60',
      'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=400&q=60',
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=60',
      'https://images.unsplash.com/photo-1543353071-873f17a7a5c4?auto=format&fit=crop&w=400&q=60',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Media & Assets Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('1) Local image (hotel):'),
            const SizedBox(height: 8),
            // Local image with fallback
            Image.network(
              'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=800&q=60',
              height: 180,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 16),
            const Text('2) Network image (rooms):'),
            const SizedBox(height: 8),
            Image.network(
              'https://images.unsplash.com/photo-1560067174-89436a6f9df8?auto=format&fit=crop&w=800&q=60',
              height: 180,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 16),
            const Text('3) Circular bordered image (room):'),
            const SizedBox(height: 8),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueAccent, width: 4),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                'https://images.unsplash.com/photo-1560067174-89436a6f9df8?auto=format&fit=crop&w=600&q=60',
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),
            const Text('4) GridView of food assets:'),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: foods.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    foods[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),

            const SizedBox(height: 24),
            const Text('13) Material Icons dynamic color/size:'),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.hotel, color: Colors.purple, size: 24),
                SizedBox(width: 12),
                Icon(Icons.hotel, color: Colors.orange, size: 32),
                SizedBox(width: 12),
                Icon(Icons.hotel, color: Colors.green, size: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}