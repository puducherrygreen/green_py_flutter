import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/common_widgets/green_buttons.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/helpers/date_formatter_helper.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/providers/plant_provider.dart';
import 'package:green_puducherry/screens/add_photo/pages/select_land.dart';
import 'package:green_puducherry/screens/add_photo/pages/select_plant.dart';
import 'package:provider/provider.dart';

class AllPlantList extends StatefulWidget {
  const AllPlantList({super.key});

  @override
  State<AllPlantList> createState() => _AllPlantListState();
}

class _AllPlantListState extends State<AllPlantList> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final plantProvider = Provider.of<PlantProvider>(context);
    return BackgroundScaffold(
        loading: loading,
        appBar:
            greenAppBar(title: "All Plants", leading: const GreenBackButton()),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: plantProvider.plantModels.isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Expanded(
                  child: plantProvider.plantModels.isEmpty
                      ? SizedBox(
                          width: 0.8.sw,
                          child: Image.asset(GreenImages.kPlanting),
                        )
                      : ListView(
                          padding: const EdgeInsets.only(top: 20),
                          children: plantProvider.plantModels
                              .map(
                                (e) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: ListTile(
                                    title: Text(e.plantName),
                                    subtitle: Text(DateFormatterHelper.ddMMyy(
                                        stringDate: e.date)),
                                    tileColor: Colors.white,
                                    trailing: const Icon(
                                        Icons.keyboard_double_arrow_right),
                                    onTap: () async {
                                      loading = true;
                                      setState(() {});
                                      await plantProvider.setCurrentPlant(e);
                                      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&');
                                      print(e.convertIntoMap()[
                                          'updateDateNextPhoto']);
                                      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&');
                                      loading = false;
                                      setState(() {});

                                      if (context.mounted) {
                                        MyNavigation.to(
                                            context, const SelectPlant());
                                      }
                                    },
                                  ),
                                ),
                              )
                              .toList()),
                ),
                GreenButton(
                  text: "Add New Plant",
                  onPressed: () async {
                    try {
                      loading = true;
                      setState(() {});
                      await plantProvider.getPlantLands();
                    } catch (e) {
                      loading = false;
                      setState(() {});
                    }
                    await plantProvider.removeCurrentPlant();
                    if (context.mounted) {
                      MyNavigation.replace(context, const SelectLand());
                    }
                  },
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ));
  }
}
