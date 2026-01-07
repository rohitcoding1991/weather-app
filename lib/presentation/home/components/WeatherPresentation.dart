import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/utils/DateTimeUtils.dart';

import '../../../components/constants/AppColors.dart';
import '../../../components/constants/AppFonts.dart';
import '../../../components/constants/AppIcons.dart';
import '../../../components/constants/AppStrings.dart';
import '../../../components/constants/TextStyles.dart';
import '../../../components/coreComponents/ImageView.dart';
import '../../../components/coreComponents/TextView.dart';
import '../../../model/WeatherModel.dart';
import '../../../viewController/weather/weather_bloc.dart';
import 'HomeForecast.dart';

class WeatherPresentation extends StatelessWidget {
  const WeatherPresentation({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppFonts.s20),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
         final weatherCode = bloc.selectedHourWeatherData != null ? getWeatherHourlyCodeHour(daily: bloc.selectedHourWeatherData!.daily!, index: 0,data: bloc.selectedHourWeatherData!.hourly!) : null;
         Hourly? selectedHr = bloc.selectedHourWeatherData?.hourly;
      return SizedBox(
        child: bloc.selectedHourWeatherData != null  ?

        Column(
          children: [
             Stack(
              alignment: Alignment.center,
              children: [
                 ImageView(
                   url: weatherCode?['image'] ?? '',
                   height: 170,
                   width: 200,
                   margin: const EdgeInsets.only(bottom: AppFonts.s24 * 2),),
                Positioned(
                  bottom: 10,
                    child: TextView(text: '${selectedHr?.temperature2M?[0]}${AppStrings.degree}',textStyle: TextStyles.semiBold70WhiteShadow,))
              ],
            ),
             TextView(
              text: weatherCode?['description'] ?? '',
              textStyle: TextStyles.medium16White,),
             TextView(
              text: 'Feel like ${selectedHr?.apparentTemperature?[0]}${AppStrings.degree} | ${selectedHr?.time?[0].yyyy_MM_ddTHH_mm.EEEc_HHmm}',
              textStyle: TextStyles.regular14Grey,
              margin: const EdgeInsets.only(bottom: AppFonts.s10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _tile(icon: AppIcons.humidity, value: '${selectedHr?.relativehumidity2M?[0]}%'),
                _tile(icon: AppIcons.wind, value: '${selectedHr?.windspeed10M?[0]} km/h'),
                _tile(icon: AppIcons.pressure, value: '${selectedHr?.surfacePressure?[0]} hPa'),
              ],
            )
          ],
        ) : null,
      );
        },
      ),
    );
  }

  Widget _tile({required String icon, required String value}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageView(url: icon, size: AppFonts.s16,margin: const EdgeInsets.only(right: AppFonts.s7),tintColor: AppColors.white,),
        TextView(text: value,textStyle: TextStyles.medium14White,)
      ],
    );
  }
}