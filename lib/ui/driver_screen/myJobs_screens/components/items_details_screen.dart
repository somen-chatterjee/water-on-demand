import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/driver_screen/myJobs_screens/model/driver_job_response.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';

class ItemsDetailsScreen extends StatelessWidget {
  final List<OrderedData> orderedData;

  const ItemsDetailsScreen({super.key, required this.orderedData});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: AnimatedColumn(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                leftPadding: 0.0,
                rightPadding: 0.0,
                children: [
                  buildSizeHeight(60),
                  ListView.separated(
                    itemCount: orderedData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 16.0,
                        ),
                        child: Divider(
                          height: 1.0,
                          color: BaseColors.lightSky,
                        ),
                      );
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: cachedNetworkImage(
                                image:
                                    orderedData[index].productData?.image ?? "",
                                width: double.infinity,
                                height: 230,
                                fit: BoxFit.fill,
                              ),
                            ),
                            buildSizeHeight(24),
                            BaseText(
                              value:
                                  orderedData[index].productData?.title ?? "",
                              color: BaseColors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                            buildSizeHeight(10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const BaseText(
                                  value: 'R',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: BaseColors.secondaryColor,
                                ),
                                BaseText(
                                  value:
                                      orderedData[index].productData?.price ??
                                          "",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            buildSizeHeight(8),
                            BaseText(
                              value:
                                  'Units : ${orderedData[index].unit ?? ""} | ${orderedData[index].productData?.quantity ?? ""}L',
                              fontSize: 14,
                              color: BaseColors.grey,
                            ),
                            buildSizeHeight(12),
                            HtmlWidget(
                              orderedData[index].productData?.description ?? "",
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: BaseColors.black),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  buildSizeHeight(18),
                ],
              ),
            ),
            SafeArea(
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: SvgPicture.asset(
                    BaseAssets.backArrow,
                    width: 19,
                    height: 20,
                    // colorFilter: const ColorFilter.mode(
                    // BaseColors.primaryColor,
                    // BlendMode.srcATop,
                    // ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
