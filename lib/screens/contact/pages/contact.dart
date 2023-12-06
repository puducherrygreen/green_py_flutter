import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/helpers/validation_helper.dart';
import 'package:green_puducherry/providers/auth_provider.dart';
import 'package:green_puducherry/services/other_services.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common_widgets/green_appbar.dart';
import '../../../common_widgets/green_buttons.dart';
import '../../../common_widgets/green_drawer.dart';
import '../../../constant/constant.dart';
import '../../../helpers/pop_scope_function.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController queryController = TextEditingController();
  bool loading = false;

  bool queryValidate = true;

  queryValidater() {
    queryValidate =
        ValidationHelper.queryValidation(value: queryController.text.trim());
    setState(() {});
    return queryValidate;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return BackgroundScaffold(
        loading: loading,
        isDashboard: true,
        scaffoldKey: scaffoldKey,
        drawer: const GreenDrawer(),
        appBar: greenAppBar(
            title: "Contact Us",
            leading: GreenMenuButton(
              scaffoldKey: scaffoldKey,
            ),
            enableNotificationButton: true),
        body: WillPopScope(
          onWillPop: () async => await willPopBack(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Expanded(
                    flex: 10,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const GText("Ask Your Query"),
                          SizedBox(height: 10.h),
                          MyTextField(
                            isValid: queryValidate,
                            controller: queryController,
                            hintText: "Query",
                            errorText: "Minimum 3 words required",
                            minLine: 4,
                            maxLine: 4,
                            keyboardType: TextInputType.multiline,
                          ),
                          const Divider(),
                          Text(
                            GreenText.kQueryContent,
                            style: TextStyle(
                                fontSize: 14.sp, color: Colors.grey[80]),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              const Icon(
                                Icons.email,
                                color: GreenColors.kMainColor,
                              ),
                              SizedBox(width: 10.w),
                              SelectableText(
                                "greenpuducherry2023@gmail.com",
                                style: TextStyle(
                                    color: GreenColors.kMainColor,
                                    fontSize: 15.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: GreenColors.kMainColor,
                              ),
                              SizedBox(width: 10.w),
                              SelectableText(
                                "+91 8344499914",
                                style: TextStyle(
                                    color: GreenColors.kMainColor,
                                    fontSize: 15.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 50.w,
                                    width: 50.w,
                                    margin: EdgeInsets.all(5.w),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(GreenImages.kMoef),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                  Container(
                                    height: 50.w,
                                    width: 50.w,
                                    margin: EdgeInsets.all(5.w),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(GreenImages.kEnvis),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ],
                              ),
                              const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        "© App designed and developed by EIACP HUB, Puducherry."),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GreenButton(
                    text: "Send Query",
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      if (queryValidater()) {
                        loading = true;
                        setState(() {});
                        try {
                          await OtherServices.sendQuery(
                              query: queryController.text,
                              userId: authProvider.userModel!.id);
                          queryController.clear();
                          if (context.mounted) {
                            VxToast.show(context,
                                msg: "Your query has been sent");
                          }

                          print('completed query .....................');
                        } catch (e) {
                          if (context.mounted) {
                            VxToast.show(context, msg: "Something went wrong");
                          }
                        }
                        loading = false;
                        setState(() {});
                      } else {
                        VxToast.show(context, msg: "minimum 3 words required");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
