const baseUrl = "http://54.84.67.39:8000/api/";
const customerBaseUrl = "http://54.84.67.39:8000/customer/";

// const baseUrl = "http://54.84.67.39:8040/api/";
// const customerBaseUrl = "http://54.84.67.39:8040/customer/"; //local


// const baseUrl = "http://54.84.67.39:8050/api/";
// const customerBaseUrl = "http://54.84.67.39:8050/customer/"; //local

const baseImageUrl = "https://doorap-s3-bucket.s3.amazonaws.com/";


const getOtpApi = baseUrl + "get_otp/";
const signupApi = baseUrl + "sign_up/";
const loginApi = baseUrl + "login/";
const cityListApi = baseUrl + "get_city/";
const countryListApi = baseUrl + "get_country/";
const forgotPasswordOtpApi = baseUrl + "forgor_password_otp/";
const forgotPasswordApi = baseUrl + "forgot_password/";
const changePasswordApi = baseUrl + "change_password/";



const vendorSaveProfileApi = baseUrl + "save_profile/";
const vendorViewProfileApi = baseUrl + "view_profile/";
const vendorEditProfileApi = baseUrl + "edit_profile/";

const vendorAddBankAccountApi = baseUrl + "add_bank_account/";
const vendorGetBankAccountApi = baseUrl + "show_account_detail/";
const vendorSetAvailabilityApi = baseUrl + "user_available/";

const vendorCategoriesApi = baseUrl + "view_category/";
const vendorServicesApi = baseUrl + "show_services/";
const vendorFacilityListApi = baseUrl + "facility_list/";
const vendorSetServicesApi = baseUrl + "vender_add_services/";
const showVendorServicesApi = baseUrl + "vender_show_services/";
const vendorUpdateServicesApi = baseUrl + "vender_edit_services/";
const vendorDeleteServicesApi = baseUrl + "delete_services/";
const vendorCustomServicesApi = baseUrl + "add_custom_service/";


const vendorGetScheduleApi = baseUrl + "show_set_schedule/";
const vendorSetUpdateScheduleApi = baseUrl + "set_schedule/";
const vendorSelectedFacilityListApi = baseUrl + "vendor_facility_list/";

const vendorOrderListApi = baseUrl + "show_order_to_vendor/";
const vendorAcceptDeclineOrderApi = baseUrl + "order_accept_decline/";
const vendorStartOrderApi = baseUrl + "order_start_job/";
const vendorCurrentOrderApi = baseUrl + "show_running_job/";
const vendorOrderDetailsApi = baseUrl + "show_vendor_order_detail/";




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


//


