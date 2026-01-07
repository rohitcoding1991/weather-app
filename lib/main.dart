import 'package:flutter/material.dart';
import '../viewController/weather/weather_bloc.dart';

import 'components/constants/AppTheme.dart';
import 'presentation/splashView.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'services/Api/apiService.dart';
import 'services/repo/weatherRepo.dart';
import 'services/storage/sharedPref.dart';
import 'utils/LocationUtils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref().init();
  LocationUtils();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ApiService.create();
    final repo = WeatherRepoImpl(service: service);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => WeatherBloc(repo: repo)..add(StartEvent())),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      ),
    );
  }
}
