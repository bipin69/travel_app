import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/app/di/di.dart';
import 'package:hotel_booking/features/auth/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/user_booking_page.dart';
import 'package:hotel_booking/features/dashboard1/admin_screens/view_model/booking_bloc.dart';
import 'package:hotel_booking/features/dashboard1/admin_screens/view_model/booking_event.dart';
import 'package:hotel_booking/features/dashboard1/admin_screens/view_model/booking_state.dart';

class VenueDetailPage extends StatelessWidget {
  final VenueEntity venue;

  const VenueDetailPage({required this.venue, super.key});

  @override
  Widget build(BuildContext context) {
    const String baseUrl = "http://192.168.1.68:3000";

    String imageUrl = venue.images.isNotEmpty
        ? venue.images.first.startsWith("http")
            ? venue.images.first
            : "$baseUrl${venue.images.first}"
        : "assets/images/no_image.png";

    return BlocProvider(
      create: (_) => getIt<BookingBloc>(),
      child: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Tour booked successfully"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const UserBookingPage()),
            );
          } else if (state is BookingOperationFailure) {
            // The state.error will be the text from DioException.error
            final normalizedError = state.error.trim().toLowerCase();
            final errorMessage = normalizedError.contains("already booked")
                ? "You have already booked this Tour."
                : state.error;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.blue,
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title:
                Text(venue.name, style: const TextStyle(color: Colors.white)),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: imageUrl.contains("assets")
                        ? Image.asset(imageUrl,
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover)
                        : Image.network(imageUrl,
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                            return Image.asset("assets/images/no_image.png",
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.cover);
                          }),
                  ),
                  const SizedBox(height: 20),
                  Text(venue.name,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.blue),
                      const SizedBox(width: 5),
                      Text(venue.location,
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Room: ${venue.capacity}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Text("Price: \$${venue.price.toStringAsFixed(2)} / Night",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text("Description:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(venue.description,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87)),
                  const SizedBox(height: 20),
                  Center(
                    child: Builder(
                      builder: (context) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: () {
                            context
                                .read<BookingBloc>()
                                .add(CreateBookingEvent(venue.id));
                          },
                          child: const Text("Book Now",
                              style: TextStyle(color: Colors.white)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
