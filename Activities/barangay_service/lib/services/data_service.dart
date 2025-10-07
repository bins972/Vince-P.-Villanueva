import 'package:flutter/material.dart';
import '../models/service.dart';
import '../models/announcement.dart';

class DataService {
  static List<Service> getServices() {
    return const [
      Service(
        id: 'brgy_clearance',
        title: 'Barangay Clearance',
        description: 'Proof you are a resident in good standing.',
        icon: Icons.fact_check_rounded,
        estMinutes: 15,
        fee: 50,
      ),
      Service(
        id: 'certificate_residency',
        title: 'Certificate of Residency',
        description: 'For school, work, or government transactions.',
        icon: Icons.home_rounded,
        estMinutes: 12,
        fee: 0,
      ),
      Service(
        id: 'building_permit',
        title: 'Building/Repair Permit',
        description: 'Permit for construction or major repairs.',
        icon: Icons.construction_rounded,
        estMinutes: 30,
        fee: 150,
      ),
      Service(
        id: 'business_registration',
        title: 'Business Registration',
        description: 'Register a small business within the barangay.',
        icon: Icons.store_rounded,
        estMinutes: 25,
        fee: 100,
      ),
      Service(
        id: 'medical_assistance',
        title: 'Medical Assistance Request',
        description: 'Request financial aid for medical emergencies.',
        icon: Icons.local_hospital_rounded,
        estMinutes: 45,
        fee: 0,
      ),
    ];
  }

  static List<Announcement> getAnnouncements() {
    return [
      Announcement(
        id: 'a1',
        title: 'Scheduled Power Interruption',
        body: 'Power maintenance on Friday, 9 AM–4 PM.',
        date: DateTime(2025, 9, 17, 9, 0),
      ),
      Announcement(
        id: 'a2',
        title: 'Clean-up Drive',
        body: 'Join us this weekend at the covered court.',
        date: DateTime(2025, 9, 20, 7, 30),
      ),
    ];
  }
}
