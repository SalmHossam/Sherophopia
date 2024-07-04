
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//okay
class BookAppointments extends StatefulWidget {
  @override
  _BookAppointmentsState createState() => _BookAppointmentsState();
}

class _BookAppointmentsState extends State<BookAppointments> {
  late DateTime bookingStart;
  late DateTime bookingEnd;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    bookingStart = DateTime.now();
    bookingEnd = bookingStart.add(Duration(hours: 8)); // 8 hours of available sessions
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Appointments')),
      body: BookingCalendar(
        bookingService: BookingService(
          serviceName: 'Consultation',
          serviceDuration: 60,
          bookingStart: bookingStart,
          bookingEnd: bookingEnd,
          userId: '1', // Use userId instead of providerId
        ),
        getBookingStream: _fetchAppointmentsFromFirebase,
        uploadBooking: _uploadBooking,
        convertStreamResultToDateTimeRanges: _convertStreamResultToDateTimeRanges,
      ),
    );
  }

  Stream<List<DateTimeRange>> _fetchAppointmentsFromFirebase({required DateTime start, required DateTime end}) async* {
    final appointmentsRef = _firestore.collection('appointments');
    final appointmentsSnapshot = await appointmentsRef.get();
    final appointments = appointmentsSnapshot.docs;

    List<DateTimeRange> bookings = appointments.map((appointment) {
      final startTime = appointment['startTime'].toDate();
      final endTime = appointment['endTime'].toDate();
      return DateTimeRange(start: startTime, end: endTime);
    }).toList();

    yield bookings;
  }

  Future<void> _uploadBooking({required BookingService newBooking}) async {
    // Implement the logic to upload the booking to the database
    final bookingRef = _firestore.collection('appointments');
    await bookingRef.add({
      'startTime': newBooking.bookingStart,
      'endTime': newBooking.bookingEnd,
      'userId': newBooking.userId,
    });
  }

  List<DateTimeRange> _convertStreamResultToDateTimeRanges({required dynamic streamResult}) {
    // Convert the stream result into a list of DateTimeRanges
    return streamResult;
  }
}
