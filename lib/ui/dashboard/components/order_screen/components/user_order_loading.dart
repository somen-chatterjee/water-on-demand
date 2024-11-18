import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/dashboard/components/order_screen/model/user_order_history_response.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_shimmer.dart';

import '../controller/user_order_history_controller.dart';

class UserOrderLoading extends StatefulWidget {
  const UserOrderLoading({super.key});

  @override
  State<UserOrderLoading> createState() => _UserOrderLoadingState();
}

class _UserOrderLoadingState extends State<UserOrderLoading> {
  UserOrderHistoryController controller = Get.find<UserOrderHistoryController>() ;

  /*
  * index == 0 -> Ongoing
  * index == 1 -> Cancelled
  * index == 2 -> Completed
  * */
  String showStatus({required int index}) {
    if (index == 0) {
      return 'Ongoing';
    }
    if (index == 1) {
      return 'Cancelled';
    }
    if (index == 2) {
      return 'Completed';
    }
    return 'Ongoing';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
      itemBuilder: (context,index) {
        return IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 19.0,
              horizontal: 20.0,
            ),
            margin: const EdgeInsets.only(bottom: 20.0),
            decoration: const BoxDecoration(color: BaseColors.white, boxShadow: [
              BoxShadow(
                color: BaseColors.lightGrey,
                blurRadius: 6.0,
                spreadRadius: 3.0,
                offset: Offset(0, 6),
              )
            ],),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BaseShimmer(
                  width: 92,
                  height: 92,
                ),
                buildSizeWidth(12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const BaseShimmer(
                         width: 80,
                         height: 15,
                      ),
                      buildSizeHeight(5.0),
                      const BaseShimmer(
                        width: 100,
                        height: 15,
                      ),
                      buildSizeHeight(5.0),
                      const BaseShimmer(
                        width: 60,
                        height: 15,
                      ),
                      buildSizeHeight(5.0),
                      const BaseShimmer(
                        width: 100,
                        height: 15,
                      ),
                    ],
                  ),
                ),
                buildSizeWidth(12.0),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseShimmer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        decoration: const BoxDecoration(
                          color: BaseColors.lightGrey,
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                        child:  const BaseText(
                          value: "kdfnskdn",
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: BaseColors.grey1,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.selectedIndex == 0,
                      child: const BaseShimmer(
                        height: 36,
                        width: 87,
                        borderRadius: 5,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
