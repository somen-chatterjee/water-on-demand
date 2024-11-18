import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../backend/api_end_points.dart';
import '../../../../backend/base_api_service.dart';
import '../../../../utils/base_functions.dart';
import '../model/order_payment_details_response.dart';

class PaymentDetailsController extends GetxController{
  RxBool isPaymentDetailsLoading = false.obs;
  Rx<PaymentData>? paymentDataDetails = PaymentData().obs;
  RxString? invoiceUrl = ''.obs;

  paymentDetailsApi(int orderId) {
    isPaymentDetailsLoading.value = true;
    Map<String, dynamic> data = {
     "order_item_id": orderId
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().paymentDetails, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          OrderPaymentDetailsResponse response = OrderPaymentDetailsResponse.fromJson(value?.data);
          if (response.status ?? false) {
            paymentDataDetails?.value = response.data?.paymentData??PaymentData();
            invoiceUrl?.value = response.data?.invoiceUrl.toString() ?? "";
          }else {
            showSnackBar(subtitle: response.message ?? "",isSuccess: true);
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      isPaymentDetailsLoading.value = false;
      update();
    });
  }

  Future<void> launchLink(String url) async {
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      showSnackBar(subtitle: "Something went wrong, please try again");
    }
  }
}