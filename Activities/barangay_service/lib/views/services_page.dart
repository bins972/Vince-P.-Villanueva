import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  // ✅ Static const list so it works with `const ServicesPage()`
  static const List<Map<String, dynamic>> services = [
    {
      "title": "Barangay Clearance",
      "subtitle": "Proof you are a resident",
      "icon": Icons.assignment,
    },
    {
      "title": "Certificate of Residency",
      "subtitle": "For school, work, or travel",
      "icon": Icons.home,
    },
    {
      "title": "Building/Repair Permit",
      "subtitle": "Permit for construction",
      "icon": Icons.construction,
    },
    {
      "title": "Business Registration",
      "subtitle": "Register a small business",
      "icon": Icons.business,
    },
  ];

  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barangay Service"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Selected: ${service['title']}")),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(service["icon"], size: 36, color: Colors.blue),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          service["title"] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service["subtitle"] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
