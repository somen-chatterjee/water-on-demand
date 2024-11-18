import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:water_on_demand/backend/api_end_points.dart';
import 'package:water_on_demand/backend/base_api_service.dart';
import 'package:water_on_demand/ui/checkout/model/check_out_data_model.dart';
import 'package:water_on_demand/ui/checkout/model/month_model.dart';
import 'package:water_on_demand/ui/checkout/model/place_order_data_model.dart';
import 'package:water_on_demand/ui/checkout/model/week_model.dart';
import 'package:water_on_demand/ui/dashboard/controller/dashboard_controller.dart';
import 'package:water_on_demand/ui/web_view_stack/web_view_stack.dart';
import 'package:water_on_demand/utils/base_functions.dart';

class CheckOutController extends GetxController {
  DashboardController dashboardCtrl = Get.find<DashboardController>();

  final RxList<WeekModel> daysOfWeek = [
    WeekModel(week: "Monday"),
    WeekModel(week: "Tuesday"),
    WeekModel(week: "Wednesday"),
    WeekModel(week: "Thursday"),
    WeekModel(week: "Friday"),
    WeekModel(week: "Saturday"),
    WeekModel(week: "Sunday"),
  ].obs;

  RxBool isFloorCharge = false.obs;

  /// 511=Collect, 512=Delivery
  final ValueNotifier<int> deliveryTypeValue = ValueNotifier<int>(511);

  /// 501=Order Now, 502=Order for Future
  RxInt orderFor = (501).obs;

  /// 521=Daily, 522=Weekly, 523=Monthly
  RxInt dayType = (521).obs;

  Rx<SettingData> settingData = SettingData().obs;
  RxList<PaymentCardData>? paymentCardData = <PaymentCardData>[].obs;
  Rx<AmountData>? amountData = AmountData().obs;

  final RxList<MonthModel> monthsList = [
    MonthModel(month: "January"),
    MonthModel(month: "February"),
    MonthModel(month: "March"),
    MonthModel(month: "April"),
    MonthModel(month: "May"),
    MonthModel(month: "June"),
    MonthModel(month: "July"),
    MonthModel(month: "August"),
    MonthModel(month: "September"),
    MonthModel(month: "October"),
    MonthModel(month: "November"),
    MonthModel(month: "December")
  ].obs;

  GlobalKey<FormState> startEndDateFormKey = GlobalKey<FormState>();
  TextEditingController startDateCtrl = TextEditingController();
  TextEditingController endDateCtrl = TextEditingController();
  TextEditingController hourCtrl = TextEditingController();
  TextEditingController minCtrl = TextEditingController();

  RxDouble totalAmount = 0.0.obs;

  TimeOfDay? selectedTimeOfDay;

  RxString selectedTime = "".obs;

  RxBool amPmValue = (false).obs;

  RxList<String> selectedWeek = <String>[].obs;

  DateTime currentDate = DateTime.now();

  void checkFloor() {
    isFloorCharge.value = int.parse(
        dashboardCtrl.profileData?.addressData?.floorNumber.toString() ??
            "0") > 2;
  }

  DateTime getLastDate() {
    return DateTime(currentDate.year + 1, currentDate.month, 0);
  }

  List<String> getDayNamesBetweenDates() {
    removeAllWeeks();
    List<String> dayNames = [];
    DateFormat dateFormat = DateFormat('EEEE');

    DateTime startDate = changeToDateTime(dateString: startDateCtrl.text.trim());
    DateTime endDate = changeToDateTime(dateString: endDateCtrl.text.trim());

    for (DateTime date = startDate;
    date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
    date = date.add(const Duration(days: 1))) {
      var day = dateFormat.format(date);
      dayNames.add(dateFormat.format(date));

      for(WeekModel weekModel in daysOfWeek) {
        
        log("weekModel ${jsonEncode(weekModel)}");
        
        if(weekModel.week == day) {
          weekModel.isIgnoring = false;
        }
      }
      daysOfWeek.refresh();
    }

    log("sam message $dayNames");
    return dayNames;
  }

  void removeAllWeeks() {
    for (int i = 0; i < daysOfWeek.length; i++) {
      var object = daysOfWeek[i];
      if (!object.isIgnoring!) {
        object.isIgnoring = true;
      }
      object.isSelected = false;
      selectedWeek.clear();
      daysOfWeek.refresh();
    }
  }


  List<String> getCommaSeparatedMonthNames(
      DateTime startDate, DateTime endDate) {
    if (startDate.isAfter(endDate)) {
      return []; // Return an empty string if the start date is after the end date
    }

    List<String> monthNames = [];
    DateFormat monthFormat = DateFormat('MMMM'); // Format for full month name

    // Loop from the start date to the end date, month by month
    DateTime current = DateTime(startDate.year, startDate.month);
    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      monthNames.add(monthFormat.format(current));
      current = DateTime(current.year, current.month + 1);
    }

    // Join the month names with commas
    // var v = monthNames.join(', ');
    // dPrint("month name $v");
    return monthNames;
  }

  void removeAllMonths() {
    for (int i = 0; i < monthsList.length; i++) {
      var object = monthsList[i];
      if (object.isEnabled!) {
        object.isEnabled = false;
        object.isSelected = false;
        monthsList.refresh();
      }
    }
  }

  void checkMonths() {
    var startDate = startDateCtrl.text.trim();
    var endDate = endDateCtrl.text.trim();
    if (startEndDateFormKey.currentState?.validate() ?? false) {
      // check which month came on between on start and end date
      if (startDate != endDate) {
        List<String> monthList = getCommaSeparatedMonthNames(
          changeToDateTime(dateString: startDate),
          changeToDateTime(dateString: endDate),
        );

        for (int i = 0; i < monthsList.length; i++) {
          var object = monthsList[i];
          if (monthList.contains(object.month)) {
            object.isEnabled = true;
            monthsList.refresh();
          } else {
            object.isEnabled = false;
            monthsList.refresh();
            // dPrint("else xlnvnxfvnlxknf");
          }
        }
      } else {
        for (int i = 0; i < monthsList.length; i++) {
          var object = monthsList[i];
          if (object.isEnabled!) {
            object.isEnabled = false;
            monthsList.refresh();
          }
        }
      }
    }
  }

  void checkAndSelectDate({required BuildContext context, required int index}) {
    if (startEndDateFormKey.currentState?.validate() ?? false) {
      var startDate = changeToDateTime(dateString: startDateCtrl.text.trim());
      var endDate = changeToDateTime(dateString: endDateCtrl.text.trim());

      log("checkAndSelectDate $index");
      log("checkAndSelectDate ${startDate.month}");
      log("checkAndSelectDate $startDate");
      log("checkAndSelectDate ${DateTime(2023, startDate.month + 1, 0)}");

      if (monthsList[index].isEnabled!) {
        var setMinDate = checkMinDate(startDate, endDate, index + 1);

        // start date should be min date
        var setMaxDate = checkMaxDate(setMinDate, endDate, index + 1);

        log("setMinDate $setMinDate");
        log("setMaxDate $setMaxDate");

        if (monthsList[index].isEnabled! && monthsList[index].isSelected!) {
          showCalendar(
              context: context,
              minDate: setMinDate,
              maxDate: setMaxDate,
              initialSelectedDates: monthsList[index].selectedDate!);
        } else {
          showCalendar(
            context: context,
            minDate: setMinDate,
            maxDate: setMaxDate,
          );
        }
      }
    }
  }

  dynamic showCalendar(
      {required BuildContext context,
      required DateTime minDate,
      required DateTime maxDate,
      List<DateTime>? initialSelectedDates}) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              height: 400,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: SfDateRangePicker(
                backgroundColor: Colors.white,
                selectionMode: DateRangePickerSelectionMode.multiple,
                minDate: minDate,
                maxDate: maxDate,
                showActionButtons: true,
                viewSpacing: 10,
                initialSelectedDates: initialSelectedDates,
                onSubmit: (value) {
                  setDates(
                    dates: value,
                    initialSelectedDates: initialSelectedDates,
                  );
                  Navigator.pop(context);
                },
                onCancel: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
      },
      pageBuilder: (context, a1, a2) => const SizedBox(),
    );
  }

  DateTime checkMinDate(DateTime startDate, DateTime endDate, int clickMonth) {
    var currentDate = DateTime.now();
    log("startDate $startDate");
    log("startDate $endDate");
    log("startDate $clickMonth");

    if (clickMonth == startDate.month) {
      return startDate;
    }

    if (clickMonth > startDate.month) {
      return DateTime(startDate.year, clickMonth, 1);
    }

    if (clickMonth < startDate.month && currentDate.year != endDate.year) {
      return DateTime(currentDate.year + 1, clickMonth, 1);
    }

    return DateTime.now();
  }

  DateTime checkMaxDate(DateTime startDate, DateTime endDate, int clickMonth) {
    if (startDate.month == endDate.month) {
      return endDate;
    }

    return DateTime(startDate.year, clickMonth + 1, 0);
  }

  setDates({required dynamic dates, List<DateTime>? initialSelectedDates}) {
    log("date $dates");
    if (dates != null && dates.isNotEmpty) {
      int monthIndex = dates[0].month - 1;

      log("date $monthIndex");

      monthsList[monthIndex].isSelected = true;
      monthsList[monthIndex].selectedDate = dates;
      monthsList.refresh();
      // }
    } else {
      if (initialSelectedDates != null && initialSelectedDates.isNotEmpty) {
        int monthIndex = initialSelectedDates[0].month - 1;

        log("date $monthIndex");

        monthsList[monthIndex].isSelected = false;
        monthsList[monthIndex].selectedDate = [];
        monthsList.refresh();
      }
    }
  }

  List<String> getDates() {
    List<String> selectedDates = [];
    monthsList.map((element) {
      if (element.selectedDate?.isNotEmpty ?? false) {
        var datesList = element.selectedDate;
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        List<String> formattedStrings =
            datesList!.map((dateTime) => formatter.format(dateTime)).toList();
        selectedDates.add(formattedStrings.join(','));
        log("e.toString() $selectedDates");

        // var e = datesList?.map((e){
        //   log("e.toString() $e");
        //   formatDateTime(e);
        // }).join(',');
        //
        // log(e.toString());
      }
    }).toList();

    return selectedDates;
  }

  // purchase_type 601=Cart, 602=Buy Now
  getCheckoutData({required int purchaseType}) async {
    await BaseApiService()
        .get(apiEndPoint: "${ApiEndPoints().checkoutData}?purchase_type=$purchaseType", showLoader: true)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          CheckOutDataModel response = CheckOutDataModel.fromJson(value?.data);
          if (response.status ?? false) {
            if (response.data != null) {
              settingData.value = response.data?.settingData ?? SettingData();
              paymentCardData?.value = response.data!.paymentCardData ?? [];
              amountData?.value = response.data!.amountData ?? AmountData();
              settingData.refresh();
              paymentCardData?.refresh();
              amountData?.refresh();
            }
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      update();
    });
  }

  String calculateTotalPrice() {
    if (deliveryTypeValue.value == 511) {
      totalAmount.value =
          double.parse(amountData?.value.subTotalAmt.toString() ?? "0.0") +
              double.parse(amountData?.value.adminFee.toString() ?? "0.0");
    } else {
      totalAmount.value =
          double.parse(amountData?.value.subTotalAmt.toString() ?? "0.0") +
              double.parse(amountData?.value.adminFee.toString() ?? "0.0") +
              double.parse(isFloorCharge.value ? (amountData?.value.floorCharge.toString() ?? "0.0") : "0.0") +
              double.parse(amountData?.value.deliveryFee.toString() ?? "0.0");
    }
    return totalAmount.toString();
  }

  setTime(TimeOfDay time) {
    selectedTimeOfDay = time;
    selectedTime.value = formatTimeOfDay(time);
    if (time.hour <= 12) {
      hourCtrl.text = time.hour.toString().padLeft(2, '0');
    } else {
      hourCtrl.text = (time.hour % 12).toString().padLeft(2, '0');
    }

    amPmValue.value = time.hour >= 12;

    minCtrl.text = time.minute.toString().padLeft(2, '0');

    amPmValue.refresh();
  }

  bool checkMonthSelected() {
    bool isNotSelected = true;

    monthsList.map((element) {
      if (element.isSelected!) {
        isNotSelected = false;
      }

      if (element.isEnabled! && !element.isSelected!) {
        isNotSelected = true;
      }
    }).toList();

    return isNotSelected;
  }

  clearData() {
    startDateCtrl.clear();
    endDateCtrl.clear();
    selectedTime.value = "";
    amPmValue.value = false;
    selectedTimeOfDay = null;
    selectedWeek.clear();
    hourCtrl.clear();
    minCtrl.clear();
    removeAllWeeks();
    removeAllMonths();
  }

  placeOrder(int purchaseType) {
    Map<String, dynamic> mapData = {
      "purchase_type": purchaseType,
      "address_id": dashboardCtrl.profileData?.addressData?.addressId.toString() ?? "",
      "order_for": orderFor.value.toString(),
      "order_type": deliveryTypeValue.value.toString(),
      "days_type": orderFor.value == 502 ? dayType.value.toString() : "",
      "week_days": orderFor.value == 502 && dayType.value == 522
          ? selectedWeek.map((week) => week.toLowerCase().toString()).join(',')
          : "",
      "month_dates": orderFor.value == 502 && dayType.value == 523
          ? getDates().map((monthDate) => monthDate.toString()).join(',')
          : "",
      "start_date": orderFor.value == 502 ? startDateCtrl.text.trim() : "",
      "end_date": orderFor.value == 502 ? startDateCtrl.text.trim() : "",
      "delivery_time": selectedTime.value,
      "sub_total": amountData?.value.subTotalAmt.toString() ?? "0.0",
      "admin_fee": amountData?.value.adminFee.toString() ?? "0.0",
      "floor_charge": deliveryTypeValue.value == 512 && isFloorCharge.value
          ? amountData?.value.floorCharge.toString() ?? "0.0"
          : "0.00",
      "delivery_fee": deliveryTypeValue.value == 512
          ? amountData?.value.deliveryFee.toString() ?? "0.0"
          : "0.00",
      "total_amount": totalAmount.toString(),
    };

    log("sam mapData $mapData");

    BaseApiService()
        .post(
            apiEndPoint: ApiEndPoints().placeOrder,
            data: mapData,
            showLoader: true)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          PlaceOrderDataModel response = PlaceOrderDataModel.fromJson(value?.data);
          if (response.status ?? false) {
            if(response.data != null) {
              Get.to(()=>WebViewStack(
                url: response.data?.paymentUrl ?? "",
                orderId: response.data!.orderId.toString(),
                orderItemId: response.data!.orderItemId.toString(),
                purchaseType: purchaseType,
              ));

              // Get.offAll(const DashboardScreen(bodyIndex: 1));
              // Get.to(() => OrderSuccessScreen(orderId: response.data!.orderId.toString(),));
            }
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      update();
    });
  }
}
