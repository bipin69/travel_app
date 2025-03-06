import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/app/di/di.dart';
import 'package:hotel_booking/core/theme/app_theme.dart';
import 'package:hotel_booking/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:hotel_booking/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/view_model/contact_bloc_view.dart';
import 'package:hotel_booking/features/dashboard1/admin_screens/view_model/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/view_model/home_cubit.dart';
import 'package:hotel_booking/features/splash/presentation/view/splash_view.dart';
import 'package:hotel_booking/features/splash/presentation/view_model/splash_cubit.dart';

// Import VenueBloc for venue management


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (_) => getIt<SplashCubit>(),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => getIt<HomeCubit>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (_) => getIt<RegisterBloc>(),
        ),
        BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
        ),
        BlocProvider<ContactBlocView>(
          create: (_) => getIt<ContactBlocView>(),
        ),
        
        // Add VenueBloc globally so that it is accessible in your venue management screens
        BlocProvider<VenueBloc>(
          create: (_) => getIt<VenueBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quick Stay',
        theme: AppTheme.getApplicationTheme(isDarkMode: false),
        home: const SplashView(),
      ),
    );
  }
}
