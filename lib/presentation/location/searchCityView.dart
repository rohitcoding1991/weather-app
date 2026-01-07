import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/constants/AppFonts.dart';
import '../../components/coreComponents/TextView.dart';
import '../../model/addressModel.dart';
import '../../utils/AppExtensions.dart';
import '../../components/constants/TextStyles.dart';
import '../../components/coreComponents/EditText.dart';
import '../../components/widgets/AppBar2.dart';
import '../../viewController/weather/weather_bloc.dart';
import '../home/HomeView.dart';
import '../home/components/HomeForecast.dart';

class SearchCityView extends StatelessWidget {
  static const name = 'SearchCityView';

  const SearchCityView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();

    return PopScope(
      onPopInvoked: (value){
        bloc.add(ClearSearchCitiesEvent());
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              AppBar2(
                onLeadTap: context.pop,
                title: 'Search City',
                titleStyle: TextStyles.regular14White,
              ),
              EditText(
                controller: TextEditingController(),
                hint: 'Search',
                textStyle: TextStyles.medium14White,
                onChange: (value) =>
                    bloc.add(SearchCityEvent(value: value.trim())),
                margin: const EdgeInsets.symmetric(horizontal: AppFonts.s20),
              ),
              Expanded(
                  child: BlocConsumer<WeatherBloc, WeatherState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return ListView.separated(
                      padding: const EdgeInsets.all(AppFonts.s20),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => _card(
                          onTap: () {
                            if (bloc.savedCities.isEmpty) {
                              context.pushAndClearNavigator(const HomeView());
                            } else {
                              context.pop();
                            }
                            bloc.add(
                                AddCityEvent(value: bloc.searchCities[index]));
                          },
                          data: bloc.searchCities[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: AppFonts.s20,
                          ),
                      itemCount: bloc.searchCities.length);
                },
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _card({required AddressModel data, required Function() onTap}) {
    return cardContainer(
        width: double.maxFinite,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: data.city ?? '',
              textStyle: TextStyles.medium14White,
              margin: const EdgeInsets.only(bottom: AppFonts.s10),
            ),
            TextView(
              text:
                  data.getAddress,
              textStyle: TextStyles.regular12White,
            ),
          ],
        ));
  }
}
