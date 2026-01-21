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

  /// No description provided for @close.
  ///
  /// In vi, this message translates to:
  /// **'Đóng'**
  String get close;

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

  /// No description provided for @amount.
  ///
  /// In vi, this message translates to:
  /// **'Số tiền'**
  String get amount;

  /// No description provided for @name.
  ///
  /// In vi, this message translates to:
  /// **'Tên giao dịch'**
  String get name;

  /// No description provided for @date.
  ///
  /// In vi, this message translates to:
  /// **'Ngày'**
  String get date;

  /// No description provided for @month.
  ///
  /// In vi, this message translates to:
  /// **'Tháng'**
  String get month;

  /// No description provided for @today.
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay'**
  String get today;

  /// No description provided for @other.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get other;

  /// No description provided for @home.
  ///
  /// In vi, this message translates to:
  /// **'Trang chủ'**
  String get home;

  /// No description provided for @reports.
  ///
  /// In vi, this message translates to:
  /// **'Báo cáo'**
  String get reports;

  /// No description provided for @budgets.
  ///
  /// In vi, this message translates to:
  /// **'Ngân sách'**
  String get budgets;

  /// No description provided for @all.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get all;

  /// No description provided for @error.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi'**
  String get error;

  /// No description provided for @user.
  ///
  /// In vi, this message translates to:
  /// **'Người dùng'**
  String get user;

  /// No description provided for @success.
  ///
  /// In vi, this message translates to:
  /// **'Thành công'**
  String get success;

  /// No description provided for @loading.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải...'**
  String get loading;

  /// No description provided for @onboard_step1_title.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chép trong nháy mắt'**
  String get onboard_step1_title;

  /// No description provided for @onboard_step1_message.
  ///
  /// In vi, this message translates to:
  /// **'Tự động xác định địa điểm chi tiêu giúp bạn ghi chép nhanh hơn bao giờ hết. Không còn phải nhớ mình đã tiêu gì ở đâu.'**
  String get onboard_step1_message;

  /// No description provided for @onboard_step2_title.
  ///
  /// In vi, this message translates to:
  /// **'Làm chủ ví tiền của bạn'**
  String get onboard_step2_title;

  /// No description provided for @onboard_step2_message.
  ///
  /// In vi, this message translates to:
  /// **'Thiết lập hạn mức chi tiêu cho từng danh mục. Chúng tôi sẽ giúp bạn luôn đi đúng lộ trình tài chính.'**
  String get onboard_step2_message;

  /// No description provided for @onboard_step3_title.
  ///
  /// In vi, this message translates to:
  /// **'Xây dựng thói quen tốt'**
  String get onboard_step3_title;

  /// No description provided for @onboard_step3_message.
  ///
  /// In vi, this message translates to:
  /// **'Nhận thông báo nhắc nhở vào cuối ngày để không bỏ lỡ bất kỳ giao dịch nào. Kỷ luật là chìa khóa của sự thịnh vượng.'**
  String get onboard_step3_message;

  /// No description provided for @create_first_wallet.
  ///
  /// In vi, this message translates to:
  /// **'Tạo ví đầu tiên của bạn'**
  String get create_first_wallet;

  /// No description provided for @welcome_create_wallet.
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng đến với SpendFlow!\nHãy tạo ví đầu tiên của bạn để bắt đầu.'**
  String get welcome_create_wallet;

  /// No description provided for @enter_wallet_name.
  ///
  /// In vi, this message translates to:
  /// **'Nhập tên ví'**
  String get enter_wallet_name;

  /// No description provided for @eg_my_wallet.
  ///
  /// In vi, this message translates to:
  /// **'ví dụ: Ví của tôi, Tiền mặt, Thẻ tín dụng'**
  String get eg_my_wallet;

  /// No description provided for @currency_unit.
  ///
  /// In vi, this message translates to:
  /// **'Đơn vị tiền tệ'**
  String get currency_unit;

  /// No description provided for @create_wallet.
  ///
  /// In vi, this message translates to:
  /// **'Tạo ví'**
  String get create_wallet;

  /// No description provided for @please_enter_wallet_name.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập tên ví.'**
  String get please_enter_wallet_name;

  /// No description provided for @add_wallet.
  ///
  /// In vi, this message translates to:
  /// **'Thêm ví mới'**
  String get add_wallet;

  /// No description provided for @wallet_name.
  ///
  /// In vi, this message translates to:
  /// **'Tên ví'**
  String get wallet_name;

  /// No description provided for @add_wallet_description.
  ///
  /// In vi, this message translates to:
  /// **'Thêm nhiều ví để quản lí và theo dõi tài chính hiệu quả hơn.'**
  String get add_wallet_description;

  /// No description provided for @cannot_delete_last_wallet.
  ///
  /// In vi, this message translates to:
  /// **'Bạn không thể xóa ví duy nhất.'**
  String get cannot_delete_last_wallet;

  /// No description provided for @delete_wallet.
  ///
  /// In vi, this message translates to:
  /// **'Xóa ví'**
  String get delete_wallet;

  /// No description provided for @delete_wallet_confirmation.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa ví \'{walletName}\' không? Hành động này không thể hoàn tác.'**
  String delete_wallet_confirmation(Object walletName);

  /// No description provided for @in_use.
  ///
  /// In vi, this message translates to:
  /// **'Đang sử dụng'**
  String get in_use;

  /// No description provided for @incomplete_details.
  ///
  /// In vi, this message translates to:
  /// **'Thiếu dữ liệu'**
  String get incomplete_details;

  /// No description provided for @please_fill_required_fields.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng điền vào các trường bắt buộc sau:'**
  String get please_fill_required_fields;

  /// No description provided for @select_wallet.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ví'**
  String get select_wallet;

  /// No description provided for @please_create_wallet_first.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng tạo ví trước khi thêm giao dịch.'**
  String get please_create_wallet_first;

  /// No description provided for @create_now.
  ///
  /// In vi, this message translates to:
  /// **'Tạo ngay'**
  String get create_now;

  /// No description provided for @no_wallets_yet.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có ví nào'**
  String get no_wallets_yet;

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

  /// No description provided for @or_continue_with.
  ///
  /// In vi, this message translates to:
  /// **'Hoặc đăng nhập với'**
  String get or_continue_with;

  /// No description provided for @sign_in_with.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập với {provider}'**
  String sign_in_with(Object provider);

  /// No description provided for @check_your_mail.
  ///
  /// In vi, this message translates to:
  /// **'Kiểm tra email của bạn'**
  String get check_your_mail;

  /// No description provided for @we_have_sent_mail.
  ///
  /// In vi, this message translates to:
  /// **'Chúng tôi đã gửi một email đến:'**
  String get we_have_sent_mail;

  /// No description provided for @please_check_your_mail_to_verify_account.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng kiểm tra email của bạn để xác thực tài khoản trước khi đăng nhập.'**
  String get please_check_your_mail_to_verify_account;

  /// No description provided for @register_failed.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký thất bại'**
  String get register_failed;

  /// No description provided for @please_fill_all_fields.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng điền vào tất cả các trường.'**
  String get please_fill_all_fields;

  /// No description provided for @please_enter_email_and_password.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập cả email và mật khẩu.'**
  String get please_enter_email_and_password;

  /// No description provided for @incorrect_email_or_password.
  ///
  /// In vi, this message translates to:
  /// **'Email hoặc mật khẩu không đúng.'**
  String get incorrect_email_or_password;

  /// No description provided for @invalid_email_format.
  ///
  /// In vi, this message translates to:
  /// **'Định dạng email không hợp lệ.'**
  String get invalid_email_format;

  /// No description provided for @this_account_has_been_disabled.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản này đã bị vô hiệu hóa.'**
  String get this_account_has_been_disabled;

  /// No description provided for @too_many_requests_please_try_later.
  ///
  /// In vi, this message translates to:
  /// **'Quá nhiều yêu cầu. Vui lòng thử lại sau.'**
  String get too_many_requests_please_try_later;

  /// No description provided for @email_not_verified.
  ///
  /// In vi, this message translates to:
  /// **'Email chưa được xác thực'**
  String get email_not_verified;

  /// No description provided for @please_verify_your_email_to_continue.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng xác thực email của bạn để tiếp tục.'**
  String get please_verify_your_email_to_continue;

  /// No description provided for @are_you_sure_logout.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn đăng xuất không?'**
  String get are_you_sure_logout;

  /// No description provided for @have_error_occurred.
  ///
  /// In vi, this message translates to:
  /// **'Đã xảy ra lỗi. Vui lòng thử lại.'**
  String get have_error_occurred;

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

  /// No description provided for @password_reset_email_sent.
  ///
  /// In vi, this message translates to:
  /// **'Chúng tôi đã gửi một liên kết đặt lại mật khẩu đến email của bạn.'**
  String get password_reset_email_sent;

  /// No description provided for @forgot_password_description.
  ///
  /// In vi, this message translates to:
  /// **'Nhập email được liên kết với tài khoản của bạn để đặt lại mật khẩu.'**
  String get forgot_password_description;

  /// No description provided for @send_email_reset.
  ///
  /// In vi, this message translates to:
  /// **'Gửi email đặt lại'**
  String get send_email_reset;

  /// No description provided for @password_weak_password.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu quá yếu.'**
  String get password_weak_password;

  /// No description provided for @please_edit_fields.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chỉnh sửa các trường sau để tiếp tục:'**
  String get please_edit_fields;

  /// No description provided for @something_went_wrong.
  ///
  /// In vi, this message translates to:
  /// **'Đã xảy ra lỗi. Vui lòng thử lại.'**
  String get something_went_wrong;

  /// No description provided for @network_error.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi kết nối mạng, vui lòng kiểm tra lại.'**
  String get network_error;

  /// No description provided for @email_already_in_use.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ email đã được sử dụng bởi tài khoản khác.'**
  String get email_already_in_use;

  /// No description provided for @invalid_email.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ email không hợp lệ.'**
  String get invalid_email;

  /// No description provided for @operation_not_allowed.
  ///
  /// In vi, this message translates to:
  /// **'Không cho phép thực hiện. Vui lòng liên hệ hỗ trợ.'**
  String get operation_not_allowed;

  /// No description provided for @reset_password.
  ///
  /// In vi, this message translates to:
  /// **'Đặt lại mật khẩu'**
  String get reset_password;

  /// No description provided for @email_not_received.
  ///
  /// In vi, this message translates to:
  /// **'Không nhận được email?'**
  String get email_not_received;

  /// No description provided for @verification_email_sent.
  ///
  /// In vi, this message translates to:
  /// **'Đã gửi email xác thực'**
  String get verification_email_sent;

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

  /// No description provided for @no_transactions.
  ///
  /// In vi, this message translates to:
  /// **'Không có dữ liệu'**
  String get no_transactions;

  /// No description provided for @enter_transaction_name.
  ///
  /// In vi, this message translates to:
  /// **'Nhập tên giao dịch'**
  String get enter_transaction_name;

  /// No description provided for @suggested_category.
  ///
  /// In vi, this message translates to:
  /// **'Danh mục gợi ý'**
  String get suggested_category;

  /// No description provided for @category.
  ///
  /// In vi, this message translates to:
  /// **'Danh mục'**
  String get category;

  /// No description provided for @categories.
  ///
  /// In vi, this message translates to:
  /// **'Danh mục'**
  String get categories;

  /// No description provided for @select_category.
  ///
  /// In vi, this message translates to:
  /// **'Chọn danh mục'**
  String get select_category;

  /// No description provided for @edit_category.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa danh mục'**
  String get edit_category;

  /// No description provided for @are_you_sure_delete_category.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa danh mục {categoryName}?'**
  String are_you_sure_delete_category(Object categoryName);

  /// No description provided for @system_category.
  ///
  /// In vi, this message translates to:
  /// **'Danh mục hệ thống không thể xóa.'**
  String get system_category;

  /// No description provided for @system_category_description.
  ///
  /// In vi, this message translates to:
  /// **'Bạn không thể chỉnh sửa hoặc xóa danh mục mặc định này.'**
  String get system_category_description;

  /// No description provided for @category_food.
  ///
  /// In vi, this message translates to:
  /// **'Ăn uống'**
  String get category_food;

  /// No description provided for @category_transport.
  ///
  /// In vi, this message translates to:
  /// **'Di chuyển'**
  String get category_transport;

  /// No description provided for @category_salary.
  ///
  /// In vi, this message translates to:
  /// **'Lương'**
  String get category_salary;

  /// No description provided for @category_shopping.
  ///
  /// In vi, this message translates to:
  /// **'Mua sắm'**
  String get category_shopping;

  /// No description provided for @category_game.
  ///
  /// In vi, this message translates to:
  /// **'Trò chơi'**
  String get category_game;

  /// No description provided for @category_house.
  ///
  /// In vi, this message translates to:
  /// **'Nhà cửa'**
  String get category_house;

  /// No description provided for @category_gift.
  ///
  /// In vi, this message translates to:
  /// **'Quà tặng'**
  String get category_gift;

  /// No description provided for @category_health.
  ///
  /// In vi, this message translates to:
  /// **'Sức khỏe'**
  String get category_health;

  /// No description provided for @category_entertainment.
  ///
  /// In vi, this message translates to:
  /// **'Giải trí'**
  String get category_entertainment;

  /// No description provided for @category_bill.
  ///
  /// In vi, this message translates to:
  /// **'Hóa đơn'**
  String get category_bill;

  /// No description provided for @category_insurance.
  ///
  /// In vi, this message translates to:
  /// **'Bảo hiểm'**
  String get category_insurance;

  /// No description provided for @category_education.
  ///
  /// In vi, this message translates to:
  /// **'Giáo dục'**
  String get category_education;

  /// No description provided for @category_pet.
  ///
  /// In vi, this message translates to:
  /// **'Thú cưng'**
  String get category_pet;

  /// No description provided for @category_travel.
  ///
  /// In vi, this message translates to:
  /// **'Du lịch'**
  String get category_travel;

  /// No description provided for @category_savings.
  ///
  /// In vi, this message translates to:
  /// **'Tiết kiệm'**
  String get category_savings;

  /// No description provided for @category_phone.
  ///
  /// In vi, this message translates to:
  /// **'Điện thoại'**
  String get category_phone;

  /// No description provided for @category_internet.
  ///
  /// In vi, this message translates to:
  /// **'Internet'**
  String get category_internet;

  /// No description provided for @category_water.
  ///
  /// In vi, this message translates to:
  /// **'Nước'**
  String get category_water;

  /// No description provided for @category_electricity.
  ///
  /// In vi, this message translates to:
  /// **'Điện'**
  String get category_electricity;

  /// No description provided for @category_gas.
  ///
  /// In vi, this message translates to:
  /// **'Gas'**
  String get category_gas;

  /// No description provided for @category_cleaning.
  ///
  /// In vi, this message translates to:
  /// **'Dọn dẹp'**
  String get category_cleaning;

  /// No description provided for @category_beauty.
  ///
  /// In vi, this message translates to:
  /// **'Làm đẹp'**
  String get category_beauty;

  /// No description provided for @category_baby.
  ///
  /// In vi, this message translates to:
  /// **'Em bé'**
  String get category_baby;

  /// No description provided for @category_sport.
  ///
  /// In vi, this message translates to:
  /// **'Thể thao'**
  String get category_sport;

  /// No description provided for @category_music.
  ///
  /// In vi, this message translates to:
  /// **'Âm nhạc'**
  String get category_music;

  /// No description provided for @category_repair.
  ///
  /// In vi, this message translates to:
  /// **'Sửa chữa'**
  String get category_repair;

  /// No description provided for @category_tax.
  ///
  /// In vi, this message translates to:
  /// **'Thuế'**
  String get category_tax;

  /// No description provided for @note.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú (tùy chọn)'**
  String get note;

  /// No description provided for @enter_note.
  ///
  /// In vi, this message translates to:
  /// **'Nhập ghi chú'**
  String get enter_note;

  /// No description provided for @add_income.
  ///
  /// In vi, this message translates to:
  /// **'Thêm thu nhập'**
  String get add_income;

  /// No description provided for @add_expense.
  ///
  /// In vi, this message translates to:
  /// **'Thêm chi tiêu'**
  String get add_expense;

  /// No description provided for @search_category.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm danh mục'**
  String get search_category;

  /// No description provided for @no_category_found.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy danh mục'**
  String get no_category_found;

  /// No description provided for @most_used.
  ///
  /// In vi, this message translates to:
  /// **'Sử dụng nhiều nhất'**
  String get most_used;

  /// No description provided for @category_suggestions.
  ///
  /// In vi, this message translates to:
  /// **'Danh mục gợi ý'**
  String get category_suggestions;

  /// No description provided for @all_categories.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả danh mục'**
  String get all_categories;

  /// No description provided for @new_category.
  ///
  /// In vi, this message translates to:
  /// **'Danh mục mới'**
  String get new_category;

  /// No description provided for @category_name.
  ///
  /// In vi, this message translates to:
  /// **'Tên danh mục'**
  String get category_name;

  /// No description provided for @category_color.
  ///
  /// In vi, this message translates to:
  /// **'Màu danh mục'**
  String get category_color;

  /// No description provided for @category_icon.
  ///
  /// In vi, this message translates to:
  /// **'Biểu tượng danh mục'**
  String get category_icon;

  /// No description provided for @vs_last_month.
  ///
  /// In vi, this message translates to:
  /// **'so với Tháng trước'**
  String get vs_last_month;

  /// No description provided for @transaction.
  ///
  /// In vi, this message translates to:
  /// **'Giao dịch'**
  String get transaction;

  /// No description provided for @delete_transaction.
  ///
  /// In vi, this message translates to:
  /// **'Xóa giao dịch'**
  String get delete_transaction;

  /// No description provided for @delete_transaction_confirmation.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa giao dịch này không?'**
  String get delete_transaction_confirmation;

  /// No description provided for @transaction_details.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết giao dịch'**
  String get transaction_details;

  /// No description provided for @spending_trend.
  ///
  /// In vi, this message translates to:
  /// **'Xu hướng chi tiêu'**
  String get spending_trend;

  /// No description provided for @spending_last_7_days.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiêu trong 7 ngày qua'**
  String get spending_last_7_days;

  /// No description provided for @note_2.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú'**
  String get note_2;

  /// No description provided for @scan_receipt.
  ///
  /// In vi, this message translates to:
  /// **'Quét hóa đơn'**
  String get scan_receipt;

  /// No description provided for @add_via_voice.
  ///
  /// In vi, this message translates to:
  /// **'Thêm bằng giọng nói'**
  String get add_via_voice;

  /// No description provided for @add_manually.
  ///
  /// In vi, this message translates to:
  /// **'Thêm thủ công'**
  String get add_manually;

  /// No description provided for @limit_reached.
  ///
  /// In vi, this message translates to:
  /// **'Đã đạt giới hạn'**
  String get limit_reached;

  /// No description provided for @limit_reached_description.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã sử dụng {featureName} {limit} lần hôm nay.\nVui lòng quay lại vào ngày mai hoặc nâng cấp lên Premium.'**
  String limit_reached_description(Object featureName, Object limit);

  /// No description provided for @align_receipt.
  ///
  /// In vi, this message translates to:
  /// **'Căn chỉnh hóa đơn của bạn vào khung'**
  String get align_receipt;

  /// No description provided for @listening.
  ///
  /// In vi, this message translates to:
  /// **'Đang nghe...'**
  String get listening;

  /// No description provided for @voice_example.
  ///
  /// In vi, this message translates to:
  /// **'Ví dụ: Tôi đã chi 50 đô la cho thực phẩm'**
  String get voice_example;

  /// No description provided for @tap_to_stop.
  ///
  /// In vi, this message translates to:
  /// **'Chạm để dừng'**
  String get tap_to_stop;

  /// No description provided for @tap_to_listen.
  ///
  /// In vi, this message translates to:
  /// **'Chạm để nghe'**
  String get tap_to_listen;

  /// No description provided for @yesterday.
  ///
  /// In vi, this message translates to:
  /// **'Hôm qua'**
  String get yesterday;

  /// No description provided for @your_monthly_budget.
  ///
  /// In vi, this message translates to:
  /// **'Ngân sách hàng tháng của bạn'**
  String get your_monthly_budget;

  /// No description provided for @spent.
  ///
  /// In vi, this message translates to:
  /// **'Đã chi '**
  String get spent;

  /// No description provided for @out_of.
  ///
  /// In vi, this message translates to:
  /// **' trong tổng '**
  String get out_of;

  /// No description provided for @left_to_spend.
  ///
  /// In vi, this message translates to:
  /// **'còn lại để chi tiêu'**
  String get left_to_spend;

  /// No description provided for @add_budget.
  ///
  /// In vi, this message translates to:
  /// **'Thêm ngân sách'**
  String get add_budget;

  /// No description provided for @no_budgets_yet.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có ngân sách nào'**
  String get no_budgets_yet;

  /// No description provided for @create_budget_description.
  ///
  /// In vi, this message translates to:
  /// **'Nhấn + để tạo giới hạn chi tiêu'**
  String get create_budget_description;

  /// No description provided for @edit_budget.
  ///
  /// In vi, this message translates to:
  /// **'Sửa ngân sách'**
  String get edit_budget;

  /// No description provided for @are_you_sure_delete_budget.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc muốn xóa ngân sách \n {budgetName}? \n'**
  String are_you_sure_delete_budget(Object budgetName);

  /// No description provided for @delete_budget.
  ///
  /// In vi, this message translates to:
  /// **'Xóa ngân sách'**
  String get delete_budget;

  /// No description provided for @settings.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get settings;

  /// No description provided for @settings_description.
  ///
  /// In vi, this message translates to:
  /// **'Giữ dữ liệu tài chính luôn đồng bộ trên tất cả thiết bị của bạn'**
  String get settings_description;

  /// No description provided for @sign_in_now.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập ngay'**
  String get sign_in_now;

  /// No description provided for @get_started.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu ngay'**
  String get get_started;

  /// No description provided for @welcome.
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng !'**
  String get welcome;

  /// No description provided for @general.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt chung'**
  String get general;

  /// No description provided for @security.
  ///
  /// In vi, this message translates to:
  /// **'Bảo mật'**
  String get security;

  /// No description provided for @privacy_and_security.
  ///
  /// In vi, this message translates to:
  /// **'Quyền riêng tư & Bảo mật'**
  String get privacy_and_security;

  /// No description provided for @support.
  ///
  /// In vi, this message translates to:
  /// **'Hỗ trợ'**
  String get support;

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

  /// No description provided for @appearance.
  ///
  /// In vi, this message translates to:
  /// **'Giao diện'**
  String get appearance;

  /// No description provided for @currency.
  ///
  /// In vi, this message translates to:
  /// **'Tiền tệ'**
  String get currency;

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

  /// No description provided for @version.
  ///
  /// In vi, this message translates to:
  /// **'Phiên bản'**
  String get version;

  /// No description provided for @edit_profile.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa hồ sơ'**
  String get edit_profile;

  /// No description provided for @full_name.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên'**
  String get full_name;

  /// No description provided for @enter_full_name.
  ///
  /// In vi, this message translates to:
  /// **'Nhập họ và tên'**
  String get enter_full_name;

  /// No description provided for @email_address.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ email'**
  String get email_address;

  /// No description provided for @enter_email_address.
  ///
  /// In vi, this message translates to:
  /// **'Nhập địa chỉ email'**
  String get enter_email_address;

  /// No description provided for @phone_number.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get phone_number;

  /// No description provided for @enter_phone_number.
  ///
  /// In vi, this message translates to:
  /// **'Nhập số điện thoại'**
  String get enter_phone_number;

  /// No description provided for @day_of_birth.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh'**
  String get day_of_birth;

  /// No description provided for @select_day_of_birth.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ngày sinh'**
  String get select_day_of_birth;

  /// No description provided for @save_changes.
  ///
  /// In vi, this message translates to:
  /// **'Lưu thay đổi'**
  String get save_changes;

  /// No description provided for @profile_updated_success.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật hồ sơ thành công!'**
  String get profile_updated_success;

  /// No description provided for @error_updating_profile.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi khi cập nhật hồ sơ.'**
  String get error_updating_profile;

  /// No description provided for @error_uploading_avatar.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi khi tải lên ảnh đại diện.'**
  String get error_uploading_avatar;

  /// No description provided for @upgrade_premium.
  ///
  /// In vi, this message translates to:
  /// **'Nâng cấp lên Premium!'**
  String get upgrade_premium;

  /// No description provided for @upgrade_premium_description.
  ///
  /// In vi, this message translates to:
  /// **'Mở khóa các tính năng cao cấp và nâng cao trải nghiệm của bạn.'**
  String get upgrade_premium_description;

  /// No description provided for @upgrade_now.
  ///
  /// In vi, this message translates to:
  /// **'Nâng cấp ngay'**
  String get upgrade_now;

  /// No description provided for @you_are_premium.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã sẵn sàng, người dùng Premium!'**
  String get you_are_premium;

  /// No description provided for @you_are_premium_description.
  ///
  /// In vi, this message translates to:
  /// **'Tận hưởng trải nghiệm nâng cao của bạn.'**
  String get you_are_premium_description;

  /// No description provided for @import_export_data.
  ///
  /// In vi, this message translates to:
  /// **'Nhập/Xuất dữ liệu'**
  String get import_export_data;

  /// No description provided for @sync_data.
  ///
  /// In vi, this message translates to:
  /// **'Đồng bộ dữ liệu'**
  String get sync_data;

  /// No description provided for @continue_with.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục với {price} / tháng'**
  String continue_with(Object price);

  /// No description provided for @biometric_authentication.
  ///
  /// In vi, this message translates to:
  /// **'Xác thực sinh trắc học'**
  String get biometric_authentication;

  /// No description provided for @password_security.
  ///
  /// In vi, this message translates to:
  /// **'Bảo mật mật mã'**
  String get password_security;

  /// No description provided for @face_id_description.
  ///
  /// In vi, this message translates to:
  /// **'Mở khóa ứng dụng chỉ bằng một ánh nhìn. Face ID mang lại sự tiện lợi và bảo mật bằng cách nhận diện khuôn mặt của bạn.'**
  String get face_id_description;

  /// No description provided for @touch_id_description.
  ///
  /// In vi, this message translates to:
  /// **'Mở khóa ứng dụng chỉ bằng một cú chạm. Touch ID giúp truy cập nhanh chóng và an toàn bằng vân tay của bạn.'**
  String get touch_id_description;

  /// No description provided for @pass_code_description.
  ///
  /// In vi, this message translates to:
  /// **'Thêm một lớp bảo vệ. Mã khóa đảm bảo chỉ bạn mới có thể truy cập dữ liệu tài chính, ngay cả khi thiết bị bị xâm phạm.'**
  String get pass_code_description;

  /// No description provided for @passcode.
  ///
  /// In vi, this message translates to:
  /// **'Passcode'**
  String get passcode;

  /// No description provided for @change_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Đổi passcode'**
  String get change_passcode;

  /// No description provided for @old_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Mã khóa cũ'**
  String get old_passcode;

  /// No description provided for @enter_old_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã khóa cũ'**
  String get enter_old_passcode;

  /// No description provided for @new_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Passcode mới'**
  String get new_passcode;

  /// No description provided for @enter_new_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Nhập Passcode mới'**
  String get enter_new_passcode;

  /// No description provided for @confirm_new_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận Passcode mới'**
  String get confirm_new_passcode;

  /// No description provided for @enter_confirm_new_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại Passcode mới'**
  String get enter_confirm_new_passcode;

  /// No description provided for @turnOffPasscode.
  ///
  /// In vi, this message translates to:
  /// **'Tắt Passcode'**
  String get turnOffPasscode;

  /// No description provided for @createPasscode.
  ///
  /// In vi, this message translates to:
  /// **'Tạo Passcode'**
  String get createPasscode;

  /// No description provided for @changePasscode.
  ///
  /// In vi, this message translates to:
  /// **'Đổi Passcode'**
  String get changePasscode;

  /// No description provided for @removePasscode.
  ///
  /// In vi, this message translates to:
  /// **'Xóa Passcode'**
  String get removePasscode;

  /// No description provided for @updatePasscode.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật Passcode'**
  String get updatePasscode;

  /// No description provided for @description_create_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Bảo vệ tài khoản của bạn bằng cách thường xuyên cập nhật Passcode 6 chữ số.'**
  String get description_create_passcode;

  /// No description provided for @description_remove_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Nhập Passcode hiện tại của bạn để tắt bảo mật.'**
  String get description_remove_passcode;

  /// No description provided for @currentPasscode.
  ///
  /// In vi, this message translates to:
  /// **'Passcode hiện tại'**
  String get currentPasscode;

  /// No description provided for @enterCurrentPin.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã PIN hiện tại'**
  String get enterCurrentPin;

  /// No description provided for @passcode_turn_off_success.
  ///
  /// In vi, this message translates to:
  /// **'Passcode đã được tắt thành công!'**
  String get passcode_turn_off_success;

  /// No description provided for @passcode_update_success.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật Passcode thành công!'**
  String get passcode_update_success;

  /// No description provided for @passcode_create_success.
  ///
  /// In vi, this message translates to:
  /// **'Tạo Passcode thành công!'**
  String get passcode_create_success;

  /// No description provided for @currentPasscodeIncorrect.
  ///
  /// In vi, this message translates to:
  /// **'Passcode hiện tại không đúng.'**
  String get currentPasscodeIncorrect;

  /// No description provided for @errorSavingData.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi khi lưu dữ liệu.'**
  String get errorSavingData;

  /// No description provided for @newPasscodeMustBe6Digits.
  ///
  /// In vi, this message translates to:
  /// **'Passcode mới phải có 6 chữ số.'**
  String get newPasscodeMustBe6Digits;

  /// No description provided for @passcodesDoNotMatch.
  ///
  /// In vi, this message translates to:
  /// **'Passcode không khớp.'**
  String get passcodesDoNotMatch;

  /// No description provided for @enter_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Nhập Passcode'**
  String get enter_passcode;

  /// No description provided for @incorrect_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Passcode không đúng.'**
  String get incorrect_passcode;

  /// No description provided for @face.
  ///
  /// In vi, this message translates to:
  /// **'Face ID'**
  String get face;

  /// No description provided for @fingerprint.
  ///
  /// In vi, this message translates to:
  /// **'Vân tay'**
  String get fingerprint;

  /// No description provided for @report_locked.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung được khóa'**
  String get report_locked;

  /// No description provided for @unlock.
  ///
  /// In vi, this message translates to:
  /// **'Mở khóa'**
  String get unlock;

  /// No description provided for @unlock_untilimited_access.
  ///
  /// In vi, this message translates to:
  /// **'Mở khóa truy cập không giới hạn'**
  String get unlock_untilimited_access;

  /// No description provided for @unlock_untilimited_access_description.
  ///
  /// In vi, this message translates to:
  /// **'Nâng cấp lên Premium để loại bỏ mọi giới hạn và truy cập các tính năng nâng cao.'**
  String get unlock_untilimited_access_description;

  /// No description provided for @daily_input_cap_reached.
  ///
  /// In vi, this message translates to:
  /// **'Đã đạt giới hạn nhập hàng ngày'**
  String get daily_input_cap_reached;

  /// No description provided for @daily_input_cap_reached_description.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã đạt giới hạn nhập hàng ngày cho việc quét hóa đơn và nhập giọng nói. Nâng cấp ngay để tiếp tục.'**
  String get daily_input_cap_reached_description;

  /// No description provided for @feature_comparison.
  ///
  /// In vi, this message translates to:
  /// **'So sánh tính năng'**
  String get feature_comparison;

  /// No description provided for @feature.
  ///
  /// In vi, this message translates to:
  /// **'Tính năng'**
  String get feature;

  /// No description provided for @free.
  ///
  /// In vi, this message translates to:
  /// **'Miễn phí'**
  String get free;

  /// No description provided for @premium.
  ///
  /// In vi, this message translates to:
  /// **'Cao cấp'**
  String get premium;

  /// No description provided for @no_ads.
  ///
  /// In vi, this message translates to:
  /// **'Không quảng cáo'**
  String get no_ads;

  /// No description provided for @transaction_locking.
  ///
  /// In vi, this message translates to:
  /// **'Khóa sổ giao dịch'**
  String get transaction_locking;

  /// No description provided for @unlimited_scans.
  ///
  /// In vi, this message translates to:
  /// **'Quét hóa đơn không giới hạn'**
  String get unlimited_scans;

  /// No description provided for @unlimited_voice_entries.
  ///
  /// In vi, this message translates to:
  /// **'Nhập giọng nói không giới hạn'**
  String get unlimited_voice_entries;

  /// No description provided for @day.
  ///
  /// In vi, this message translates to:
  /// **'ngày'**
  String get day;

  /// No description provided for @accept_terms_conditions.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký tự động gia hạn. Bằng cách tiếp tục, bạn đồng ý với Điều khoản Dịch vụ và Chính sách Quyền riêng tư của chúng tôi.'**
  String get accept_terms_conditions;

  /// No description provided for @restore.
  ///
  /// In vi, this message translates to:
  /// **'Khôi phục'**
  String get restore;

  /// No description provided for @select_language.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ngôn ngữ'**
  String get select_language;

  /// No description provided for @suggested.
  ///
  /// In vi, this message translates to:
  /// **'Gợi ý'**
  String get suggested;

  /// No description provided for @all_languages.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả ngôn ngữ'**
  String get all_languages;

  /// No description provided for @apply_changes.
  ///
  /// In vi, this message translates to:
  /// **'Áp dụng thay đổi'**
  String get apply_changes;

  /// No description provided for @select_currency.
  ///
  /// In vi, this message translates to:
  /// **'Chọn tiền tệ'**
  String get select_currency;

  /// No description provided for @search_currency.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm tiền tệ hoặc quốc gia...'**
  String get search_currency;

  /// No description provided for @popular.
  ///
  /// In vi, this message translates to:
  /// **'Phổ biến'**
  String get popular;

  /// No description provided for @all_currencies.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả tiền tệ'**
  String get all_currencies;

  /// No description provided for @currency_change_warning.
  ///
  /// In vi, this message translates to:
  /// **'Thay đổi tiền tệ chỉ cập nhật ký hiệu hiển thị. Tỷ giá giao dịch trước đó sẽ không được tính toán lại.'**
  String get currency_change_warning;

  /// No description provided for @data_management.
  ///
  /// In vi, this message translates to:
  /// **'Quản lý dữ liệu'**
  String get data_management;

  /// No description provided for @select_format.
  ///
  /// In vi, this message translates to:
  /// **'Chọn định dạng'**
  String get select_format;

  /// No description provided for @export_data.
  ///
  /// In vi, this message translates to:
  /// **'Xuất dữ liệu'**
  String get export_data;

  /// No description provided for @export_data_description.
  ///
  /// In vi, this message translates to:
  /// **'Xuất dữ liệu tài chính của bạn để sao lưu hoặc phân tích.'**
  String get export_data_description;

  /// No description provided for @confirm_export.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận xuất'**
  String get confirm_export;

  /// No description provided for @import_data.
  ///
  /// In vi, this message translates to:
  /// **'Nhập dữ liệu'**
  String get import_data;

  /// No description provided for @import_data_description.
  ///
  /// In vi, this message translates to:
  /// **'Nhập dữ liệu tài chính từ các nguồn bên ngoài để đồng bộ hóa với ứng dụng.'**
  String get import_data_description;

  /// No description provided for @import_data_title.
  ///
  /// In vi, this message translates to:
  /// **'Nhập '**
  String get import_data_title;

  /// No description provided for @data.
  ///
  /// In vi, this message translates to:
  /// **'dữ liệu'**
  String get data;

  /// No description provided for @import_data_title_2.
  ///
  /// In vi, this message translates to:
  /// **' của bạn.'**
  String get import_data_title_2;

  /// No description provided for @confirm_import.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận nhập'**
  String get confirm_import;

  /// No description provided for @csv_format.
  ///
  /// In vi, this message translates to:
  /// **'Định dạng CSV'**
  String get csv_format;

  /// No description provided for @csv_description.
  ///
  /// In vi, this message translates to:
  /// **'Dữ liệu được phân tách bằng dấu phẩy, tương thích với hầu hết các ứng dụng bảng tính.'**
  String get csv_description;

  /// No description provided for @json_format.
  ///
  /// In vi, this message translates to:
  /// **'Định dạng JSON'**
  String get json_format;

  /// No description provided for @json_description.
  ///
  /// In vi, this message translates to:
  /// **'Định dạng dữ liệu linh hoạt, lý tưởng cho việc trao đổi dữ liệu giữa các ứng dụng.'**
  String get json_description;

  /// No description provided for @excel_format.
  ///
  /// In vi, this message translates to:
  /// **'Định dạng Excel'**
  String get excel_format;

  /// No description provided for @excel_description.
  ///
  /// In vi, this message translates to:
  /// **'Định dạng bảng tính phổ biến, hỗ trợ các tính năng nâng cao và phân tích dữ liệu.'**
  String get excel_description;

  /// No description provided for @select_file.
  ///
  /// In vi, this message translates to:
  /// **'Chọn tệp'**
  String get select_file;

  /// No description provided for @no_file_selected.
  ///
  /// In vi, this message translates to:
  /// **'Chưa chọn tệp nào'**
  String get no_file_selected;

  /// No description provided for @import_successful.
  ///
  /// In vi, this message translates to:
  /// **'Nhập dữ liệu thành công!'**
  String get import_successful;

  /// No description provided for @error_importing_data.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi khi nhập dữ liệu.'**
  String get error_importing_data;

  /// No description provided for @sync_data_now.
  ///
  /// In vi, this message translates to:
  /// **'Đồng bộ ngay'**
  String get sync_data_now;

  /// No description provided for @last_synced.
  ///
  /// In vi, this message translates to:
  /// **'Đồng bộ lần cuối: \n{time}'**
  String last_synced(Object time);

  /// No description provided for @syncing.
  ///
  /// In vi, this message translates to:
  /// **'Đang đồng bộ...'**
  String get syncing;

  /// No description provided for @never_synced.
  ///
  /// In vi, this message translates to:
  /// **'Chưa đồng bộ'**
  String get never_synced;

  /// No description provided for @accepted_formats.
  ///
  /// In vi, this message translates to:
  /// **'Chấp nhận các định dạng'**
  String get accepted_formats;

  /// No description provided for @select_file_to_import.
  ///
  /// In vi, this message translates to:
  /// **'Chọn tệp để nhập'**
  String get select_file_to_import;

  /// No description provided for @tap_to_browse.
  ///
  /// In vi, this message translates to:
  /// **'Chạm để duyệt thiết bị hoặc lưu trữ đám mây của bạn cho các tệp.'**
  String get tap_to_browse;

  /// No description provided for @protected.
  ///
  /// In vi, this message translates to:
  /// **'Được bảo vệ'**
  String get protected;

  /// No description provided for @protected_description.
  ///
  /// In vi, this message translates to:
  /// **'Dữ liệu của bạn không bao giờ rời khỏi thiết bị và được xử lý cục bộ.'**
  String get protected_description;

  /// No description provided for @recent_imports.
  ///
  /// In vi, this message translates to:
  /// **'Nhập gần đây'**
  String get recent_imports;

  /// No description provided for @no_recent_imports.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có nhập dữ liệu gần đây'**
  String get no_recent_imports;

  /// No description provided for @invalid_format.
  ///
  /// In vi, this message translates to:
  /// **'Định dạng tệp không hợp lệ.'**
  String get invalid_format;

  /// No description provided for @import_success.
  ///
  /// In vi, this message translates to:
  /// **'Nhập thành công!'**
  String get import_success;

  /// No description provided for @import_success_description.
  ///
  /// In vi, this message translates to:
  /// **'Dữ liệu của bạn đã được nhập thành công.'**
  String get import_success_description;

  /// No description provided for @file_format_template.
  ///
  /// In vi, this message translates to:
  /// **'Mẫu định dạng tệp'**
  String get file_format_template;

  /// No description provided for @download_sample_file.
  ///
  /// In vi, this message translates to:
  /// **'Tải xuống tệp mẫu {format}'**
  String download_sample_file(Object format);

  /// No description provided for @card.
  ///
  /// In vi, this message translates to:
  /// **'Thẻ'**
  String get card;

  /// No description provided for @reminder_title.
  ///
  /// In vi, this message translates to:
  /// **'Nhắc nhở chi tiêu hàng ngày'**
  String get reminder_title;

  /// No description provided for @reminder_body.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã ghi chép chi tiêu hôm nay chưa? 💸'**
  String get reminder_body;

  /// No description provided for @defaultTransactionTitle.
  ///
  /// In vi, this message translates to:
  /// **'Giao dịch mới'**
  String get defaultTransactionTitle;

  /// No description provided for @invoice_analysis.
  ///
  /// In vi, this message translates to:
  /// **'Đang phân tích hóa đơn ...'**
  String get invoice_analysis;

  /// No description provided for @mapbox_error.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi tải bản đồ. Vui lòng kiểm tra cấu hình token Mapbox của bạn.'**
  String get mapbox_error;

  /// No description provided for @location.
  ///
  /// In vi, this message translates to:
  /// **'Vị trí'**
  String get location;

  /// No description provided for @current_location.
  ///
  /// In vi, this message translates to:
  /// **'Vị trí hiện tại'**
  String get current_location;

  /// No description provided for @select_location.
  ///
  /// In vi, this message translates to:
  /// **'Chọn vị trí'**
  String get select_location;

  /// No description provided for @no_location_selected.
  ///
  /// In vi, this message translates to:
  /// **'Chưa chọn vị trí'**
  String get no_location_selected;

  /// No description provided for @search_location.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm vị trí...'**
  String get search_location;

  /// No description provided for @tap_to_change_location.
  ///
  /// In vi, this message translates to:
  /// **'Chạm để thay đổi vị trí'**
  String get tap_to_change_location;

  /// No description provided for @search_results.
  ///
  /// In vi, this message translates to:
  /// **'Kết quả tìm kiếm'**
  String get search_results;

  /// No description provided for @no_location_found.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy vị trí'**
  String get no_location_found;

  /// No description provided for @recent_locations.
  ///
  /// In vi, this message translates to:
  /// **'Vị trí gần đây'**
  String get recent_locations;

  /// No description provided for @location_access_error.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi truy cập vị trí'**
  String get location_access_error;

  /// No description provided for @location_permission_denied.
  ///
  /// In vi, this message translates to:
  /// **'Quyền truy cập vị trí bị từ chối.'**
  String get location_permission_denied;

  /// No description provided for @location_permission_denied_description.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng bật quyền truy cập vị trí trong cài đặt.'**
  String get location_permission_denied_description;

  /// No description provided for @notification_permission_denied.
  ///
  /// In vi, this message translates to:
  /// **'Nhận thông báo bị từ chối.'**
  String get notification_permission_denied;

  /// No description provided for @notification_permission_denied_description.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng bật thông báo trong cài đặt để nhận nhắc nhở.'**
  String get notification_permission_denied_description;

  /// No description provided for @voice_input_error.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi nhập giọng nói. Vui lòng thử lại.'**
  String get voice_input_error;

  /// No description provided for @voice_input_not_recognized.
  ///
  /// In vi, this message translates to:
  /// **'Không nhận diện được giọng nói. Vui lòng thử lại.'**
  String get voice_input_not_recognized;

  /// No description provided for @voice_input_permission_denied.
  ///
  /// In vi, this message translates to:
  /// **'Quyền nhập giọng nói bị từ chối. Vui lòng bật quyền truy cập micro trong cài đặt.'**
  String get voice_input_permission_denied;

  /// No description provided for @error_ai_request.
  ///
  /// In vi, this message translates to:
  /// **'AI không thể nhận dạng yêu cầu này. Hãy thử nói rõ hơn.'**
  String get error_ai_request;
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
