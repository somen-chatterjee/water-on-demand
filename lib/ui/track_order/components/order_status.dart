import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';

class OrderStatus extends StatelessWidget {
  final int statusIndex;
  const OrderStatus({super.key, required this.statusIndex});

  //fill track
  Widget fillTrack(){
    return Container(
      height: 92,
      width: 11,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(top: 8),
      decoration: const BoxDecoration(
        color: BaseColors.secondaryColor,
      ),
    );
  }

  //Dash track
  Widget dashTrack(){
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 5.0,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(9, (index) => Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
            index % 2 == 0 ? BaseColors.lightSky : Colors.transparent,
          ),
        ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedColumn(
      leftPadding: 0.0,
      rightPadding: 0.0,
      children: [
        // order made
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              BaseAssets.orderImage,
              width: 21.0,
            ),
            buildSizeWidth(10),
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                statusIndex > 1
                ? fillTrack():dashTrack(),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: BaseColors.secondaryColor,
                    border: Border.all(width: 1.5, color: Colors.white),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ],
            ),
            buildSizeWidth(10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  value: 'Order Made',
                  color: BaseColors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  value: 'Your order has been confirmed',
                  color: BaseColors.black,
                  fontSize: 15,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
        // package & labelled
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              BaseAssets.packagedImage,
              width: 21.0,
            ),
            buildSizeWidth(10),
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                statusIndex > 2
                    ? fillTrack():dashTrack(),
                if(statusIndex >= 2)
                Container(
                  height: 10,
                  width: 11,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: BaseColors.secondaryColor,
                  ),
                ),
                statusIndex >= 2 ? Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: BaseColors.secondaryColor,
                    border: Border.all(width: 1.5, color: Colors.white),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12,
                  ),
                ): Container(
                  margin: const EdgeInsets.only(left: 5,top: 5),
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: BaseColors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            buildSizeWidth(10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  value: 'Packaged & Labelled',
                  color: BaseColors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  value:
                      'Your good have been packaged\nand sent to the delivery station',
                  color: BaseColors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
        // toronto center
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              BaseAssets.torontoImage,
              width: 21.0,
            ),
            buildSizeWidth(10),
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                statusIndex > 3
                    ? fillTrack() : dashTrack(),

                if(statusIndex >= 3)
                  Container(
                    height: 10,
                    width: 11,
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: BaseColors.secondaryColor,
                    ),
                  ),
                statusIndex >= 3 ? Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: BaseColors.secondaryColor,
                    border: Border.all(width: 1.5, color: Colors.white),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12,
                  ),
                ): Container(
                  margin: const EdgeInsets.only(left: 5,top: 5),
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: BaseColors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            buildSizeWidth(10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  value: 'Toronto Eaton Centre',
                  color: BaseColors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  value: '2 stops (20 min)',
                  color: BaseColors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
        //my location
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              BaseAssets.myLocation,
              // height: 25,
              width: 21.0,
            ),
            buildSizeWidth(10),
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                if(statusIndex == 4)
                  Container(
                    height: 10,
                    width: 11,
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: BaseColors.secondaryColor,
                    ),
                  ),
                statusIndex == 4
                    ? Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: BaseColors.secondaryColor,
                    border: Border.all(width: 1.5, color: Colors.white),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12,
                  ),
                )
                : Container(
                  margin: const EdgeInsets.only(left: 5,top: 5),
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: BaseColors.grey,
                    shape: BoxShape.circle,
                  ),
                ),

              ],
            ),
            buildSizeWidth(10),
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                    value: 'My Location',
                    color: BaseColors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  BaseText(
                    value: 'Destination',
                    color: BaseColors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
