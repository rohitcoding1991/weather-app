import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/AppExtensions.dart';

import '../components/constants/AppFonts.dart';
import '../components/constants/AppIcons.dart';
import '../components/constants/TextStyles.dart';
import '../components/coreComponents/ImageView.dart';
import '../components/coreComponents/TextView.dart';
import '../viewController/weather/weather_bloc.dart';
import 'home/HomeView.dart';
import 'location/locationOptionsView.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  void _nextScreen(BuildContext context, WeatherState state) async{
      if (state is LauncherState) {
        Widget screen = state.hasLocation ? const HomeView() : const LocationSelectorView();
        await Future.delayed(const Duration(seconds: 3));
        context.replaceNavigator(screen);
      }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ImageView(url: AppIcons.appLogo, size: 100,),
            const TextView(text: 'Weather',
              textStyle: TextStyles.semiBold16White,
              margin: EdgeInsets.only(top: AppFonts.s10),),
            BlocConsumer<WeatherBloc, WeatherState>(
              listener: _nextScreen,
              builder: (context, state) {
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}

