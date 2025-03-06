// 1 widget test
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/bookmark_view.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/view_model/hotel_bloc.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/view_model/hotel_event.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/view_model/hotel_state.dart';

import 'package:mocktail/mocktail.dart';


/// Mock VenueBloc**
class MockVenueBloc extends MockBloc<VenueEvent, VenueState>
    implements VenueBloc {}

///Fake VenueEvent & VenueState**
class FakeVenueEvent extends Fake implements VenueEvent {}

class FakeVenueState extends Fake implements VenueState {}

void main() {
  late MockVenueBloc mockVenueBloc;

  setUpAll(() {
    registerFallbackValue(FakeVenueEvent());
    registerFallbackValue(FakeVenueState());
  });

  setUp(() {
    mockVenueBloc = MockVenueBloc();
    when(() => mockVenueBloc.state).thenReturn(VenueLoadingState());
  });

  /// Helper function to load Venue Screen**
  Widget loadVenueScreen() {
    return BlocProvider<VenueBloc>.value(
      value: mockVenueBloc,
      child: MaterialApp(
        home: BookmarkView(),
      ),
    );
  }

  /// Check if AppBar Title is Present**
  testWidgets('should display AppBar title "Hotels"', (WidgetTester tester) async {
    await tester.pumpWidget(loadVenueScreen());
    await tester.pumpAndSettle();

    expect(find.text('Hotels'), findsOneWidget);
  });

}