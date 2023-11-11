import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/background_scaffold.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/providers/plant_provider.dart';
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
        body: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                    children: plantProvider.plantModel
                        .map(
                          (e) => ListTile(
                            title: Text("Tree name"),
                            tileColor: Colors.white,
                            trailing: Icon(Icons.keyboard_double_arrow_right),
                            onTap: () {
                              plantProvider.setCurrentPlant(e);
                              print(e.id);
                              MyNavigation.to(context, SelectPlant());
                            },
                          ),
                        )
                        .toList()),
              ),
              GreenButton(
                text: "Add New Plant",
                onPressed: () {
                  try {
                    loading = true;
                    setState(() {});
                    plantProvider.getAvailablePlants();
                  } catch (e) {
                    loading = false;
                    setState(() {});
                  }
                  plantProvider.removeCurrentPlant();
                  MyNavigation.to(context, SelectPlant());
                },
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ));
  }
}
