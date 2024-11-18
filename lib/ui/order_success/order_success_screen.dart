import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/dashboard/dashboard_screen.dart';
import 'package:water_on_demand/ui/track_order/track_order_screen.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String orderId;
  final String orderItemId;

  const OrderSuccessScreen({
    super.key,
    required this.orderId,
    required this.orderItemId,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        body: SingleChildScrollView(
          child: AnimatedColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSizeHeight(82),
              BaseText(
                value: 'Order Id: $orderId',
                fontSize: 20,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
                color: BaseColors.black,
              ),
              buildSizeHeight(35),
              Image.asset(
                BaseAssets.orderSuccess,
                width: 217,
                height: 248,
              ),
              buildSizeHeight(25),
              const BaseText(
                value: 'Order Successful',
                color: BaseColors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              buildSizeHeight(14),
              const BaseText(
                value:
                    'The order has been placed successfully.\nYou can now track your order.',
                fontSize: 16,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
                color: BaseColors.black,
              ),
              buildSizeHeight(82),
              BaseButton(
                leftMargin: 13.0,
                rightMargin: 13.0,
                borderRadius: 0.0,
                title: 'Buy More',
                onPressed: () {
                  Get.offAll(() => const DashboardScreen(bodyIndex: 2));
                },
              ),
              buildSizeHeight(29),
              Align(
                alignment: AlignmentDirectional.center,
                child: GestureDetector(
                  onTap: () {
                    // Get.offAll(const DashboardScreen(bodyIndex: 1));
                    Get.off(TrackOrderScreen(orderItemId: orderItemId));
                    // Get.to(() => const TrackOrderScreen());
                  },
                  child: const BaseText(
                    value: 'Track Order',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: BaseColors.secondaryColor,
                  ),
                ),
              ),
              buildSizeHeight(29),
            ],
          ),
        ),
      ),
    );
  }
}
