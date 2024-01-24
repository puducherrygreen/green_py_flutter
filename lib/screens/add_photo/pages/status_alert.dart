import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/constant/green_colors.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/providers/plant_provider.dart';
import 'package:green_puducherry/screens/add_photo/pages/camera_page.dart';
import 'package:provider/provider.dart';

class StatusAlert extends StatelessWidget {
  const StatusAlert({super.key});

  @override
  Widget build(BuildContext context) {
    PlantProvider plantProvider = Provider.of<PlantProvider>(context);
    return AlertDialog(
      title: const Text("We need to Know Your Plant Status"),
      titleTextStyle: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
      content: FittedBox(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  color: plantProvider.isAlive != null
                      ? plantProvider.isAlive ?? true
                          ? GreenColors.kMainColor
                          : Colors.grey[600]
                      : Colors.grey[600],
                  onPressed: () {
                    plantProvider.setPlantStatus(true);

                    // MyNavigation.to(context, const CameraPage());
                  },
                  child: const Text(
                    "Alive",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                MaterialButton(
                  color: plantProvider.isAlive != null
                      ? plantProvider.isAlive ?? true
                          ? Colors.grey[600]
                          : Colors.red[600]
                      : Colors.grey[600],
                  onPressed: () {
                    plantProvider.setPlantStatus(false);

                    // MyNavigation.to(context, const CameraPage());
                  },
                  child: const Text(
                    "Dead",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            
            if (plantProvider.isAlive != null)
              InkWell(
                onTap: () {
                  MyNavigation.to(context, const CameraPage());
                },
                child: Container(
                  width: 0.5.sw,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: GreenColors.kMainColor50,
                      ),
                      color: Colors.white60),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: GreenColors.kMainColor),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
