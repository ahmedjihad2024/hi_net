// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';

enum Translation {
  // static
  search_country,

  // Loading States
  loading,
  no_more,
  failed_loading,
  load_more,
  retry_button,

  // Error Messages
  error_invalid_number,
  error_invalid_email,
  error_server,
  error_no_internet,
  error_generic,
  user_not_confirmed,
  unauthorized,
  email_taken,
  incorrect_password_or_email,

  // Onboarding
  stay_connected_anywhere,
  global_coverage_local_rates,
  activate_in_seconds,
  buy_activate_esim,
  access_data_worldwide,
  instant_setup_secure_payment,
  next,
  join_now,

  // Auth
  welcome_aboard,
  create_account_subtitle,
  full_name,
  phone_number,
  helper_text_example,
  terms_agreement_part_one,
  terms_agreement_part_two,
  terms_agreement_part_three,
  terms_agreement_part_four,
  welcome_back,
  sign_in_message,
  suggested,
  no_account_sign_up,
  sign_in,
  sign_up,
  verify_your_number,
  verify_your_number_message, verfy,
}

extension Tra on Translation {
  String get tr => name.tr();
  String trNamed(Map<String, String> params) => name.tr(namedArgs: params);
}
