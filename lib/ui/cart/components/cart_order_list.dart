import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/base_container.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import '../controller/card_contoller.dart';

class CartOrderList extends StatefulWidget {
   final int index;
   final VoidCallback onIncrement;
   final VoidCallback onDecrement;
  const CartOrderList({super.key,required this.index, required this.onIncrement, required this.onDecrement});

  @override
  State<CartOrderList> createState() => _CartOrderListState();
}

class _CartOrderListState extends State<CartOrderList> {
  CardController controller = Get.find<CardController>();

  @override
  Widget build(BuildContext context) {

    double price = double.parse(controller.cardData?[widget.index].productData?.price ?? "0.0");
    int unit = int.parse(controller.cardData?[widget.index].unit.toString() ?? "0");

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
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cachedNetworkImage(
              image: controller.cardData?[widget.index].productData?.image ??"",
              width: 92,
              height: 92,
              fit: BoxFit.cover,
            ),
            buildSizeWidth(12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   BaseText(
                    value: controller.cardData?[widget.index].productData?.title ??"",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSizeHeight(5.0),
                      const BaseText(
                        value: 'R',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: BaseColors.secondaryColor,
                      ),
                       BaseText(
                        value: (price * unit).toString(),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const Spacer(),
                  IntrinsicWidth(
                    child: BaseContainer(
                      bottomMargin: 0.0,
                      borderRadius: 0.0,
                      leftPadding: 4.5,
                      rightPadding: 4.5,
                      topPadding: 4.0,
                      bottomPadding: 4.0,
                      border: Border.all(
                        color: BaseColors.lightSky,
                        width: 1.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => widget.onDecrement(),
                            child: Container(
                              width: 28,
                              height: 22,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 9.0),
                              color: BaseColors.secondaryColor,
                              child: SvgPicture.asset(
                                BaseAssets.minus,
                              ),
                            ),
                          ),
                          buildSizeWidth(12.0),
                            Expanded(
                            child: BaseText(
                              textAlign: TextAlign.center,
                              value: controller.cardData?[widget.index].unit.toString() ??"",
                              fontSize: 10,
                            ),
                          ),
                          buildSizeWidth(12.0),
                          GestureDetector(
                            onTap: () => widget.onIncrement(),
                            child: Container(
                              width: 28,
                              height: 22,
                              padding: const EdgeInsets.all(6.0),
                              color: BaseColors.secondaryColor,
                              child: SvgPicture.asset(
                                BaseAssets.plus,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildSizeWidth(12.0),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 BaseText(
                  value:"${controller.cardData?[widget.index].productData?.quantity ??""}L",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: BaseColors.black,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 7.0, horizontal: 9.0,
                  ),
                  decoration: const BoxDecoration(
                    color: BaseColors.lightSky1,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // controller.removeItem( item:widget.index);
                      controller.removeToCardApi(controller.cardData?[widget.index].productData?.productId ??"");
                    },
                      child: SvgPicture.asset(BaseAssets.deleteIcon)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
