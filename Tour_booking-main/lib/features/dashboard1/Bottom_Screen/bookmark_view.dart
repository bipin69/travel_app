import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/auth/data/data_source/remote_datasource/hotel_remote_datasource.dart';
import 'package:hotel_booking/features/auth/domain/repository/hotel_repository.dart';
import 'package:hotel_booking/features/auth/domain/use_case/get_all_hotels_usecase.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/view_model/hotel_bloc.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/view_model/hotel_event.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/view_model/hotel_state.dart';

import '../../auth/domain/entity/hotel_entity.dart';
import 'hotel_detail_page.dart';

class BookmarkView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VenueBloc(
          GetVenuesUseCase(VenueRepositoryImpl(VenueRemoteDataSource(Dio()))))
        ..add(LoadVenuesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tours'),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: BlocBuilder<VenueBloc, VenueState>(
          builder: (context, state) {
            if (state is VenueLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VenueLoadedState) {
              return ListView.builder(
                itemCount: state.venues.length,
                itemBuilder: (context, index) {
                  final venue = state.venues[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to VenueDetailPage on tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VenueDetailPage(venue: venue),
                        ),
                      );
                    },
                    child: VenueCard(venue: venue),
                  );
                },
              );
            } else if (state is VenueErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.blue, fontSize: 16),
                ),
              );
            }
            return const Center(child: Text("No data available."));
          },
        ),
      ),
    );
  }
}

class VenueCard extends StatelessWidget {
  final VenueEntity venue;

  const VenueCard({required this.venue, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String baseUrl = "http://192.168.1.68:3000";

    // Ensure the image URL is valid
    String imageUrl = venue.images.isNotEmpty
        ? venue.images.first.startsWith("http")
            ? venue.images.first
            : "$baseUrl${venue.images.first}"
        : "assets/images/no_image.png";

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      shadowColor: Colors.grey.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageUrl.contains("assets")
                  ? Image.asset(imageUrl,
                      height: 180, width: double.infinity, fit: BoxFit.cover)
                  : Image.network(imageUrl,
                      height: 180, width: double.infinity, fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/images/no_image.png",
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover);
                    }),
            ),
            const SizedBox(height: 10),
            Text(venue.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(venue.location, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("No. of People: ${venue.capacity}",
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                Text("Price: \$${venue.price.toStringAsFixed(2)} / Night",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 10),
            Text(venue.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
