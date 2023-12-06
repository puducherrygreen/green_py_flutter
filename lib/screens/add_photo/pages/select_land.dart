import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/background_scaffold.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/providers/auth_provider.dart';
import 'package:green_puducherry/providers/plant_provider.dart';
import 'package:green_puducherry/screens/add_photo/pages/select_plant.dart';
import 'package:green_puducherry/screens/home/widgets/plant_type_button.dart';
import 'package:provider/provider.dart';

class SelectLand extends StatefulWidget {
  const SelectLand({super.key});

  @override
  State<SelectLand> createState() => _SelectLandState();
}

class _SelectLandState extends State<SelectLand> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    PlantProvider plantProvider = Provider.of(context);
    AuthProvider authProvider = Provider.of(context);
    return BackgroundScaffold(
        loading: loading,
        appBar: greenAppBar(title: "Select the Land"),
        body: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          childAspectRatio: 2.2,
          children: plantProvider.allPlantLands
              .map((e) => PlantTypeButton(
                    plantLandModel: e,
                    onPressed: () async {
                      loading = true;
                      setState(() {});
                      await plantProvider.setPlantType(e);
                      await authProvider.getRegion();
                      loading = false;
                      setState(() {});
                      if (context.mounted) {
                        MyNavigation.replace(
                            context,
                            SelectPlant(
                              enableDropDown:
                                  "my home (என் வீடு)" != e.landName,
                            ));
                      }
                    },
                  ))
              .toList(),
        ));
  }
}
