import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/background_scaffold.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/common_widgets/green_buttons.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/helpers/date_formatter_helper.dart';
import 'package:green_puducherry/models/plant_image_model.dart';
import 'package:green_puducherry/models/plant_model.dart';
import 'package:green_puducherry/providers/auth_provider.dart';
import 'package:green_puducherry/providers/plant_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/profile_info_tail.dart';
import '../../../common_widgets/image_for_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<AuthProvider>(context).userModel;
    PlantModel? currentPlantModel =
        Provider.of<PlantProvider>(context).currentPlantModel;
    return BackgroundScaffold(
        appBar: greenAppBar(
            title: "Profile Information", leading: GreenBackButton()),
        body: userModel == null
            ? SizedBox()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileInfoTail(
                        field: "username", value: userModel.userName),
                    ProfileInfoTail(
                        field: "Mobile Number", value: userModel.mobileNumber),
                    ProfileInfoTail(field: "Address", value: userModel.address),
                    ProfileInfoTail(
                        field: "Pin Code", value: userModel.pincode),
                    ProfileInfoTail(
                        field: "Region", value: userModel.region.regionName),
                    ProfileInfoTail(
                        field: "Commune/Municipality",
                        value: userModel.commune.communeName),

                    /// tree model
                    if (currentPlantModel != null)
                      Column(
                        children: [
                          Divider(thickness: 2),
                          ProfileInfoTail(
                              field: "Tree Name",
                              value: currentPlantModel.plantName),
                          ProfileInfoTail(
                              field: "Latitude",
                              value: currentPlantModel.latitude),
                          ProfileInfoTail(
                              field: "Longitude",
                              value: currentPlantModel.longitude),
                          ProfileInfoTail(
                              field: "Status", value: currentPlantModel.status),
                          ProfileInfoTail(
                              field: "Planted date",
                              value: DateFormatterHelper.formattedDate(
                                  stringDate: currentPlantModel.date)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 3.h),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              width: 1.sw,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3.r)),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: currentPlantModel.plantImages
                                      .map((PlantImageModel e) {
                                    return ImageForView(imageModel: e);
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ));
  }
}
