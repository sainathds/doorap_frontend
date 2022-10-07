const baseUrl = "https://doorap.com/";
const vendorBaseUrl = "https://doorap.com/api/";
const customerBaseUrl = "https://doorap.com/customer/";


// const baseUrl = "http://54.84.67.39:8040/api/";
// const customerBaseUrl = "http://54.84.67.39:8040/customer/"; //local


// const baseUrl = "http://54.84.67.39:8050/api/";
// const customerBaseUrl = "http://54.84.67.39:8050/customer/"; //local

const baseImageUrl = "https://doorap-s3-bucket.s3.amazonaws.com/";


// const getOtpApi = baseUrl + "get_otp/";
// const signupApi = baseUrl + "sign_up/";
// const loginApi = baseUrl + "login/";

const getOtpApi = vendorBaseUrl + "social_otp/";
const signupApi = vendorBaseUrl + "social_signup/";
const loginApi = vendorBaseUrl + "social_login/";

const cityListApi = vendorBaseUrl + "get_city/";
const countryListApi = vendorBaseUrl + "get_country/";
const forgotPasswordOtpApi = vendorBaseUrl + "forgor_password_otp/";
const forgotPasswordApi = vendorBaseUrl + "forgot_password/";
const changePasswordApi = vendorBaseUrl + "change_password/";



const vendorSaveProfileApi = vendorBaseUrl + "save_profile/";
const vendorViewProfileApi = vendorBaseUrl + "view_profile/";
const vendorEditProfileApi = vendorBaseUrl + "edit_profile/";

const vendorAddBankAccountApi = vendorBaseUrl + "add_bank_account/";
const vendorGetBankAccountApi = vendorBaseUrl + "show_account_detail/";
const vendorSetAvailabilityApi = vendorBaseUrl + "user_available/";

const vendorCategoriesApi = vendorBaseUrl + "view_category/";
const vendorServicesApi = vendorBaseUrl + "show_services/";
const vendorFacilityListApi = vendorBaseUrl + "facility_list/";
const vendorSetServicesApi = vendorBaseUrl + "vender_add_services/";
const showVendorServicesApi = vendorBaseUrl + "vender_show_services/";
const vendorUpdateServicesApi = vendorBaseUrl + "vender_edit_services/";
const vendorDeleteServicesApi = vendorBaseUrl + "delete_services/";
const vendorCustomServicesApi = vendorBaseUrl + "add_custom_service/";


const vendorGetScheduleApi = vendorBaseUrl + "show_set_schedule/";
const vendorSetUpdateScheduleApi = vendorBaseUrl + "set_schedule/";
const vendorSelectedFacilityListApi = vendorBaseUrl + "vendor_facility_list/";

const vendorOrderListApi = vendorBaseUrl + "show_order_to_vendor/";
const vendorAcceptDeclineOrderApi = vendorBaseUrl + "order_accept_decline/";
const vendorStartOrderApi = vendorBaseUrl + "order_start_job/";
const vendorCurrentOrderApi = vendorBaseUrl + "show_running_job/";
const vendorOrderDetailsApi = vendorBaseUrl + "show_vendor_order_detail/";

const vendorBalancePaymentApi = vendorBaseUrl + "show_vendor_totalearning/";
const vendorWithdrawPaymentApi = vendorBaseUrl + "withdraw_request/";
const vendorReceivedPaymentApi = vendorBaseUrl + "show_received_payment/";


///*
///
/// customer api's
const customerBannerApi = customerBaseUrl + "banner_show/";
const customerShowAllServicesApi = customerBaseUrl + "show_all_services/";
const customerVendorProfileApi = customerBaseUrl + "show_vendor_profile/";
const customerVendorsByLocationApi = customerBaseUrl + "show_location_wise_vendor/";
const customerVendorServicesApi = customerBaseUrl + "show_services_list_by_vendor/";
const customerServiceInfoApi = customerBaseUrl + "show_vendor_facility/";
const customerAddToCartApi = customerBaseUrl + "item_add_to_cart/";
const customerGetCartItemApi = customerBaseUrl + "get_cart_data/";
const customerRemoveCartItemApi = customerBaseUrl + "delete_item_to_cart/";
const customerUpdateCartItemApi = customerBaseUrl + "update_item_quantity/";
const customerPromocodeApi = customerBaseUrl + "apply_promocode/";
const customerLikeDislikeApi = customerBaseUrl + "like_dislike/";
const customerNextSixDaysApi = customerBaseUrl + "next_six_days/";  // no usage
const customerSlotDetailsApi = customerBaseUrl + "slot_details/";   // no usage
const customerSlotAvailabilityApi = customerBaseUrl + "slot_availability/";
const customerCartCountApi = customerBaseUrl + "cart_quantity/";
const customerFavouriteVendorsApi = customerBaseUrl + "show_like_vendor/";
const customerOrderDetailsApi = customerBaseUrl + "show_customer_order_detail/";
const customerBookOrderApi = customerBaseUrl + "save_order_details/";
const customerCurrentOrderApi = customerBaseUrl + "show_current_order/";
const customerCancelOrderApi = customerBaseUrl + "customer_cancel_order/";
const customerCompletedOrderApi = customerBaseUrl + "order_completed/";
const customerMyOrderApi = customerBaseUrl + "show_all_order/";
const customerFeedbackApi = customerBaseUrl + "rating_feedback/";
const customerCreatePaymentIntentApi = customerBaseUrl + 'stripe_payment/';


const logoutApi = customerBaseUrl + "logout_api/";  //use for both vendor and customer
const notificationListApi = customerBaseUrl + "show_notification/";  //use for both vendor and customer
const seenNotificationApi = customerBaseUrl + "notification_seen/";  //use for both vendor and customer
const clearNotificationApi = customerBaseUrl + "delete_notification/";  //use for both vendor and customer
const notificationCountApi = customerBaseUrl + "notification_count/";  //use for both vendor and customer


//


