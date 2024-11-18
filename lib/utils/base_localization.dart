import 'package:get/get.dart';

class BaseLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'lorem':'Lorem Ipsum is simply dummy\ntext of the printing and typesetting\nindustry Lorem Ipsum.',
      // Welcome Screen
      'We Provide You Best Quality Water': 'We Provide You Best Quality Water',
      'Schedule When You Want Your Water Delivered': 'Schedule When You Want Your Water Delivered',
      'Fast And Responsibility Delivery': 'Fast And Responsibility Delivery',

      'Next': 'Next'
    },

    'ar_AR': {
      'lorem':'kljkahscjfajhscva',
    }
  };
}