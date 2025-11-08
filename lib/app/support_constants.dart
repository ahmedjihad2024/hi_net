import 'dart:ui';

class FaqItem {
  final String titleAr;
  final String titleEn;
  final String answerAr;
  final String answerEn;
  FaqItem(
      {required this.titleAr,
      required this.titleEn,
      required this.answerAr,
      required this.answerEn});

  String title(Locale locale) => {
        'ar': titleAr,
        'en': titleEn,
      }[locale.languageCode]!;

  String answer(Locale locale) => {
        'ar': answerAr,
        'en': answerEn,
      }[locale.languageCode]!;
}

class SupportConstants {
  // remove the plus from the number okey!
  // +201095651645 => 201095651645
  static const String whatsApp = '201095651645';
  static const String email = 'mood27358@gmail.com';
  static const String facebook = 'https://www.facebook.com/retmedu';
  static const String instagram = 'https://www.instagram.com/retmedu';
  static const String twitter = 'https://twitter.com/retmedu';

  // NOTE: this is the path of about retm image
  // assets\images\about-retm-image.jpg
  // so you can replace it with any image you want
  // with the same name

  static String aboutRetmText(Locale locale) {
    return {
      'ar': """
رتـــــــم هي منصة الكترونية توفر دورات في مختلف المجالات عبر واجهة سهلة  الاستخدام، مما يسهل ويعزز عملية التعلم الذاتي من خلال الوصول إلى محتوى  تعليمي متنوع.
""",
      'en': """
RETM is an electronic platform that provides courses in various fields through an easy-to-use interface, which facilitates and enhances the process of self-learning by providing access to diverse educational content.
""",
    }[locale.languageCode]!;
  }

  static List<FaqItem> faq = [
    FaqItem(
      answerAr:
          "رتم هي منصة الكترونية توفر دورات في مختلف المجالات عبر واجهة سهلة الاستخدام، مما يسهل ويعزز عملية التعلم الذاتي من خلال الوصول إلى محتوى تعليمي متنوع.",
      answerEn:
          "RETM is an electronic platform that provides courses in various fields through an easy-to-use interface, which facilitates and enhances the process of self-learning by providing access to diverse educational content.",
      titleAr: "ما هي منصة رتم؟",
      titleEn: "What is the RETM platform?",
    )
  ];
}
