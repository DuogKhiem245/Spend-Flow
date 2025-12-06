import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @app_name.
  ///
  /// In vi, this message translates to:
  /// **'SpendFlow'**
  String get app_name;

  /// No description provided for @ok.
  ///
  /// In vi, this message translates to:
  /// **'Đồng ý'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get cancel;

  /// No description provided for @skip.
  ///
  /// In vi, this message translates to:
  /// **'Bỏ qua'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp theo'**
  String get next;

  /// No description provided for @confirm.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận'**
  String get confirm;

  /// No description provided for @save.
  ///
  /// In vi, this message translates to:
  /// **'Lưu'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In vi, this message translates to:
  /// **'Sửa'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get delete;

  /// No description provided for @yes.
  ///
  /// In vi, this message translates to:
  /// **'Có'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In vi, this message translates to:
  /// **'Không'**
  String get no;

  /// No description provided for @done.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn tất'**
  String get done;

  /// No description provided for @back.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại'**
  String get back;

  /// No description provided for @start.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu'**
  String get start;

  /// No description provided for @continueAction.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục'**
  String get continueAction;

  /// No description provided for @view_all.
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả'**
  String get view_all;

  /// No description provided for @see_all.
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả'**
  String get see_all;

  /// No description provided for @onboard_step1_title.
  ///
  /// In vi, this message translates to:
  /// **'Đơn giản hóa tài chính'**
  String get onboard_step1_title;

  /// No description provided for @onboard_step1_message.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả tài khoản của bạn trong một nơi. Xem tiền của bạn đi đâu và đạt mục tiêu tài chính dễ dàng.'**
  String get onboard_step1_message;

  /// No description provided for @onboard_step2_title.
  ///
  /// In vi, this message translates to:
  /// **'Kiểm soát chi tiêu của bạn'**
  String get onboard_step2_title;

  /// No description provided for @onboard_step2_message.
  ///
  /// In vi, this message translates to:
  /// **'Đặt hạn mức chi tiêu, theo dõi các danh mục và luôn nắm vững mục tiêu tài chính bằng cách tạo ngân sách cá nhân.'**
  String get onboard_step2_message;

  /// No description provided for @onboard_step3_title.
  ///
  /// In vi, this message translates to:
  /// **'Xem khoản tiết kiệm tăng trưởng'**
  String get onboard_step3_title;

  /// No description provided for @onboard_step3_message.
  ///
  /// In vi, this message translates to:
  /// **'Thiết lập mục tiêu tiết kiệm tự động, làm tròn các giao dịch và khám phá cách thông minh để tiết kiệm tiền dễ dàng.'**
  String get onboard_step3_message;

  /// No description provided for @login.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get login;

  /// No description provided for @register.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký'**
  String get register;

  /// No description provided for @logout.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất'**
  String get logout;

  /// No description provided for @email.
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get password;

  /// No description provided for @new_password.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu mới'**
  String get new_password;

  /// No description provided for @enter_email.
  ///
  /// In vi, this message translates to:
  /// **'Nhập email của bạn'**
  String get enter_email;

  /// No description provided for @enter_your_password.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu của bạn'**
  String get enter_your_password;

  /// No description provided for @confirm_password.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu'**
  String get confirm_password;

  /// No description provided for @confirm_your_password.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu'**
  String get confirm_your_password;

  /// No description provided for @passwords_match.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu trùng khớp.'**
  String get passwords_match;

  /// No description provided for @passwords_mismatch.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu không trùng khớp.'**
  String get passwords_mismatch;

  /// No description provided for @forgot_password.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu?'**
  String get forgot_password;

  /// No description provided for @description_forgot_password.
  ///
  /// In vi, this message translates to:
  /// **'Nhập email được liên kết với tài khoản của bạn để đặt lại mật khẩu.'**
  String get description_forgot_password;

  /// No description provided for @send_otp.
  ///
  /// In vi, this message translates to:
  /// **'Gửi OTP'**
  String get send_otp;

  /// No description provided for @enter_otp.
  ///
  /// In vi, this message translates to:
  /// **'Nhập OTP'**
  String get enter_otp;

  /// No description provided for @resend.
  ///
  /// In vi, this message translates to:
  /// **'Gửi lại'**
  String get resend;

  /// No description provided for @verify.
  ///
  /// In vi, this message translates to:
  /// **'Xác thực'**
  String get verify;

  /// No description provided for @no_otp.
  ///
  /// In vi, this message translates to:
  /// **'Không nhận được mã?'**
  String get no_otp;

  /// No description provided for @no_account.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có tài khoản?'**
  String get no_account;

  /// No description provided for @have_account.
  ///
  /// In vi, this message translates to:
  /// **'Đã có tài khoản?'**
  String get have_account;

  /// No description provided for @login_error.
  ///
  /// In vi, this message translates to:
  /// **'Email hoặc mật khẩu không hợp lệ'**
  String get login_error;

  /// No description provided for @register_error.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký thất bại'**
  String get register_error;

  /// No description provided for @create_account.
  ///
  /// In vi, this message translates to:
  /// **'Đăng kí tài khoản'**
  String get create_account;

  /// No description provided for @create_password.
  ///
  /// In vi, this message translates to:
  /// **'Tạo mật khẩu mới'**
  String get create_password;

  /// No description provided for @create_new_password.
  ///
  /// In vi, this message translates to:
  /// **'Gần xong rồi! Tạo mật khẩu mới của bạn.'**
  String get create_new_password;

  /// No description provided for @welcome_back.
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng trở lại'**
  String get welcome_back;

  /// No description provided for @back_login.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại đăng nhập'**
  String get back_login;

  /// No description provided for @description_create_account.
  ///
  /// In vi, this message translates to:
  /// **'Kiểm soát tài chính của bạn ngay hôm nay'**
  String get description_create_account;

  /// No description provided for @label_weak.
  ///
  /// In vi, this message translates to:
  /// **'Yếu'**
  String get label_weak;

  /// No description provided for @label_fair.
  ///
  /// In vi, this message translates to:
  /// **'Trung bình'**
  String get label_fair;

  /// No description provided for @label_good.
  ///
  /// In vi, this message translates to:
  /// **'Tốt'**
  String get label_good;

  /// No description provided for @label_strong.
  ///
  /// In vi, this message translates to:
  /// **'Mạnh'**
  String get label_strong;

  /// No description provided for @low_pass.
  ///
  /// In vi, this message translates to:
  /// **'Tối thiểu 8 ký tự, bao gồm chữ số và ký tự đặc biệt.'**
  String get low_pass;

  /// No description provided for @weak_pass.
  ///
  /// In vi, this message translates to:
  /// **'Quá ngắn. Vui lòng nhập thêm ký tự.'**
  String get weak_pass;

  /// No description provided for @fair_pass.
  ///
  /// In vi, this message translates to:
  /// **'Khá hơn rồi. Hãy thêm số và ký tự đặt biệt.'**
  String get fair_pass;

  /// No description provided for @good_pass_char.
  ///
  /// In vi, this message translates to:
  /// **'Sắp hoàn hảo! Hãy thêm ký tự đặc biệt để tăng bảo mật.'**
  String get good_pass_char;

  /// No description provided for @good_pass_num.
  ///
  /// In vi, this message translates to:
  /// **'Sắp hoàn hảo! Hãy thêm số để tăng bảo mật.'**
  String get good_pass_num;

  /// No description provided for @good_pass_special.
  ///
  /// In vi, this message translates to:
  /// **'Sắp hoàn hảo! Hãy thêm ký tự bất kì để tăng bảo mật.'**
  String get good_pass_special;

  /// No description provided for @strong_pass.
  ///
  /// In vi, this message translates to:
  /// **'Tuyệt vời! Mật khẩu của bạn đã an toàn.'**
  String get strong_pass;

  /// No description provided for @good_morning.
  ///
  /// In vi, this message translates to:
  /// **'Chào buổi sáng'**
  String get good_morning;

  /// No description provided for @good_afternoon.
  ///
  /// In vi, this message translates to:
  /// **'Chào buổi chiều'**
  String get good_afternoon;

  /// No description provided for @good_evening.
  ///
  /// In vi, this message translates to:
  /// **'Chào buổi tối'**
  String get good_evening;

  /// No description provided for @hello.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào'**
  String get hello;

  /// No description provided for @income.
  ///
  /// In vi, this message translates to:
  /// **'Thu nhập'**
  String get income;

  /// No description provided for @expenses.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiêu'**
  String get expenses;

  /// No description provided for @balance.
  ///
  /// In vi, this message translates to:
  /// **'Còn lại'**
  String get balance;

  /// No description provided for @total_balance.
  ///
  /// In vi, this message translates to:
  /// **'Tổng số dư'**
  String get total_balance;

  /// No description provided for @spending_this_month.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiêu trong tháng này'**
  String get spending_this_month;

  /// No description provided for @total_spent.
  ///
  /// In vi, this message translates to:
  /// **'Tổng chi tiêu'**
  String get total_spent;

  /// No description provided for @recent_transactions.
  ///
  /// In vi, this message translates to:
  /// **'Giao dịch gần đây'**
  String get recent_transactions;

  /// No description provided for @add_transaction.
  ///
  /// In vi, this message translates to:
  /// **'Thêm giao dịch'**
  String get add_transaction;

  /// No description provided for @settings.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get settings;

  /// No description provided for @profile.
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ'**
  String get profile;

  /// No description provided for @language.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ'**
  String get language;

  /// No description provided for @dark_mode.
  ///
  /// In vi, this message translates to:
  /// **'Chế độ tối'**
  String get dark_mode;

  /// No description provided for @notifications.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo'**
  String get notifications;

  /// No description provided for @about.
  ///
  /// In vi, this message translates to:
  /// **'Giới thiệu'**
  String get about;

  /// No description provided for @terms.
  ///
  /// In vi, this message translates to:
  /// **'Điều khoản & Điều kiện'**
  String get terms;

  /// No description provided for @privacy_policy.
  ///
  /// In vi, this message translates to:
  /// **'Chính sách quyền riêng tư'**
  String get privacy_policy;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
