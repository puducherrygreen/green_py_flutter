import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/background_scaffold.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/common_widgets/green_buttons.dart';
import 'package:green_puducherry/helpers/date_formatter_helper.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/providers/plant_provider.dart';
import 'package:green_puducherry/screens/gallery/pages/gallery.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/green_drawer.dart';

class AllPlantsGallery extends StatefulWidget {
  const AllPlantsGallery({super.key});

  @override
  State<AllPlantsGallery> createState() => _AllPlantsGalleryState();
}

class _AllPlantsGalleryState extends State<AllPlantsGallery> {
  bool loading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final plantProvider = Provider.of<PlantProvider>(context);
    return BackgroundScaffold(
      isDashboard: true,
      loading: loading,
      scaffoldKey: scaffoldKey,
      drawer: const GreenDrawer(),
      appBar: greenAppBar(
          title: "All Plants Gallery",
          leading: GreenMenuButton(scaffoldKey: scaffoldKey)),
      body: PopScope(
          canPop: false,
          child: Material(
            color: Colors.transparent,
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                children: plantProvider.plantModels
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: ListTile(
                          title: Text(e.plantName),
                          subtitle: Text(
                              DateFormatterHelper.ddMMyy(stringDate: e.date)),
                          tileColor: Colors.white,
                          trailing:
                              const Icon(Icons.keyboard_double_arrow_right),
                          onTap: () async {
                            loading = true;
                            setState(() {});
                            await plantProvider.setCurrentPlant(e);
                            print(e.convertIntoMap());
                            loading = false;
                            setState(() {});
                            if (context.mounted) {
                              MyNavigation.to(context, Gallery(plantModel: e));
                            }
                          },
                        ),
                      ),
                    )
                    .toList()),
          )),
    );
  }
}
