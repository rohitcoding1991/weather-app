import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/constants/AppFonts.dart';
import '../../../components/constants/AppIcons.dart';
import '../../../components/constants/TextStyles.dart';
import '../../../components/coreComponents/ImageView.dart';
import '../../../components/coreComponents/TextView.dart';
import '../../../viewController/weather/weather_bloc.dart';

class HomeAppBar extends StatelessWidget {
  final Function() onTap;
  const HomeAppBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();

    return Padding(
      padding: const EdgeInsets.all(AppFonts.s16),
      child: Row(
        children: [
          Expanded(child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(text: bloc.appbarDate, textStyle: TextStyles.semiBold16White,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const ImageView(url: AppIcons.location, size: AppFonts.s14,margin: EdgeInsets.only(right: 3, top: 4),),
                    Expanded(child: TextView(text: bloc.appbarLocation, textStyle: TextStyles.regular14White,)),
                  ],)
                ],
              );
            },
          )),
          ImageView(
            onTap: onTap,
            url: AppIcons.building, size: AppFonts.s28)
        ],
      ),
    );
  }
}
