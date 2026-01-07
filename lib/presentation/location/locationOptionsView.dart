import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/AppExtensions.dart';
import '../../components/constants/AppFonts.dart';
import '../../components/constants/TextStyles.dart';
import '../../components/coreComponents/AppButton.dart';
import '../../components/coreComponents/TextView.dart';
import '../../viewController/weather/weather_bloc.dart';
import '../home/HomeView.dart';
import 'searchCityView.dart';

class LocationSelectorView extends StatelessWidget {
  static const String name = 'LocationSelectorView';
  const LocationSelectorView({super.key});

  void _eventListener(BuildContext context, WeatherState state) {
    if (state is LocationSuccessState) {
      context.replaceNavigator(const HomeView());
    }else if (state is LoadingState && state.screenName == name){
      context.load;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(AppFonts.s20),
        child: BlocListener<WeatherBloc, WeatherState>(
            listener: _eventListener,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextView(
                  text: 'Choose your location',
                  textStyle: TextStyles.semiBold24CreamBrown,
                  margin: EdgeInsets.only(bottom: AppFonts.s40 * 3.5),
                ),
                AppButton(
                  onTap: () => context.pushNavigator(const SearchCityView()),
                  label: 'Search your City',
                ),
                TextView(
                  onTap: () => bloc.add(GetCurrentLocationEvent()),
                  text: 'Choose your current location',
                  textStyle: TextStyles.medium16White,
                  margin: const EdgeInsets.only(top: AppFonts.s20),
                ),
              ],
            )),
      ),
    );
  }
}
