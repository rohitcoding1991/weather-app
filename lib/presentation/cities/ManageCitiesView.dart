import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/constants/AppColors.dart';
import '../../components/coreComponents/TapWidget.dart';
import '../../model/addressModel.dart';
import '../../utils/AppExtensions.dart';
import '../../components/constants/AppFonts.dart';
import '../../components/constants/AppIcons.dart';
import '../../components/constants/TextStyles.dart';
import '../../components/coreComponents/ImageView.dart';
import '../../components/coreComponents/TextView.dart';
import '../../components/widgets/AppBar2.dart';
import '../../viewController/weather/weather_bloc.dart';
import '../home/components/HomeForecast.dart';
import '../location/searchCityView.dart';

class ManageCitiesView extends StatefulWidget {
  const ManageCitiesView({super.key});

  @override
  State<ManageCitiesView> createState() => _ManageCitiesViewState();
}

class _ManageCitiesViewState extends State<ManageCitiesView> {
  late WeatherBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WeatherBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if(_bloc.citiesEditState) _bloc.add(const EditCityEvent(value: false));
      },
      child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                AppBar2(
                  title: 'Manage Cities',
                  titleStyle: TextStyles.medium20White,
                  onLeadTap: context.pop,
                  tail: PopupMenuButton<int>(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: TextView(text: 'Edit', textStyle: TextStyles.medium14Black,),
                      ),
                    ],
                    offset: const Offset(0, 50),
                    elevation: 2,
                    child: const ImageView(
                      url: AppIcons.dot3,
                      size: AppFonts.s20,
                    ),
                    onSelected: (value) => _bloc.add(const EditCityEvent(value: true)),
                  ),
                ),
                Expanded(
                    child: BlocConsumer<WeatherBloc, WeatherState>(
                  listener: (context, state) {
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              padding: const EdgeInsets.only(
                                top: AppFonts.s20,
                                left: AppFonts.s20,
                                right: AppFonts.s20,
                                bottom: 100,
                              ),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => _card(
                                  data: _bloc.savedCities[index],
                                  editState: _bloc.citiesEditState,
                                  index: index,
                                  onTap: () {
                                    _bloc.add(ChooseCityForUpdatesEvent(
                                        value: _bloc.savedCities[index]));
                                    context.pop();
                                  }),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: AppFonts.s20,
                                  ),
                              itemCount: _bloc.savedCities.length),
                        ),
                        Visibility(
                            visible: _bloc.citiesEditState,
                            child: _editBottomView())
                      ],
                    );
                  },
                )),
              ],
            ),
          ),
          floatingActionButton: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              return !_bloc.citiesEditState
                  ? FloatingActionButton(
                      onPressed: () =>
                          context.pushNavigator(const SearchCityView()),
                      child: const Icon(Icons.add),
                    )
                  : const SizedBox.shrink();
            },
          )),
    );
  }

  Widget _editBottomView() {
    return Column(
      children: [
        const Divider(
          color: AppColors.grey20,
        ),
        Padding(
          padding: const EdgeInsets.all(AppFonts.s20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ImageView(
                onTap: () => _bloc.add(const EditCityEvent(value: false)),
                url: AppIcons.close,
                size: AppFonts.s16,
              ),
              TextView(
                onTap: _bloc.deleteBtnEdit ? ()=>_bloc.add(RemoveCitiesEvent()) : null,
                  text: 'Delete', textStyle: _bloc.deleteBtnEdit ?
              TextStyles.medium16White : TextStyles.medium16Grey,),
            ],
          ),
        )
      ],
    );
  }

  Widget _card({
    required int index,
    required AddressModel data,
    required Function() onTap,
    required bool editState,
  }) {
    final isActiveCard = data.isCordsEqual(_bloc.cords!);
    return Stack(
      children: [
        cardContainer(
            onTap: _bloc.citiesEditState ? null : onTap,
            bgColor: isActiveCard ? AppColors.primaryColor.withOpacity(0.6) : null ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ImageView(
                      url: AppIcons.location,
                      size: 10,
                      margin: EdgeInsets.only(right: 3, top: 5),
                    ),
                    Expanded(
                      child: TextView(
                        text: (data.city ?? '').trim().isEmpty
                            ? data.getAddress
                            : data.city ?? '',
                        textStyle: TextStyles.semiBold16White,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    child: (data.city ?? '').trim().isNotEmpty
                        ? TextView(
                            text: data.getAddress,
                            textStyle: TextStyles.regular12White,
                      margin: const EdgeInsets.only(top: 7),
                          )
                        : null)
              ],
            )),
        Visibility(
          visible: editState && !isActiveCard,
          child: Positioned(
            top: 10,
              right: 10,
              child:Checkbox(
                value: data.selected,
                onChanged: (value){
                  _bloc
                      .add(EditCityStateEvent(value: !data.selected, index: index));
                },
              )


          //     TapWidget(
          //   onTap: () => _bloc
          //       .add(EditCityStateEvent(value: !data.selected, index: index)),
          //   child:
          //
          //
          //
          //   // Container(
          //   //   height: 30,
          //   //   width: 30,
          //   //   color: data.selected ? AppColors.primaryGreen : AppColors.white,
          //   // ),
          // )

          ),
        )
      ],
    );
  }
}