class ApiEndPoints {
  /// Debug Server: https://www.waterondemand.co.za/api/

  final String baseUrl = 'https://www.waterondemand.co.za/api/';

  /// OnBoarding EndPoints
  final String createAccount = "create_account";
  final String loginAccount = "login_account";
  final String loginOtp = "mobile_login_account";
  final String validateAccount = "validate_account";
  final String resendOtp = "resend_otp";
  final String socialLoginAccount = "social_login_account";
  final String profile = "profile/";
  final String productList = "product_list";
  final String homeData = "home_data";
  final String productDetails = "get_product_details";
  final String addAddress = "save_address_details";
  final String addIdentityProof = "save_driver_details";
  final String addBankDetail = "save_bank_details";
  final String vehicleInfo = "save_vehicle_details";
  final String addToCard = "add_to_cart";
  final String removeToCard = "remove_from_cart";
  final String getCardData = "cart_data";
  final String notificationList = "user/notification_list";
  final String notificationDelete = "user/notification_delete";
  final String getVehicleList = "get_vehicle_list";
  final String userOrderHistory = "user_order_history";
  final String cancelOrder = "cancel_order";
  final String getOrderDetails = "get_order_details";
  final String checkoutData = "checkout_data";
  final String placeOrder = "place_order";
  final String trackOrder = "track_order";
  final String userAddressList = "user_addresses_list";
  final String saveDefaultAddress = "save_default_address";
  final String addNewAddress = "add_new_address";
  /// Driver Api
  final String driverJobList = "driver_jobs_list";
  final String acceptOrder = "accept_order";
  final String rejectOrder = "reject_order";
  final String driverOrderDetails = "driver_order_details";
  final String pickupOrder = "pickup_order";
  final String dropOffOrder = "drop_off_odr";
  final String verifyDeliveryOtp = "verify_delivery";
  final String driverHomeData = "driver_home_data";
  final String saveOnlineStatus = "save_online_status";
  final String paymentDetails = "payment_details";
}
