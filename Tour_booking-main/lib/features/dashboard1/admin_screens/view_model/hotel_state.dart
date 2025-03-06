import 'package:equatable/equatable.dart';
import 'package:hotel_booking/features/auth/domain/entity/hotel.dart';

abstract class VenueState extends Equatable {
  const VenueState();

  @override
  List<Object?> get props => [];
}

class VenueInitial extends VenueState {}

class VenueLoading extends VenueState {}

class VenueLoaded extends VenueState {
  final List<Venue> venues;

  const VenueLoaded(this.venues);

  @override
  List<Object?> get props => [venues];
}

class VenueOperationSuccess extends VenueState {
  final String message;

  const VenueOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class VenueError extends VenueState {
  final String error;

  const VenueError(this.error);

  @override
  List<Object?> get props => [error];
}
