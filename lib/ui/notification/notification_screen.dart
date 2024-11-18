import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/listview_builder_animation.dart';
import 'package:water_on_demand/ui/notification/controller/notification_controller.dart';

import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';
import '../../utils/base_no_data.dart';
import '../base_components/base_scaffold_background.dart';
import '../base_components/base_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await controller.getNotificationsList();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: AnimatedColumn(
              children: [
                buildSizeHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        BaseAssets.backArrow,
                        width: 19,
                        height: 20,
                      ),
                    ),
                    buildSizeWidth(80),
                    const BaseText(
                      value: 'Notifications',
                      color: BaseColors.secondaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                buildSizeHeight(30),
                Obx(() {
                  if(controller.notificationDataList.isEmpty){
                    return Column(
                      children: [
                        buildSizeHeight(200.0),
                        const BaseNoData(),
                      ],
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: controller.notificationDataList.length,
                    itemBuilder: (context, index) =>
                        ListviewBuilderAnimation(
                          index: index,
                          child: Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            child: Slidable(
                              key: const ValueKey(0),
                              // The start action pane is the one at the left or the top side.
                              endActionPane: ActionPane(
                                extentRatio: 0.2,
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),
                                children: [
                                  buildSizeWidth(18),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.deleteNotification(
                                            controller.notificationDataList[
                                            index].notificationId);
                                      });
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: const BoxDecoration(
                                        color: BaseColors.lightSky1,
                                      ),
                                      child: const Icon(CupertinoIcons.delete),
                                    ),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  color: BaseColors.secondaryColor.withOpacity(
                                      0.2),
                                  width: double.maxFinite,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        BaseText(
                                          value: "Notification ${index+1}",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        buildSizeHeight(8),
                                        BaseText(
                                          value: controller
                                              .notificationDataList[index]
                                              .message,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        buildSizeHeight(17),
                                        Flexible(
                                          child: BaseText(
                                            value: controller
                                                .notificationDataList[index].createdAt
                                                .toString(),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
