import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/helpers/date_formatter_helper.dart';
import 'package:green_puducherry/models/plant_image_model.dart';

class ImageForView extends StatelessWidget {
  const ImageForView({
    super.key,
    required this.imageModel,
  });
  final PlantImageModel imageModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 100.w,
                width: 100.w,
                color: Colors.grey[200],
                child: Image.network(
                  imageModel.plantImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            const Text("Photo Taken Date"),
            Text(DateFormatterHelper.ddMMyy(stringDate: imageModel.date))
          ],
        ),
      ),
    );
  }
}
