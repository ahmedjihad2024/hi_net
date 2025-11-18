// extension DeviceType on DEVICE_SIZE_TYPE {
//   bool get isDesktop => this == DEVICE_SIZE_TYPE.DESKTOP;
//   bool get isMobile => this == DEVICE_SIZE_TYPE.MOBILE;
//   bool get isTablet => this == DEVICE_SIZE_TYPE.TABLET;
// }

enum EsimsType{
  countrie,
  regional,
  global;

  bool get isGlobal => this == EsimsType.global;
  bool get isRegional => this == EsimsType.regional;
  bool get isCountries => this == EsimsType.countrie;
}

enum PaymentMethod {
  visa,
  mastercard,
  applePay;

  bool get isVisa => this == PaymentMethod.visa;
  bool get isMastercard => this == PaymentMethod.mastercard;
  bool get isApplePay => this == PaymentMethod.applePay;
}

enum VerifyType {
  signIn,
  signUp;

  bool get isSignIn => this == VerifyType.signIn;
  bool get isSignUp => this == VerifyType.signUp;
}