import 'package:equatable/equatable.dart';
import 'package:hotel_booking/features/auth/domain/entity/hotel_entity.dart';


abstract class VenueState extends Equatable {
  @override
  List<Object> get props => [];
}

class VenueLoadingState extends VenueState {}

class VenueLoadedState extends VenueState {
  final List<VenueEntity> venues;

  VenueLoadedState(this.venues);

  @override
  List<Object> get props => [venues];
}

class VenueErrorState extends VenueState {
  final String message;

  VenueErrorState(this.message);

  @override
  List<Object> get props => [message];
}
