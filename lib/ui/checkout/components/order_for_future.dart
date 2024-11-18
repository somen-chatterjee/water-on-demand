import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_container.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/base_components/base_textfield.dart';
import 'package:water_on_demand/ui/base_components/listview_builder_animation.dart';
import 'package:water_on_demand/ui/checkout/controller/checkout_controller.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';

class OrderForFuture extends StatefulWidget {
  const OrderForFuture({super.key});

  @override
  State<OrderForFuture> createState() => _OrderForFutureState();
}

class _OrderForFutureState extends State<OrderForFuture> {
  CheckOutController checkOutCtrl = Get.find<CheckOutController>();

  @override
  Widget build(BuildContext context) {
    return AnimatedColumn(
      leftPadding: 0.0,
      rightPadding: 0.0,
      topPadding: 0.0,
      bottomPadding: 0.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //daily , weekly , monthly in one row
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  selectIndex(521);
                },
                child: BaseContainer(
                  bottomMargin: 0.0,
                  borderRadius: 0.0,
                  leftPadding: 0.0,
                  rightPadding: 0.0,
                  topPadding: 0.0,
                  bottomPadding: 0.0,
                  height: 46,
                  boxShadow: const BoxShadow(
                    color: BaseColors.lightSky,
                    spreadRadius: 1.0,
                    blurRadius: 2.0,
                  ),
                  border: Border.all(
                    color: checkOutCtrl.dayType.value == 521
                        ? BaseColors.secondaryColor
                        : BaseColors.lightSky,
                    width: 1.0,
                  ),
                  child: Center(
                    child: BaseText(
                      textAlign: TextAlign.center,
                      value: 'Daily',
                      color: checkOutCtrl.dayType.value == 521
                          ? BaseColors.secondaryColor
                          : BaseColors.grey,
                    ),
                  ),
                ),
              ),
            ),
            buildSizeWidth(20),
            Expanded(
              child: InkWell(
                onTap: () {
                  selectIndex(522);
                },
                child: BaseContainer(
                  bottomMargin: 0.0,
                  borderRadius: 0.0,
                  leftPadding: 0.0,
                  rightPadding: 0.0,
                  topPadding: 0.0,
                  bottomPadding: 0.0,
                  height: 46,
                  boxShadow: const BoxShadow(
                    color: BaseColors.lightSky,
                    spreadRadius: 1.0,
                    blurRadius: 2.0,
                  ),
                  border: Border.all(
                    color: checkOutCtrl.dayType.value == 522
                        ? BaseColors.secondaryColor
                        : BaseColors.lightSky,
                    width: 1.0,
                  ),
                  child: Center(
                    child: BaseText(
                      textAlign: TextAlign.center,
                      value: 'Weekly',
                      color: checkOutCtrl.dayType.value == 522
                          ? BaseColors.secondaryColor
                          : BaseColors.grey,
                    ),
                  ),
                ),
              ),
            ),
            buildSizeWidth(20),
            Expanded(
              child: InkWell(
                onTap: () {
                  selectIndex(523);
                },
                child: BaseContainer(
                  bottomMargin: 0.0,
                  borderRadius: 0.0,
                  leftPadding: 0.0,
                  rightPadding: 0.0,
                  topPadding: 0.0,
                  bottomPadding: 0.0,
                  height: 46,
                  boxShadow: const BoxShadow(
                    color: BaseColors.lightSky,
                    spreadRadius: 1.0,
                    blurRadius: 2.0,
                  ),
                  border: Border.all(
                    color: checkOutCtrl.dayType.value == 523
                        ? BaseColors.secondaryColor
                        : BaseColors.lightSky,
                    width: 1.0,
                  ),
                  child: Center(
                    child: BaseText(
                      textAlign: TextAlign.center,
                      value: 'Monthly',
                      color: checkOutCtrl.dayType.value == 523
                          ? BaseColors.secondaryColor
                          : BaseColors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        buildSizeHeight(16.0),
        // start date , end date
        Form(
          key: checkOutCtrl.startEndDateFormKey,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseText(
                      value: 'Start Date',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    buildSizeHeight(15.0),
                    BaseTextField(
                      controller: checkOutCtrl.startDateCtrl,
                      labelText: '',
                      hintText: 'DD-MM-YYY',
                      readOnly: true,
                      hintTextColor: BaseColors.grey,
                      borderColor: BaseColors.lightSky,
                      contentPadding: const EdgeInsets.all(12.0),
                      validator: (val) {
                        if (checkOutCtrl.startDateCtrl.value.text
                            .trim()
                            .isEmpty) {
                          return "Please select start date";
                        }
                        return null;
                      },
                      onTap: () {
                        showBaseDatePicker(
                          context,
                          firstDate: checkOutCtrl.currentDate,
                          lastDate: checkOutCtrl.getLastDate(),
                        ).then((val) {
                          if (val.isNotEmpty) {
                            checkOutCtrl.startDateCtrl.text = val;
                            checkOutCtrl.endDateCtrl.clear();
                            if (checkOutCtrl.dayType.value == 522) {
                              checkOutCtrl.removeAllWeeks();
                            }
                            if (checkOutCtrl.dayType.value == 523) {
                              checkOutCtrl.removeAllMonths();
                            }
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              buildSizeWidth(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseText(
                      value: 'End Date',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    buildSizeHeight(15.0),
                    BaseTextField(
                      controller: checkOutCtrl.endDateCtrl,
                      labelText: '',
                      hintText: 'DD-MM-YYY',
                      readOnly: true,
                      hintTextColor: BaseColors.grey,
                      borderColor: BaseColors.lightSky,
                      contentPadding: const EdgeInsets.all(12.0),
                      validator: (val) {
                        if (checkOutCtrl.endDateCtrl.value.text
                            .trim()
                            .isEmpty) {
                          return "Please select end date";
                        }
                        return null;
                      },
                      onTap: () {
                        if (checkOutCtrl.startDateCtrl.text.isNotEmpty) {
                          showBaseDatePicker(
                            context,
                            firstDate: changeToDateTime(
                                dateString: checkOutCtrl.startDateCtrl.text)
                                .add(const Duration(days: 1)),
                            lastDate: checkOutCtrl.getLastDate(),
                          ).then((val) {
                            if (val.isNotEmpty) {
                              checkOutCtrl.endDateCtrl.text = val;
                              if (checkOutCtrl.dayType.value == 522) {
                                checkOutCtrl.getDayNamesBetweenDates();
                              }
                              if (checkOutCtrl.dayType.value == 523) {
                                checkOutCtrl.checkMonths();
                              }
                            }
                          });
                        } else {
                          showSnackBar(
                              subtitle: "Please select start date first");
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: checkOutCtrl.dayType.value != 521,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSizeHeight(16.0),
              BaseText(
                value: checkOutCtrl.dayType.value == 522
                    ? 'Select Day\'s'
                    : 'Select Month',
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              buildSizeHeight(15.0),
              selectBody(index: checkOutCtrl.dayType.value),
            ],
          ),
        ),
        buildSizeHeight(29.0),
        const BaseText(
          value: 'Time',
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        buildSizeHeight(15.0),
        Obx(() {
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              showBaseTimePicker(
                  context: context,
                  initialTime: checkOutCtrl.selectedTimeOfDay)
                  .then((value) {
                if (value != null) {
                  dPrint("s ${value.toString()}");
                  checkOutCtrl.setTime(value);
                }
              });
            },
            child: Row(
              children: [
                Expanded(
                  child: IgnorePointer(
                    child: BaseTextField(
                      controller: checkOutCtrl.hourCtrl,
                      labelText: '',
                      hintText: '00',
                      hintTextColor: BaseColors.grey,
                      borderColor: BaseColors.lightSky,
                      textInputType: TextInputType.number,
                      borderRadius: 0.0,
                      maxLength: 2,
                      readOnly: true,
                      contentPadding: const EdgeInsets.all(12.0),
                      suffixIcon: const BaseText(
                        rightMargin: 10.0,
                        value: 'hr',
                        fontWeight: FontWeight.w400,
                        color: BaseColors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const BaseText(
                  leftMargin: 10.0,
                  rightMargin: 10.0,
                  value: ':',
                  fontWeight: FontWeight.w400,
                  color: BaseColors.grey,
                  fontSize: 14,
                ),
                Expanded(
                  child: IgnorePointer(
                    child: BaseTextField(
                      controller: checkOutCtrl.minCtrl,
                      labelText: '',
                      hintText: '00',
                      hintTextColor: BaseColors.grey,
                      borderColor: BaseColors.lightSky,
                      textInputType: TextInputType.number,
                      borderRadius: 0.0,
                      maxLength: 2,
                      readOnly: true,
                      contentPadding: const EdgeInsets.all(12.0),
                      suffixIcon: const BaseText(
                        rightMargin: 10.0,
                        value: 'min',
                        fontWeight: FontWeight.w400,
                        color: BaseColors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const BaseText(
                      leftMargin: 10.0,
                      rightMargin: 10.0,
                      value: 'AM',
                      fontWeight: FontWeight.w600,
                      color: BaseColors.black,
                      fontSize: 9,
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: IgnorePointer(
                        child: Switch(
                          activeColor: BaseColors.white,
                          inactiveTrackColor: BaseColors.white,
                          thumbColor: const WidgetStatePropertyAll(
                              BaseColors.secondaryColor),
                          trackOutlineColor:
                          const WidgetStatePropertyAll(BaseColors.lightSky),
                          value: checkOutCtrl.amPmValue.value,
                          onChanged: (value) {
                            checkOutCtrl.amPmValue.value = value;
                          },
                        ),
                      ),
                    ),
                    const BaseText(
                      leftMargin: 10.0,
                      rightMargin: 10.0,
                      value: 'PM',
                      fontWeight: FontWeight.w600,
                      color: BaseColors.black,
                      fontSize: 9,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  void selectIndex(int index) {
    if (index != checkOutCtrl.dayType.value) {
      setState(() {
        checkOutCtrl.dayType.value = index;
        checkOutCtrl.clearData();
      });
    }
  }

  Widget selectBody({required int index}) {
    // if (index == 521) {
    //   return GridView.builder(
    //     primary: false,
    //     itemCount: daysOfWeek.length,
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       // crossAxisSpacing: 2.0,
    //       childAspectRatio: 3.9,
    //       // mainAxisSpacing: 2.0,
    //     ),
    //     shrinkWrap: true,
    //     physics: const NeverScrollableScrollPhysics(),
    //     itemBuilder: (BuildContext context, int index) {
    //       return ListviewBuilderAnimation(
    //         index: index,
    //         child: SelectCheckBox(
    //           title: daysOfWeek[index],
    //           selected: true,
    //         ),
    //       );
    //     },
    //   );
    // }
    if (index == 522) {
      return Obx(() {
        log("SelectCheckBox");
        return GridView.builder(
          primary: false,
          itemCount: checkOutCtrl.daysOfWeek.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // crossAxisSpacing: 2.0,
            childAspectRatio: 3.9,
            // mainAxisSpacing: 2.0,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return ListviewBuilderAnimation(
              index: index,
              child: SelectCheckBox(
                title: checkOutCtrl.daysOfWeek[index].week!,
                ignoring: checkOutCtrl.daysOfWeek[index].isIgnoring!,
                selected: checkOutCtrl.daysOfWeek[index].isSelected!,
              ),
            );
          },
        );
      });
    }
    if (index == 523) {
      return Obx(() {
        return GridView.builder(
          primary: false,
          itemCount: checkOutCtrl.monthsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // crossAxisSpacing: 2.0,
            childAspectRatio: 3.9,
            // mainAxisSpacing: 2.0,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return SelectMonthCheckBox(
              title: checkOutCtrl.monthsList[index].month!,
              enabled: checkOutCtrl.monthsList[index].isEnabled!,
              selected: checkOutCtrl.monthsList[index].isSelected!,
              onTap: () =>
                  checkOutCtrl.checkAndSelectDate(
                    context: context,
                    index: index,
                  ),
            );
          },
        );
      });
    }

    return const SizedBox();
  }
}

class SelectCheckBox extends StatefulWidget {
  final String title;
  final bool selected;
  final bool ignoring;

  const SelectCheckBox(
      {super.key, required this.title, required this.ignoring, required this.selected,});

  @override
  State<SelectCheckBox> createState() => _SelectCheckBoxState();
}

class _SelectCheckBoxState extends State<SelectCheckBox> {
  CheckOutController checkOutCtrl = Get.find<CheckOutController>();

  ValueNotifier<bool> isChecked = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    isChecked.value = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    isChecked.value = widget.selected;
    return IgnorePointer(
      ignoring: widget.ignoring,
      child: Row(
        children: [
          ValueListenableBuilder(
            builder: (context, value, _) {
              return Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  side: WidgetStateBorderSide.resolveWith((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return const BorderSide(color: BaseColors.black);
                    } else {
                      return BorderSide(color: widget.ignoring ? BaseColors
                          .lightGrey : BaseColors.lightSky);
                    }
                  }),
                  activeColor: BaseColors.lightSky,
                  checkColor: BaseColors.secondaryColor,
                  focusColor: BaseColors.lightSky,
                  fillColor: const WidgetStatePropertyAll(
                    Colors.white,
                  ),
                  visualDensity: const VisualDensity(horizontal: -4),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  isError: true,
                  tristate: true,
                  value: isChecked.value,
                  onChanged: (value) {
                    isChecked.value = !isChecked.value;
                    if (isChecked.value) {
                      checkOutCtrl.selectedWeek.add(widget.title);
                    } else {
                      checkOutCtrl.selectedWeek.remove(widget.title);
                    }
                  },
                ),
              );
            },
            valueListenable: isChecked,
          ),
          BaseText(value: widget.title,
            color: widget.ignoring ? BaseColors.grey2 : BaseColors.black,),
        ],
      ),
    );
  }
}

class SelectMonthCheckBox extends StatelessWidget {
  final String title;
  final bool enabled;
  final bool selected;
  final VoidCallback onTap;

  const SelectMonthCheckBox({super.key,
    required this.title,
    required this.enabled,
    required this.onTap,
    required this.selected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 21.0,
            height: 21.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: BaseColors.white,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: enabled ? BaseColors.lightSky : BaseColors.lightGrey,
                width: 1.2,
              ),
            ),
            child: selected
                ? const Icon(
              Icons.check,
              color: BaseColors.secondaryColor,
              size: 18.0,
            )
                : null,
          ),
          buildSizeWidth(10.0),
          BaseText(
            value: title,
            color: enabled ? BaseColors.black : BaseColors.grey2,
          ),
        ],
      ),
    );
  }
}
