import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/utils/DateTimeUtils.dart';

import '../../../components/constants/AppColors.dart';
import '../../../components/constants/AppFonts.dart';
import '../../../components/constants/AppStrings.dart';
import '../../../components/constants/TextStyles.dart';
import '../../../components/constants/constants.dart';
import '../../../components/coreComponents/ImageView.dart';
import '../../../components/coreComponents/TapWidget.dart';
import '../../../components/coreComponents/TextView.dart';
import '../../../model/WeatherModel.dart';
import '../../../viewController/weather/weather_bloc.dart';

class HomeForecast extends StatelessWidget {
  final Function() onCardClick;

  const HomeForecast({super.key, required this.onCardClick});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();
    const hPadding = EdgeInsets.symmetric(horizontal: AppFonts.s20, vertical: 5);


    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {

        return SizedBox(
          child: bloc.weatherData != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header('Hourly Forecast'),
                    SizedBox(
                      height: 140,
                      child:  ListView.separated(
                          padding: hPadding,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => hourlyTile(
                              onTap: ()=> bloc.add(HourSelectEvent(index: index)),
                              data: bloc.currentWeatherData!,
                              bloc: bloc,
                              index: index),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: AppFonts.s16,
                          ),
                          itemCount:
                          bloc.currentWeatherData?.hourly?.time?.length ??
                              0,
                      ),
                    ),
                    header('Daily Forecast'),
                    ListView.separated(
                        padding: hPadding,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => dailyTile(
                            index: index,
                            data: bloc.weatherData!.daily!),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: AppFonts.s12),
                        itemCount: bloc.weatherData?.daily?.time?.length ?? 0,
                    )
                  ],
                )
              : null,
        );
      },
    );
  }

  Widget header(text) {
    return TextView(
      text: text,
      textStyle: TextStyles.semiBold16White,
      margin: const EdgeInsets.only(
          top: AppFonts.s20,
          bottom: AppFonts.s7,
          left: AppFonts.s20,
          right: AppFonts.s20),
    );
  }

  Widget dailyTile(
      {required Daily data, required int index}) {

    final weatherCode = weatherCodeJson['${data.weathercode?[index] ?? ''}']?['day'];
    return cardContainer(
        child: Row(
          children: [
            Expanded(
                flex: 5,
                child: TextView(
                  text: data.time?[index] != null
                      ? data.time![index].ddMMMyyyy
                      : '',
                  textStyle: TextStyles.medium14White,
                )),
            Column(
              children: [
                ImageView(
                  url: weatherCode?['image'] ?? '',
                  size: AppFonts.s40,
                ),
                TextView(
                  text: weatherCode?['description'] ?? '',
                  textStyle: TextStyles.regular10White,
                ),
              ],
            ),
            Expanded(
                flex: 4,
                child: TextView(
                  text:
                      '${data.temperature2MMin?[index]}${AppStrings.degree}/${data.temperature2MMax?[index]}${AppStrings.degree}',
                  textAlign: TextAlign.end,
                  textStyle: TextStyles.medium14White,
                )),
          ],
        ));
  }

  Widget hourlyTile(
      {required WeatherModel data,
      required int index,
        required WeatherBloc bloc,
      required Function() onTap,Key? key}) {

    final hourly = data.hourly!;
    var selectedTime = bloc.selectedHourWeatherData?.hourly?.time?[0];
    var time = hourly.time![index].yyyy_MM_ddTHH_mm;
    return cardContainer(
        key: key,
        bgColor: selectedTime != null ? selectedTime.yyyy_MM_ddTHH_mm.isAtSameMomentAs(time) ? AppColors.primaryColor.withOpacity(0.6): null: null,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextView(
              text: time.HHmm,
              textStyle: TextStyles.medium16White,
            ),
            ImageView(
              // url: AppIcons.appLogo,
                url: getWeatherHourlyCodeHour(daily: data.daily!, index: index,data: hourly)['image'] ?? '',
                size: 40,
                // imageType: ImageType.network,
                margin: const EdgeInsets.symmetric(vertical: 5)),
            TextView(
              // text: '27${AppStrings.degree}',
              text: '${hourly.temperature2M![index]}${AppStrings.degree}',
              textStyle: TextStyles.medium16White,
            ),
          ],
        ));
  }
}

Map<String, dynamic> getWeatherHourlyCodeHour(
    {required Daily daily, required Hourly data, required int index}) {

  final currentTime = data.time![index].yyyy_MM_ddTHH_mm;
  final sunRise = daily.sunrise![0].yyyy_MM_ddTHH_mm;
  final sunSet = daily.sunset![0].yyyy_MM_ddTHH_mm;
  final isDay = currentTime.isAfter(sunRise)  && currentTime.isBefore(sunSet);

  return weatherCodeJson['${data.weathercode?[index] ?? ''}']
  ?[isDay ? 'day' : 'night'] ??  {};
}

Widget cardContainer(
    {required Widget child, Function()? onTap, double? width, Color? bgColor, Key? key}) {
  const radius = AppFonts.s10;
  return Stack(
    key: key,
    children: [
      Container(
        width: width,
        padding: const EdgeInsets.all(AppFonts.s16),
        decoration: BoxDecoration(
            color: bgColor ?? AppColors.grey20.withOpacity(0.2),
            borderRadius: BorderRadius.circular(radius)),
        child: child,
      ),
      Positioned.fill(
          child: TapWidget(
        radius: radius,
        onTap: onTap,
      ))
    ],
  );
}