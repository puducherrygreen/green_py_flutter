import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/background_scaffold.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/common_widgets/green_buttons.dart';
import 'package:green_puducherry/providers/notification_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/notification_message.dart';

class QueryListPage extends StatelessWidget {
  const QueryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final np = Provider.of<NotificationProvider>(context);
    return BackgroundScaffold(
      appBar: greenAppBar(title: "Query Response", leading: GreenBackButton()),
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          children: np.allQueries != null
              ? np.allQueries!
                  .map((e) => NotificationMessage(
                        title: e.query,
                        message: e.response ?? "",
                        isReaded: false,
                        id: e.id,
                      ))
                  .toList()
              : []),
    );
  }
}
