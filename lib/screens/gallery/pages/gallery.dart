import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/models/plant_image_model.dart';
import 'package:green_puducherry/models/plant_model.dart';

import '../../../common_widgets/green_buttons.dart';
import '../../profile/widgets/profile_info_tail.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key, required this.plantModel});
  final PlantModel plantModel;

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar:
          greenAppBar(title: "Plant info", leading: const GreenBackButton()),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                ProfileInfoTail(
                    field: "Plant Name", value: plantModel.plantName),
                ProfileInfoTail(
                    field: "Plantation",
                    value: "${plantModel.plantLand?.landName}"),
                ProfileInfoTail(field: "Latitude", value: plantModel.latitude),
                ProfileInfoTail(
                    field: "Longitude", value: plantModel.longitude),
                Divider(thickness: 2.sp),
              ],
            ),
            Column(
                children: List.generate(plantModel.plantImages.length, (index) {
              PlantImageModel e = plantModel.plantImages[index];

              print('photo widgets ----------------');
              print(e.convertIntoMap());
              print(String.fromCharCode(index + 65));

              return PhotosWidgets(
                imageUrl: e.plantImage,
                date: e.formattedDate(),
                photoId: index + 1,
                status: e.status,
              );
            })
                //     plantProvider.plantModel!.plantImages.map((e) {
                //   print('photo widgets ----------------');
                //   print(e.convertIntoMap());
                //
                //   return PhotosWidgets(
                //     imageUrl: e.plantImage,
                //     date: e.formattedDate(),
                //   );
                // }).toList(),
                )
          ],
        ),
      ),
    );
  }
}

class PhotosWidgets extends StatelessWidget {
  const PhotosWidgets({
    super.key,
    required this.imageUrl,
    this.date,
    this.photoId,
    this.status,
  });

  final String imageUrl;
  final String? date;
  final int? photoId;
  final String? status;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: status == "Alive" ? Colors.white : Colors.red,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(3, 3),
            )
          ]),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Image.network(
                        imageUrl,
                      ),
                    );
                  });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                color: Colors.grey[200],
                height: 100.h,
                width: 100.w,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 5.w),
                Container(
                  height: 70.h,
                  width: 2,
                  color: status == "Alive"
                      ? GreenColors.kMainColor50
                      : Colors.white,
                ),
                SizedBox(width: 5.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GText(
                      "Photo-$photoId",
                      style: TextStyle(
                        color: status == "Alive"
                            ? GreenColors.kMainColor
                            : Colors.white,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    GText(
                      "$date",
                      style: TextStyle(
                        color: status == "Alive"
                            ? GreenColors.kMainColor
                            : Colors.white,
                      ),
                    ),
                    GText(
                      "$status",
                      style: TextStyle(
                        color: status == "Alive"
                            ? GreenColors.kMainColor
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
