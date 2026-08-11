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

  /// App name
  ///
  /// In vi, this message translates to:
  /// **'SpendFlow'**
  String get app_name;

  /// Ok
  ///
  /// In vi, this message translates to:
  /// **'Đồng ý'**
  String get ok;

  /// Cancel
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get cancel;

  /// Skip
  ///
  /// In vi, this message translates to:
  /// **'Bỏ qua'**
  String get skip;

  /// Next
  ///
  /// In vi, this message translates to:
  /// **'Tiếp theo'**
  String get next;

  /// Confirm
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận'**
  String get confirm;

  /// Save
  ///
  /// In vi, this message translates to:
  /// **'Lưu'**
  String get save;

  /// Edit
  ///
  /// In vi, this message translates to:
  /// **'Sửa'**
  String get edit;

  /// Delete
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get delete;

  /// Yes
  ///
  /// In vi, this message translates to:
  /// **'Có'**
  String get yes;

  /// No
  ///
  /// In vi, this message translates to:
  /// **'Không'**
  String get no;

  /// Done
  ///
  /// In vi, this message translates to:
  /// **'Hoàn tất'**
  String get done;

  /// Close
  ///
  /// In vi, this message translates to:
  /// **'Đóng'**
  String get close;

  /// Back
  ///
  /// In vi, this message translates to:
  /// **'Quay lại'**
  String get back;

  /// Start
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu'**
  String get start;

  /// Continueaction
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục'**
  String get continueAction;

  /// View all
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả'**
  String get view_all;

  /// See all
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả'**
  String get see_all;

  /// Amount
  ///
  /// In vi, this message translates to:
  /// **'Số tiền'**
  String get amount;

  /// Name
  ///
  /// In vi, this message translates to:
  /// **'Tên giao dịch'**
  String get name;

  /// Date
  ///
  /// In vi, this message translates to:
  /// **'Ngày'**
  String get date;

  /// Month
  ///
  /// In vi, this message translates to:
  /// **'Tháng'**
  String get month;

  /// Life time
  ///
  /// In vi, this message translates to:
  /// **'Trọn đời'**
  String get life_time;

  /// Today
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay'**
  String get today;

  /// Other
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get other;

  /// Home
  ///
  /// In vi, this message translates to:
  /// **'Trang chủ'**
  String get home;

  /// Reports
  ///
  /// In vi, this message translates to:
  /// **'Báo cáo'**
  String get reports;

  /// Budgets
  ///
  /// In vi, this message translates to:
  /// **'Ngân sách'**
  String get budgets;

  /// All
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get all;

  /// Error
  ///
  /// In vi, this message translates to:
  /// **'Lỗi'**
  String get error;

  /// User
  ///
  /// In vi, this message translates to:
  /// **'Người dùng'**
  String get user;

  /// Success
  ///
  /// In vi, this message translates to:
  /// **'Thành công'**
  String get success;

  /// Loading
  ///
  /// In vi, this message translates to:
  /// **'Đang tải...'**
  String get loading;

  /// Onboard step1 title
  ///
  /// In vi, this message translates to:
  /// **'Ghi chép trong nháy mắt'**
  String get onboard_step1_title;

  /// Onboard step1 message
  ///
  /// In vi, this message translates to:
  /// **'Tự động xác định địa điểm chi tiêu giúp bạn ghi chép nhanh hơn bao giờ hết. Không còn phải nhớ mình đã tiêu gì ở đâu.'**
  String get onboard_step1_message;

  /// Onboard step2 title
  ///
  /// In vi, this message translates to:
  /// **'Làm chủ ví tiền của bạn'**
  String get onboard_step2_title;

  /// Onboard step2 message
  ///
  /// In vi, this message translates to:
  /// **'Thiết lập hạn mức chi tiêu cho từng danh mục. Chúng tôi sẽ giúp bạn luôn đi đúng lộ trình tài chính.'**
  String get onboard_step2_message;

  /// Onboard step3 title
  ///
  /// In vi, this message translates to:
  /// **'Xây dựng thói quen tốt'**
  String get onboard_step3_title;

  /// Onboard step3 message
  ///
  /// In vi, this message translates to:
  /// **'Nhận thông báo nhắc nhở vào cuối ngày để không bỏ lỡ bất kỳ giao dịch nào. Kỷ luật là chìa khóa của sự thịnh vượng.'**
  String get onboard_step3_message;

  /// Create first wallet
  ///
  /// In vi, this message translates to:
  /// **'Tạo ví đầu tiên của bạn'**
  String get create_first_wallet;

  /// Welcome create wallet
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng đến với Spend Flow!\nHãy tạo ví đầu tiên của bạn để bắt đầu.'**
  String get welcome_create_wallet;

  /// Enter wallet name
  ///
  /// In vi, this message translates to:
  /// **'Nhập tên ví'**
  String get enter_wallet_name;

  /// Eg my wallet
  ///
  /// In vi, this message translates to:
  /// **'ví dụ: Ví của tôi, Tiền mặt, Thẻ tín dụng'**
  String get eg_my_wallet;

  /// Currency unit
  ///
  /// In vi, this message translates to:
  /// **'Đơn vị tiền tệ'**
  String get currency_unit;

  /// Create wallet
  ///
  /// In vi, this message translates to:
  /// **'Tạo ví'**
  String get create_wallet;

  /// Please enter wallet name
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập tên ví.'**
  String get please_enter_wallet_name;

  /// Add wallet
  ///
  /// In vi, this message translates to:
  /// **'Thêm ví mới'**
  String get add_wallet;

  /// Wallet name
  ///
  /// In vi, this message translates to:
  /// **'Tên ví'**
  String get wallet_name;

  /// Add wallet description
  ///
  /// In vi, this message translates to:
  /// **'Thêm nhiều ví để quản lí và theo dõi tài chính hiệu quả hơn.'**
  String get add_wallet_description;

  /// Cannot delete last wallet
  ///
  /// In vi, this message translates to:
  /// **'Bạn không thể xóa ví duy nhất.'**
  String get cannot_delete_last_wallet;

  /// Delete wallet
  ///
  /// In vi, this message translates to:
  /// **'Xóa ví'**
  String get delete_wallet;

  /// Delete wallet confirmation
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa ví \'{walletName}\' không? Hành động này không thể hoàn tác.'**
  String delete_wallet_confirmation(String walletName);

  /// In use
  ///
  /// In vi, this message translates to:
  /// **'Đang sử dụng'**
  String get in_use;

  /// Incomplete details
  ///
  /// In vi, this message translates to:
  /// **'Thiếu dữ liệu'**
  String get incomplete_details;

  /// Please fill required fields
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng điền vào các trường bắt buộc sau:'**
  String get please_fill_required_fields;

  /// Select wallet
  ///
  /// In vi, this message translates to:
  /// **'Chọn ví'**
  String get select_wallet;

  /// Please create wallet first
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng tạo ví trước khi thêm giao dịch.'**
  String get please_create_wallet_first;

  /// Create now
  ///
  /// In vi, this message translates to:
  /// **'Tạo ngay'**
  String get create_now;

  /// No wallets yet
  ///
  /// In vi, this message translates to:
  /// **'Chưa có ví nào'**
  String get no_wallets_yet;

  /// Login
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get login;

  /// Register
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký'**
  String get register;

  /// Logout
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất'**
  String get logout;

  /// Email
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get email;

  /// Password
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get password;

  /// New password
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu mới'**
  String get new_password;

  /// Enter email
  ///
  /// In vi, this message translates to:
  /// **'Nhập email của bạn'**
  String get enter_email;

  /// Enter your password
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu của bạn'**
  String get enter_your_password;

  /// Confirm password
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu'**
  String get confirm_password;

  /// Confirm your password
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu'**
  String get confirm_your_password;

  /// Passwords match
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu trùng khớp.'**
  String get passwords_match;

  /// Passwords mismatch
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu không trùng khớp.'**
  String get passwords_mismatch;

  /// Forgot password
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu?'**
  String get forgot_password;

  /// Description forgot password
  ///
  /// In vi, this message translates to:
  /// **'Nhập email được liên kết với tài khoản của bạn để đặt lại mật khẩu.'**
  String get description_forgot_password;

  /// Send otp
  ///
  /// In vi, this message translates to:
  /// **'Gửi OTP'**
  String get send_otp;

  /// Enter otp
  ///
  /// In vi, this message translates to:
  /// **'Nhập OTP'**
  String get enter_otp;

  /// Resend
  ///
  /// In vi, this message translates to:
  /// **'Gửi lại'**
  String get resend;

  /// Verify
  ///
  /// In vi, this message translates to:
  /// **'Xác thực'**
  String get verify;

  /// No otp
  ///
  /// In vi, this message translates to:
  /// **'Không nhận được mã?'**
  String get no_otp;

  /// Verify otp
  ///
  /// In vi, this message translates to:
  /// **'Xác thực OTP'**
  String get verify_otp;

  /// We sent otp
  ///
  /// In vi, this message translates to:
  /// **'Mã xác thực (OTP) đã được gửi đến email của bạn. Vui lòng kiểm tra hộp thư đến (hoặc hòm thư Spam/Quảng cáo) để xem mã.'**
  String get we_sent_otp;

  /// Dont receive otp
  ///
  /// In vi, this message translates to:
  /// **'Chưa nhận được OTP?'**
  String get dont_receive_otp;

  /// Plese enter valid otp
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập mã OTP hợp lệ.'**
  String get plese_enter_valid_otp;

  /// Otp resent
  ///
  /// In vi, this message translates to:
  /// **'Mã OTP đã được gửi lại thành công.'**
  String get otp_resent;

  /// Register successful
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký thành công!'**
  String get register_successful;

  /// Register successful description
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản của bạn đã được tạo thành công. Bây giờ bạn có thể đăng nhập bằng thông tin đăng nhập của mình.'**
  String get register_successful_description;

  /// No account
  ///
  /// In vi, this message translates to:
  /// **'Chưa có tài khoản?'**
  String get no_account;

  /// Have account
  ///
  /// In vi, this message translates to:
  /// **'Đã có tài khoản?'**
  String get have_account;

  /// Login error
  ///
  /// In vi, this message translates to:
  /// **'Email hoặc mật khẩu không hợp lệ'**
  String get login_error;

  /// Register error
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký thất bại'**
  String get register_error;

  /// Create account
  ///
  /// In vi, this message translates to:
  /// **'Đăng kí tài khoản'**
  String get create_account;

  /// Create password
  ///
  /// In vi, this message translates to:
  /// **'Tạo mật khẩu mới'**
  String get create_password;

  /// Create new password
  ///
  /// In vi, this message translates to:
  /// **'Gần xong rồi! Tạo mật khẩu mới của bạn.'**
  String get create_new_password;

  /// Or continue with
  ///
  /// In vi, this message translates to:
  /// **'Hoặc đăng nhập với'**
  String get or_continue_with;

  /// Sign in with
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập với {provider}'**
  String sign_in_with(String provider);

  /// Check your mail
  ///
  /// In vi, this message translates to:
  /// **'Kiểm tra email của bạn'**
  String get check_your_mail;

  /// We have sent mail
  ///
  /// In vi, this message translates to:
  /// **'Chúng tôi đã gửi một email đến:'**
  String get we_have_sent_mail;

  /// Please check your mail to verify account
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng kiểm tra email của bạn để xác thực tài khoản trước khi đăng nhập.'**
  String get please_check_your_mail_to_verify_account;

  /// Register failed
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký thất bại'**
  String get register_failed;

  /// Please fill all fields
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng điền vào tất cả các trường.'**
  String get please_fill_all_fields;

  /// Please enter email and password
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập cả email và mật khẩu.'**
  String get please_enter_email_and_password;

  /// Incorrect email or password
  ///
  /// In vi, this message translates to:
  /// **'Email hoặc mật khẩu không đúng.'**
  String get incorrect_email_or_password;

  /// Invalid email format
  ///
  /// In vi, this message translates to:
  /// **'Định dạng email không hợp lệ.'**
  String get invalid_email_format;

  /// This account has been disabled
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản này đã bị vô hiệu hóa.'**
  String get this_account_has_been_disabled;

  /// Too many requests please try later
  ///
  /// In vi, this message translates to:
  /// **'Quá nhiều yêu cầu. Vui lòng thử lại sau.'**
  String get too_many_requests_please_try_later;

  /// Email not verified
  ///
  /// In vi, this message translates to:
  /// **'Email chưa được xác thực'**
  String get email_not_verified;

  /// Please verify your email to continue
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng xác thực email của bạn để tiếp tục.'**
  String get please_verify_your_email_to_continue;

  /// Are you sure logout
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn đăng xuất không?'**
  String get are_you_sure_logout;

  /// Have error occurred
  ///
  /// In vi, this message translates to:
  /// **'Đã xảy ra lỗi. Vui lòng thử lại.'**
  String get have_error_occurred;

  /// User not found
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy tài khoản với email này.'**
  String get user_not_found;

  /// Enter otp reset password
  ///
  /// In vi, this message translates to:
  /// **'Chúng tôi vừa gửi mã OTP vào email của bạn. Hãy nhập mã OTP để đặt lại mật khẩu.'**
  String get enter_otp_reset_password;

  /// Not time yet to resend otp
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chờ một lát để gửi lại mã OTP.'**
  String get not_time_yet_to_resend_otp;

  /// Reset password successful
  ///
  /// In vi, this message translates to:
  /// **'Đặt lại mật khẩu thành công'**
  String get reset_password_successful;

  /// Reset password successful description
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu của bạn đã được đặt lại thành công. Bây giờ bạn có thể đăng nhập bằng mật khẩu mới.'**
  String get reset_password_successful_description;

  /// Welcome back
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng trở lại'**
  String get welcome_back;

  /// Back login
  ///
  /// In vi, this message translates to:
  /// **'Quay lại đăng nhập'**
  String get back_login;

  /// Description create account
  ///
  /// In vi, this message translates to:
  /// **'Kiểm soát tài chính của bạn ngay hôm nay'**
  String get description_create_account;

  /// Label weak
  ///
  /// In vi, this message translates to:
  /// **'Yếu'**
  String get label_weak;

  /// Label fair
  ///
  /// In vi, this message translates to:
  /// **'Trung bình'**
  String get label_fair;

  /// Label good
  ///
  /// In vi, this message translates to:
  /// **'Tốt'**
  String get label_good;

  /// Label strong
  ///
  /// In vi, this message translates to:
  /// **'Mạnh'**
  String get label_strong;

  /// Low pass
  ///
  /// In vi, this message translates to:
  /// **'Tối thiểu 8 ký tự, bao gồm chữ số và ký tự đặc biệt.'**
  String get low_pass;

  /// Weak pass
  ///
  /// In vi, this message translates to:
  /// **'Quá ngắn. Vui lòng nhập thêm ký tự.'**
  String get weak_pass;

  /// Fair pass
  ///
  /// In vi, this message translates to:
  /// **'Khá hơn rồi. Hãy thêm số và ký tự đặt biệt.'**
  String get fair_pass;

  /// Good pass char
  ///
  /// In vi, this message translates to:
  /// **'Sắp hoàn hảo! Hãy thêm ký tự đặc biệt để tăng bảo mật.'**
  String get good_pass_char;

  /// Good pass num
  ///
  /// In vi, this message translates to:
  /// **'Sắp hoàn hảo! Hãy thêm số để tăng bảo mật.'**
  String get good_pass_num;

  /// Good pass special
  ///
  /// In vi, this message translates to:
  /// **'Sắp hoàn hảo! Hãy thêm ký tự bất kì để tăng bảo mật.'**
  String get good_pass_special;

  /// Strong pass
  ///
  /// In vi, this message translates to:
  /// **'Tuyệt vời! Mật khẩu của bạn đã an toàn.'**
  String get strong_pass;

  /// Password reset email sent
  ///
  /// In vi, this message translates to:
  /// **'Chúng tôi đã gửi một liên kết đặt lại mật khẩu đến email của bạn.'**
  String get password_reset_email_sent;

  /// Forgot password description
  ///
  /// In vi, this message translates to:
  /// **'Nhập email được liên kết với tài khoản của bạn để đặt lại mật khẩu.'**
  String get forgot_password_description;

  /// Send email reset
  ///
  /// In vi, this message translates to:
  /// **'Gửi email đặt lại'**
  String get send_email_reset;

  /// Password weak password
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu quá yếu.'**
  String get password_weak_password;

  /// Please edit fields
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chỉnh sửa các trường sau để tiếp tục:'**
  String get please_edit_fields;

  /// Something went wrong
  ///
  /// In vi, this message translates to:
  /// **'Đã xảy ra lỗi. Vui lòng thử lại.'**
  String get something_went_wrong;

  /// Email already in use
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ email đã được sử dụng bởi tài khoản khác.'**
  String get email_already_in_use;

  /// Invalid email
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ email không hợp lệ.'**
  String get invalid_email;

  /// Operation not allowed
  ///
  /// In vi, this message translates to:
  /// **'Không cho phép thực hiện. Vui lòng liên hệ hỗ trợ.'**
  String get operation_not_allowed;

  /// Network error
  ///
  /// In vi, this message translates to:
  /// **'Lỗi kết nối mạng, vui lòng kiểm tra lại.'**
  String get network_error;

  /// Reset password
  ///
  /// In vi, this message translates to:
  /// **'Đặt lại mật khẩu'**
  String get reset_password;

  /// Email not received
  ///
  /// In vi, this message translates to:
  /// **'Không nhận được email?'**
  String get email_not_received;

  /// Verification email sent
  ///
  /// In vi, this message translates to:
  /// **'Đã gửi email xác thực'**
  String get verification_email_sent;

  /// Good morning
  ///
  /// In vi, this message translates to:
  /// **'Chào buổi sáng'**
  String get good_morning;

  /// Good afternoon
  ///
  /// In vi, this message translates to:
  /// **'Chào buổi chiều'**
  String get good_afternoon;

  /// Good evening
  ///
  /// In vi, this message translates to:
  /// **'Chào buổi tối'**
  String get good_evening;

  /// Hello
  ///
  /// In vi, this message translates to:
  /// **'Xin chào'**
  String get hello;

  /// Income
  ///
  /// In vi, this message translates to:
  /// **'Thu nhập'**
  String get income;

  /// Expenses
  ///
  /// In vi, this message translates to:
  /// **'Chi tiêu'**
  String get expenses;

  /// Balance
  ///
  /// In vi, this message translates to:
  /// **'Còn lại'**
  String get balance;

  /// Total balance
  ///
  /// In vi, this message translates to:
  /// **'Tổng số dư'**
  String get total_balance;

  /// Spending this month
  ///
  /// In vi, this message translates to:
  /// **'Chi tiêu trong tháng này'**
  String get spending_this_month;

  /// Total spent
  ///
  /// In vi, this message translates to:
  /// **'Tổng chi tiêu'**
  String get total_spent;

  /// Recent transactions
  ///
  /// In vi, this message translates to:
  /// **'Giao dịch gần đây'**
  String get recent_transactions;

  /// Add transaction
  ///
  /// In vi, this message translates to:
  /// **'Thêm giao dịch'**
  String get add_transaction;

  /// No transactions
  ///
  /// In vi, this message translates to:
  /// **'Không có dữ liệu'**
  String get no_transactions;

  /// Enter transaction name
  ///
  /// In vi, this message translates to:
  /// **'Nhập tên giao dịch'**
  String get enter_transaction_name;

  /// Suggested category
  ///
  /// In vi, this message translates to:
  /// **'Danh mục gợi ý'**
  String get suggested_category;

  /// Category
  ///
  /// In vi, this message translates to:
  /// **'Danh mục'**
  String get category;

  /// Categories
  ///
  /// In vi, this message translates to:
  /// **'Danh mục'**
  String get categories;

  /// Select category
  ///
  /// In vi, this message translates to:
  /// **'Chọn danh mục'**
  String get select_category;

  /// Edit category
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa danh mục'**
  String get edit_category;

  /// Are you sure delete category
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa danh mục {categoryName}?'**
  String are_you_sure_delete_category(String categoryName);

  /// System category
  ///
  /// In vi, this message translates to:
  /// **'Danh mục hệ thống không thể xóa.'**
  String get system_category;

  /// System category description
  ///
  /// In vi, this message translates to:
  /// **'Bạn không thể chỉnh sửa hoặc xóa danh mục mặc định này.'**
  String get system_category_description;

  /// Category food
  ///
  /// In vi, this message translates to:
  /// **'Ăn uống'**
  String get category_food;

  /// Category transport
  ///
  /// In vi, this message translates to:
  /// **'Di chuyển'**
  String get category_transport;

  /// Category salary
  ///
  /// In vi, this message translates to:
  /// **'Lương'**
  String get category_salary;

  /// Category shopping
  ///
  /// In vi, this message translates to:
  /// **'Mua sắm'**
  String get category_shopping;

  /// Category game
  ///
  /// In vi, this message translates to:
  /// **'Trò chơi'**
  String get category_game;

  /// Category house
  ///
  /// In vi, this message translates to:
  /// **'Nhà cửa'**
  String get category_house;

  /// Category gift
  ///
  /// In vi, this message translates to:
  /// **'Quà tặng'**
  String get category_gift;

  /// Category health
  ///
  /// In vi, this message translates to:
  /// **'Sức khỏe'**
  String get category_health;

  /// Category entertainment
  ///
  /// In vi, this message translates to:
  /// **'Giải trí'**
  String get category_entertainment;

  /// Category bill
  ///
  /// In vi, this message translates to:
  /// **'Hóa đơn'**
  String get category_bill;

  /// Category insurance
  ///
  /// In vi, this message translates to:
  /// **'Bảo hiểm'**
  String get category_insurance;

  /// Category education
  ///
  /// In vi, this message translates to:
  /// **'Giáo dục'**
  String get category_education;

  /// Category pet
  ///
  /// In vi, this message translates to:
  /// **'Thú cưng'**
  String get category_pet;

  /// Category travel
  ///
  /// In vi, this message translates to:
  /// **'Du lịch'**
  String get category_travel;

  /// Category savings
  ///
  /// In vi, this message translates to:
  /// **'Tiết kiệm'**
  String get category_savings;

  /// Category phone
  ///
  /// In vi, this message translates to:
  /// **'Điện thoại'**
  String get category_phone;

  /// Category internet
  ///
  /// In vi, this message translates to:
  /// **'Internet'**
  String get category_internet;

  /// Category water
  ///
  /// In vi, this message translates to:
  /// **'Nước'**
  String get category_water;

  /// Category electricity
  ///
  /// In vi, this message translates to:
  /// **'Điện'**
  String get category_electricity;

  /// Category gas
  ///
  /// In vi, this message translates to:
  /// **'Gas'**
  String get category_gas;

  /// Category cleaning
  ///
  /// In vi, this message translates to:
  /// **'Dọn dẹp'**
  String get category_cleaning;

  /// Category beauty
  ///
  /// In vi, this message translates to:
  /// **'Làm đẹp'**
  String get category_beauty;

  /// Category baby
  ///
  /// In vi, this message translates to:
  /// **'Em bé'**
  String get category_baby;

  /// Category sport
  ///
  /// In vi, this message translates to:
  /// **'Thể thao'**
  String get category_sport;

  /// Category music
  ///
  /// In vi, this message translates to:
  /// **'Âm nhạc'**
  String get category_music;

  /// Category repair
  ///
  /// In vi, this message translates to:
  /// **'Sửa chữa'**
  String get category_repair;

  /// Category tax
  ///
  /// In vi, this message translates to:
  /// **'Thuế'**
  String get category_tax;

  /// Note
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú (tùy chọn)'**
  String get note;

  /// Enter note
  ///
  /// In vi, this message translates to:
  /// **'Nhập ghi chú'**
  String get enter_note;

  /// Add income
  ///
  /// In vi, this message translates to:
  /// **'Thêm thu nhập'**
  String get add_income;

  /// Add expense
  ///
  /// In vi, this message translates to:
  /// **'Thêm chi tiêu'**
  String get add_expense;

  /// Search category
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm danh mục'**
  String get search_category;

  /// No category found
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy danh mục'**
  String get no_category_found;

  /// Most used
  ///
  /// In vi, this message translates to:
  /// **'Sử dụng nhiều nhất'**
  String get most_used;

  /// Category suggestions
  ///
  /// In vi, this message translates to:
  /// **'Danh mục gợi ý'**
  String get category_suggestions;

  /// All categories
  ///
  /// In vi, this message translates to:
  /// **'Tất cả danh mục'**
  String get all_categories;

  /// New category
  ///
  /// In vi, this message translates to:
  /// **'Danh mục mới'**
  String get new_category;

  /// Category name
  ///
  /// In vi, this message translates to:
  /// **'Tên danh mục'**
  String get category_name;

  /// Category color
  ///
  /// In vi, this message translates to:
  /// **'Màu danh mục'**
  String get category_color;

  /// Category icon
  ///
  /// In vi, this message translates to:
  /// **'Biểu tượng danh mục'**
  String get category_icon;

  /// Vs last month
  ///
  /// In vi, this message translates to:
  /// **'so với Tháng trước'**
  String get vs_last_month;

  /// Transaction
  ///
  /// In vi, this message translates to:
  /// **'Giao dịch'**
  String get transaction;

  /// Delete transaction
  ///
  /// In vi, this message translates to:
  /// **'Xóa giao dịch'**
  String get delete_transaction;

  /// Delete transaction confirmation
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa giao dịch này không?'**
  String get delete_transaction_confirmation;

  /// Transaction details
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết giao dịch'**
  String get transaction_details;

  /// Spending trend
  ///
  /// In vi, this message translates to:
  /// **'Xu hướng chi tiêu'**
  String get spending_trend;

  /// Spending last 7 days
  ///
  /// In vi, this message translates to:
  /// **'Chi tiêu trong 7 ngày qua'**
  String get spending_last_7_days;

  /// Note 2
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú'**
  String get note_2;

  /// Scan receipt
  ///
  /// In vi, this message translates to:
  /// **'Quét hóa đơn'**
  String get scan_receipt;

  /// Add via voice
  ///
  /// In vi, this message translates to:
  /// **'Thêm bằng giọng nói'**
  String get add_via_voice;

  /// Add manually
  ///
  /// In vi, this message translates to:
  /// **'Thêm thủ công'**
  String get add_manually;

  /// Limit reached
  ///
  /// In vi, this message translates to:
  /// **'Đã đạt giới hạn'**
  String get limit_reached;

  /// Limit reached description
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã sử dụng {featureName} {limit} lần hôm nay.\nVui lòng quay lại vào ngày mai hoặc nâng cấp lên Premium.'**
  String limit_reached_description(String featureName, String limit);

  /// Align receipt
  ///
  /// In vi, this message translates to:
  /// **'Căn chỉnh hóa đơn của bạn vào khung'**
  String get align_receipt;

  /// Listening
  ///
  /// In vi, this message translates to:
  /// **'Đang nghe...'**
  String get listening;

  /// Voice example
  ///
  /// In vi, this message translates to:
  /// **'Ví dụ: Tôi đã chi 50 đô la cho thực phẩm'**
  String get voice_example;

  /// Tap to stop
  ///
  /// In vi, this message translates to:
  /// **'Chạm để dừng'**
  String get tap_to_stop;

  /// Tap to listen
  ///
  /// In vi, this message translates to:
  /// **'Chạm để nghe'**
  String get tap_to_listen;

  /// Yesterday
  ///
  /// In vi, this message translates to:
  /// **'Hôm qua'**
  String get yesterday;

  /// Your monthly budget
  ///
  /// In vi, this message translates to:
  /// **'Ngân sách hàng tháng của bạn'**
  String get your_monthly_budget;

  /// Spent
  ///
  /// In vi, this message translates to:
  /// **'Đã chi '**
  String get spent;

  /// Out of
  ///
  /// In vi, this message translates to:
  /// **' trong tổng '**
  String get out_of;

  /// Left to spend
  ///
  /// In vi, this message translates to:
  /// **'còn lại để chi tiêu'**
  String get left_to_spend;

  /// Add budget
  ///
  /// In vi, this message translates to:
  /// **'Thêm ngân sách'**
  String get add_budget;

  /// No budgets yet
  ///
  /// In vi, this message translates to:
  /// **'Chưa có ngân sách nào'**
  String get no_budgets_yet;

  /// Create budget description
  ///
  /// In vi, this message translates to:
  /// **'Nhấn + để tạo giới hạn chi tiêu'**
  String get create_budget_description;

  /// Edit budget
  ///
  /// In vi, this message translates to:
  /// **'Sửa ngân sách'**
  String get edit_budget;

  /// Are you sure delete budget
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc muốn xóa ngân sách \n {budgetName}? \n'**
  String are_you_sure_delete_budget(String budgetName);

  /// Delete budget
  ///
  /// In vi, this message translates to:
  /// **'Xóa ngân sách'**
  String get delete_budget;

  /// Settings
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get settings;

  /// Settings description
  ///
  /// In vi, this message translates to:
  /// **'Giữ dữ liệu tài chính luôn đồng bộ trên tất cả thiết bị của bạn'**
  String get settings_description;

  /// Sign in now
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập ngay'**
  String get sign_in_now;

  /// Get started
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu ngay'**
  String get get_started;

  /// Welcome
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng !'**
  String get welcome;

  /// General
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt chung'**
  String get general;

  /// Security
  ///
  /// In vi, this message translates to:
  /// **'Bảo mật'**
  String get security;

  /// Privacy and security
  ///
  /// In vi, this message translates to:
  /// **'Quyền riêng tư & Bảo mật'**
  String get privacy_and_security;

  /// Support
  ///
  /// In vi, this message translates to:
  /// **'Hỗ trợ'**
  String get support;

  /// Profile
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ'**
  String get profile;

  /// Language
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ'**
  String get language;

  /// Dark mode
  ///
  /// In vi, this message translates to:
  /// **'Chế độ tối'**
  String get dark_mode;

  /// Notifications
  ///
  /// In vi, this message translates to:
  /// **'Thông báo'**
  String get notifications;

  /// Appearance
  ///
  /// In vi, this message translates to:
  /// **'Giao diện'**
  String get appearance;

  /// Currency
  ///
  /// In vi, this message translates to:
  /// **'Tiền tệ'**
  String get currency;

  /// About
  ///
  /// In vi, this message translates to:
  /// **'Giới thiệu'**
  String get about;

  /// Terms of service
  ///
  /// In vi, this message translates to:
  /// **'Điều khoản dịch vụ'**
  String get terms_of_service;

  /// Privacy policy
  ///
  /// In vi, this message translates to:
  /// **'Chính sách quyền riêng tư'**
  String get privacy_policy;

  /// Version
  ///
  /// In vi, this message translates to:
  /// **'Phiên bản'**
  String get version;

  /// Edit profile
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa hồ sơ'**
  String get edit_profile;

  /// Full name
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên'**
  String get full_name;

  /// Enter full name
  ///
  /// In vi, this message translates to:
  /// **'Nhập họ và tên'**
  String get enter_full_name;

  /// Email address
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ email'**
  String get email_address;

  /// Enter email address
  ///
  /// In vi, this message translates to:
  /// **'Nhập địa chỉ email'**
  String get enter_email_address;

  /// Phone number
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get phone_number;

  /// Enter phone number
  ///
  /// In vi, this message translates to:
  /// **'Nhập số điện thoại'**
  String get enter_phone_number;

  /// Day of birth
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh'**
  String get day_of_birth;

  /// Select day of birth
  ///
  /// In vi, this message translates to:
  /// **'Chọn ngày sinh'**
  String get select_day_of_birth;

  /// Save changes
  ///
  /// In vi, this message translates to:
  /// **'Lưu thay đổi'**
  String get save_changes;

  /// Profile updated success
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật hồ sơ thành công!'**
  String get profile_updated_success;

  /// Error updating profile
  ///
  /// In vi, this message translates to:
  /// **'Lỗi khi cập nhật hồ sơ.'**
  String get error_updating_profile;

  /// Error uploading avatar
  ///
  /// In vi, this message translates to:
  /// **'Lỗi khi tải lên ảnh đại diện.'**
  String get error_uploading_avatar;

  /// Require premium to edit avatar
  ///
  /// In vi, this message translates to:
  /// **'Bạn cần nâng cấp lên Premium hoặc xem quảng cáo để chỉnh sửa ảnh đại diện.'**
  String get require_premium_to_edit_avatar;

  /// Edit avatar
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa ảnh đại diện'**
  String get edit_avatar;

  /// Upgrade premium
  ///
  /// In vi, this message translates to:
  /// **'Nâng cấp lên Premium!'**
  String get upgrade_premium;

  /// Upgrade premium description
  ///
  /// In vi, this message translates to:
  /// **'Mở khóa các tính năng cao cấp và nâng cao trải nghiệm của bạn.'**
  String get upgrade_premium_description;

  /// Upgrade now
  ///
  /// In vi, this message translates to:
  /// **'Nâng cấp ngay'**
  String get upgrade_now;

  /// You are premium
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã sẵn sàng, người dùng Premium!'**
  String get you_are_premium;

  /// You are premium description
  ///
  /// In vi, this message translates to:
  /// **'Tận hưởng trải nghiệm nâng cao của bạn.'**
  String get you_are_premium_description;

  /// Import export data
  ///
  /// In vi, this message translates to:
  /// **'Nhập/Xuất dữ liệu'**
  String get import_export_data;

  /// Sync data
  ///
  /// In vi, this message translates to:
  /// **'Đồng bộ dữ liệu'**
  String get sync_data;

  /// Continue with
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục với {price}'**
  String continue_with(String price);

  /// Biometric authentication
  ///
  /// In vi, this message translates to:
  /// **'Xác thực sinh trắc học'**
  String get biometric_authentication;

  /// Password security
  ///
  /// In vi, this message translates to:
  /// **'Bảo mật mật mã'**
  String get password_security;

  /// Face id description
  ///
  /// In vi, this message translates to:
  /// **'Mở khóa ứng dụng chỉ bằng một ánh nhìn. Face ID mang lại sự tiện lợi và bảo mật bằng cách nhận diện khuôn mặt của bạn.'**
  String get face_id_description;

  /// Touch id description
  ///
  /// In vi, this message translates to:
  /// **'Mở khóa ứng dụng chỉ bằng một cú chạm. Touch ID giúp truy cập nhanh chóng và an toàn bằng vân tay của bạn.'**
  String get touch_id_description;

  /// Pass code description
  ///
  /// In vi, this message translates to:
  /// **'Thêm một lớp bảo vệ. Mã khóa đảm bảo chỉ bạn mới có thể truy cập dữ liệu tài chính, ngay cả khi thiết bị bị xâm phạm.'**
  String get pass_code_description;

  /// Passcode
  ///
  /// In vi, this message translates to:
  /// **'Passcode'**
  String get passcode;

  /// Change passcode
  ///
  /// In vi, this message translates to:
  /// **'Đổi passcode'**
  String get change_passcode;

  /// Old passcode
  ///
  /// In vi, this message translates to:
  /// **'Mã khóa cũ'**
  String get old_passcode;

  /// Enter old passcode
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã khóa cũ'**
  String get enter_old_passcode;

  /// New passcode
  ///
  /// In vi, this message translates to:
  /// **'Passcode mới'**
  String get new_passcode;

  /// Enter new passcode
  ///
  /// In vi, this message translates to:
  /// **'Nhập Passcode mới'**
  String get enter_new_passcode;

  /// Confirm new passcode
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận Passcode mới'**
  String get confirm_new_passcode;

  /// Enter confirm new passcode
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại Passcode mới'**
  String get enter_confirm_new_passcode;

  /// Turnoffpasscode
  ///
  /// In vi, this message translates to:
  /// **'Tắt Passcode'**
  String get turnOffPasscode;

  /// Createpasscode
  ///
  /// In vi, this message translates to:
  /// **'Tạo Passcode'**
  String get createPasscode;

  /// Changepasscode
  ///
  /// In vi, this message translates to:
  /// **'Đổi Passcode'**
  String get changePasscode;

  /// Removepasscode
  ///
  /// In vi, this message translates to:
  /// **'Xóa Passcode'**
  String get removePasscode;

  /// Updatepasscode
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật Passcode'**
  String get updatePasscode;

  /// Description create passcode
  ///
  /// In vi, this message translates to:
  /// **'Bảo vệ tài khoản của bạn bằng cách thường xuyên cập nhật Passcode 6 chữ số.'**
  String get description_create_passcode;

  /// Description remove passcode
  ///
  /// In vi, this message translates to:
  /// **'Nhập Passcode hiện tại của bạn để tắt bảo mật.'**
  String get description_remove_passcode;

  /// Currentpasscode
  ///
  /// In vi, this message translates to:
  /// **'Passcode hiện tại'**
  String get currentPasscode;

  /// Entercurrentpin
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã PIN hiện tại'**
  String get enterCurrentPin;

  /// Passcode turn off success
  ///
  /// In vi, this message translates to:
  /// **'Passcode đã được tắt thành công!'**
  String get passcode_turn_off_success;

  /// Passcode update success
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật Passcode thành công!'**
  String get passcode_update_success;

  /// Passcode create success
  ///
  /// In vi, this message translates to:
  /// **'Tạo Passcode thành công!'**
  String get passcode_create_success;

  /// Currentpasscodeincorrect
  ///
  /// In vi, this message translates to:
  /// **'Passcode hiện tại không đúng.'**
  String get currentPasscodeIncorrect;

  /// Errorsavingdata
  ///
  /// In vi, this message translates to:
  /// **'Lỗi khi lưu dữ liệu.'**
  String get errorSavingData;

  /// Newpasscodemustbe6digits
  ///
  /// In vi, this message translates to:
  /// **'Passcode mới phải có 6 chữ số.'**
  String get newPasscodeMustBe6Digits;

  /// Passcodesdonotmatch
  ///
  /// In vi, this message translates to:
  /// **'Passcode không khớp.'**
  String get passcodesDoNotMatch;

  /// Enter passcode
  ///
  /// In vi, this message translates to:
  /// **'Nhập Passcode'**
  String get enter_passcode;

  /// Incorrect passcode
  ///
  /// In vi, this message translates to:
  /// **'Passcode không đúng.'**
  String get incorrect_passcode;

  /// Face
  ///
  /// In vi, this message translates to:
  /// **'Face ID'**
  String get face;

  /// Fingerprint
  ///
  /// In vi, this message translates to:
  /// **'Vân tay'**
  String get fingerprint;

  /// Report locked
  ///
  /// In vi, this message translates to:
  /// **'Nội dung được khóa'**
  String get report_locked;

  /// Unlock
  ///
  /// In vi, this message translates to:
  /// **'Mở khóa'**
  String get unlock;

  /// Click to unlock
  ///
  /// In vi, this message translates to:
  /// **'Chạm để mở khóa'**
  String get click_to_unlock;

  /// Unlock untilimited access
  ///
  /// In vi, this message translates to:
  /// **'Mở khóa truy cập không giới hạn'**
  String get unlock_untilimited_access;

  /// Unlock untilimited access description
  ///
  /// In vi, this message translates to:
  /// **'Nâng cấp lên Premium để loại bỏ mọi giới hạn và truy cập các tính năng nâng cao.'**
  String get unlock_untilimited_access_description;

  /// Daily input cap reached
  ///
  /// In vi, this message translates to:
  /// **'Đã đạt giới hạn nhập hàng ngày'**
  String get daily_input_cap_reached;

  /// Daily input cap reached description
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã đạt giới hạn nhập hàng ngày cho việc quét hóa đơn và nhập giọng nói. Nâng cấp ngay để tiếp tục.'**
  String get daily_input_cap_reached_description;

  /// Feature comparison
  ///
  /// In vi, this message translates to:
  /// **'So sánh tính năng'**
  String get feature_comparison;

  /// Feature
  ///
  /// In vi, this message translates to:
  /// **'Tính năng'**
  String get feature;

  /// Free
  ///
  /// In vi, this message translates to:
  /// **'Miễn phí'**
  String get free;

  /// Premium
  ///
  /// In vi, this message translates to:
  /// **'Cao cấp'**
  String get premium;

  /// No ads
  ///
  /// In vi, this message translates to:
  /// **'Không quảng cáo'**
  String get no_ads;

  /// Transaction locking
  ///
  /// In vi, this message translates to:
  /// **'Khóa sổ giao dịch'**
  String get transaction_locking;

  /// Unlimited scans
  ///
  /// In vi, this message translates to:
  /// **'Quét hóa đơn không giới hạn'**
  String get unlimited_scans;

  /// Unlimited voice entries
  ///
  /// In vi, this message translates to:
  /// **'Nhập giọng nói không giới hạn'**
  String get unlimited_voice_entries;

  /// Day
  ///
  /// In vi, this message translates to:
  /// **'ngày'**
  String get day;

  /// Year
  ///
  /// In vi, this message translates to:
  /// **'Năm'**
  String get year;

  /// Subscription auto renews
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký tự động gia hạn'**
  String get subscription_auto_renews;

  /// Accept terms conditions
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký tự động gia hạn. Bằng cách tiếp tục, bạn đồng ý với Điều khoản Dịch vụ và Chính sách Quyền riêng tư của chúng tôi.'**
  String get accept_terms_conditions;

  /// Restore
  ///
  /// In vi, this message translates to:
  /// **'Khôi phục'**
  String get restore;

  /// Used up daily limit
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã sử dụng hết giới hạn nhập giọng nói trong ngày hôm nay. Xem quảng cáo để nhận thêm {value} lượt sử dụng hoặc nâng cấp lên Premium.'**
  String used_up_daily_limit(String value);

  /// Monthly plan
  ///
  /// In vi, this message translates to:
  /// **'Gói hàng tháng'**
  String get monthly_plan;

  /// Yearly plan
  ///
  /// In vi, this message translates to:
  /// **'Gói hàng năm'**
  String get yearly_plan;

  /// Lifetime plan
  ///
  /// In vi, this message translates to:
  /// **'Gói vĩnh viễn'**
  String get lifetime_plan;

  /// Pay once enjoy forever
  ///
  /// In vi, this message translates to:
  /// **'Trả một lần, sử dụng mãi mãi'**
  String get pay_once_enjoy_forever;

  /// Yearly discount
  ///
  /// In vi, this message translates to:
  /// **'Tiết kiệm 20% với gói hàng năm'**
  String get yearly_discount;

  /// Best value
  ///
  /// In vi, this message translates to:
  /// **'GIÁ TRỊ TỐT NHẤT'**
  String get best_value;

  /// Transaction cancelled
  ///
  /// In vi, this message translates to:
  /// **'Giao dịch đã bị hủy.'**
  String get transaction_cancelled;

  /// Purchase successful
  ///
  /// In vi, this message translates to:
  /// **'Mua thành công!'**
  String get purchase_successful;

  /// Purchase successful description
  ///
  /// In vi, this message translates to:
  /// **'Cảm ơn bạn đã nâng cấp lên Premium! Hãy tận hưởng trải nghiệm nâng cao của bạn.'**
  String get purchase_successful_description;

  /// Restore successful
  ///
  /// In vi, this message translates to:
  /// **'Khôi phục thành công!'**
  String get restore_successful;

  /// Restore successful description
  ///
  /// In vi, this message translates to:
  /// **'Mua hàng trước đó của bạn đã được khôi phục. Hãy tận hưởng các tính năng Premium của bạn!'**
  String get restore_successful_description;

  /// Nothing to restore
  ///
  /// In vi, this message translates to:
  /// **'Không có gì để khôi phục'**
  String get nothing_to_restore;

  /// Nothing to restore description
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy mua hàng trước đó để khôi phục.'**
  String get nothing_to_restore_description;

  /// Restore failed
  ///
  /// In vi, this message translates to:
  /// **'Khôi phục thất bại'**
  String get restore_failed;

  /// Restore failed description
  ///
  /// In vi, this message translates to:
  /// **'Đã xảy ra lỗi khi khôi phục mua hàng của bạn. Vui lòng thử lại.'**
  String get restore_failed_description;

  /// Purchase failed
  ///
  /// In vi, this message translates to:
  /// **'Mua hàng thất bại'**
  String get purchase_failed;

  /// Purchase failed description
  ///
  /// In vi, this message translates to:
  /// **'Đã xảy ra lỗi trong quá trình giao dịch. Vui lòng thử lại.'**
  String get purchase_failed_description;

  /// Purchase canceled
  ///
  /// In vi, this message translates to:
  /// **'Giao dịch đã bị hủy'**
  String get purchase_canceled;

  /// Purchase canceled description
  ///
  /// In vi, this message translates to:
  /// **'Giao dịch của bạn đã bị hủy. Vui lòng thử lại nếu bạn muốn nâng cấp lên Premium.'**
  String get purchase_canceled_description;

  /// Premium sync account
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản Premium của bạn sẽ được đồng bộ với tài khoản mà bạn đăng nhập vào. Hãy đảm bảo đăng nhập bằng cùng một tài khoản trên tất cả thiết bị của bạn để tận hưởng trải nghiệm Premium liền mạch.'**
  String get premium_sync_account;

  /// Premium sync warning
  ///
  /// In vi, this message translates to:
  /// **'Lưu ý: Nếu bạn đã mua gói Premium trên một tài khoản khác, vui lòng đăng nhập vào tài khoản đó để khôi phục quyền truy cập Premium của bạn. Nếu bạn đang sử dụng cùng một tài khoản, hãy thử khôi phục mua hàng để đồng bộ hóa quyền truy cập Premium của bạn.'**
  String get premium_sync_warning;

  /// Select language
  ///
  /// In vi, this message translates to:
  /// **'Chọn ngôn ngữ'**
  String get select_language;

  /// Suggested
  ///
  /// In vi, this message translates to:
  /// **'Gợi ý'**
  String get suggested;

  /// All languages
  ///
  /// In vi, this message translates to:
  /// **'Tất cả ngôn ngữ'**
  String get all_languages;

  /// Apply changes
  ///
  /// In vi, this message translates to:
  /// **'Áp dụng thay đổi'**
  String get apply_changes;

  /// Select currency
  ///
  /// In vi, this message translates to:
  /// **'Chọn tiền tệ'**
  String get select_currency;

  /// Search currency
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm tiền tệ hoặc quốc gia...'**
  String get search_currency;

  /// Popular
  ///
  /// In vi, this message translates to:
  /// **'Phổ biến'**
  String get popular;

  /// All currencies
  ///
  /// In vi, this message translates to:
  /// **'Tất cả tiền tệ'**
  String get all_currencies;

  /// Currency change warning
  ///
  /// In vi, this message translates to:
  /// **'Thay đổi tiền tệ chỉ cập nhật ký hiệu hiển thị. Tỷ giá giao dịch trước đó sẽ không được tính toán lại.'**
  String get currency_change_warning;

  /// See ads
  ///
  /// In vi, this message translates to:
  /// **'Xem quảng cáo (+{additionalUses} lượt)'**
  String see_ads(String additionalUses);

  /// Ads loading
  ///
  /// In vi, this message translates to:
  /// **'Đang tải quảng cáo...'**
  String get ads_loading;

  /// Data management
  ///
  /// In vi, this message translates to:
  /// **'Quản lý dữ liệu'**
  String get data_management;

  /// Select format
  ///
  /// In vi, this message translates to:
  /// **'Chọn định dạng'**
  String get select_format;

  /// Export data
  ///
  /// In vi, this message translates to:
  /// **'Xuất dữ liệu'**
  String get export_data;

  /// Export data description
  ///
  /// In vi, this message translates to:
  /// **'Xuất dữ liệu tài chính của bạn để sao lưu hoặc phân tích.'**
  String get export_data_description;

  /// Confirm export
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận xuất'**
  String get confirm_export;

  /// Import data
  ///
  /// In vi, this message translates to:
  /// **'Nhập dữ liệu'**
  String get import_data;

  /// Import data title
  ///
  /// In vi, this message translates to:
  /// **'Nhập '**
  String get import_data_title;

  /// Data
  ///
  /// In vi, this message translates to:
  /// **'dữ liệu'**
  String get data;

  /// Import data title 2
  ///
  /// In vi, this message translates to:
  /// **' của bạn.'**
  String get import_data_title_2;

  /// Import data description
  ///
  /// In vi, this message translates to:
  /// **'Nhập dữ liệu tài chính từ các nguồn bên ngoài để đồng bộ hóa với ứng dụng.'**
  String get import_data_description;

  /// Confirm import
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận nhập'**
  String get confirm_import;

  /// Csv format
  ///
  /// In vi, this message translates to:
  /// **'Định dạng CSV'**
  String get csv_format;

  /// Csv description
  ///
  /// In vi, this message translates to:
  /// **'Dữ liệu được phân tách bằng dấu phẩy, tương thích với hầu hết các ứng dụng bảng tính.'**
  String get csv_description;

  /// Json format
  ///
  /// In vi, this message translates to:
  /// **'Định dạng JSON'**
  String get json_format;

  /// Json description
  ///
  /// In vi, this message translates to:
  /// **'Định dạng dữ liệu linh hoạt, lý tưởng cho việc trao đổi dữ liệu giữa các ứng dụng.'**
  String get json_description;

  /// Excel format
  ///
  /// In vi, this message translates to:
  /// **'Định dạng Excel'**
  String get excel_format;

  /// Excel description
  ///
  /// In vi, this message translates to:
  /// **'Định dạng bảng tính phổ biến, hỗ trợ các tính năng nâng cao và phân tích dữ liệu.'**
  String get excel_description;

  /// Select file
  ///
  /// In vi, this message translates to:
  /// **'Chọn tệp'**
  String get select_file;

  /// No file selected
  ///
  /// In vi, this message translates to:
  /// **'Chưa chọn tệp nào'**
  String get no_file_selected;

  /// Import successful
  ///
  /// In vi, this message translates to:
  /// **'Nhập dữ liệu thành công!'**
  String get import_successful;

  /// Error importing data
  ///
  /// In vi, this message translates to:
  /// **'Lỗi khi nhập dữ liệu.'**
  String get error_importing_data;

  /// Sync data now
  ///
  /// In vi, this message translates to:
  /// **'Đồng bộ ngay'**
  String get sync_data_now;

  /// Last synced
  ///
  /// In vi, this message translates to:
  /// **'Đồng bộ lần cuối: \n{time}'**
  String last_synced(String time);

  /// Syncing
  ///
  /// In vi, this message translates to:
  /// **'Đang đồng bộ...'**
  String get syncing;

  /// Never synced
  ///
  /// In vi, this message translates to:
  /// **'Chưa đồng bộ'**
  String get never_synced;

  /// Unauthenticated
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng đăng nhập để đồng bộ dữ liệu của bạn trên các thiết bị.'**
  String get unauthenticated;

  /// Sync error
  ///
  /// In vi, this message translates to:
  /// **'Lỗi đồng bộ hóa: {error}'**
  String sync_error(String error);

  /// Premium required to sync
  ///
  /// In vi, this message translates to:
  /// **'Bạn cần nâng cấp lên Premium hoặc xem quảng cáo để đồng bộ dữ liệu.'**
  String get premium_required_to_sync;

  /// Sync in progress
  ///
  /// In vi, this message translates to:
  /// **'Hệ thống đang đồng bộ, vui lòng đợi.'**
  String get sync_in_progress;

  /// Cooldown
  ///
  /// In vi, this message translates to:
  /// **'Bạn thao tác quá nhanh. Vui lòng đợi {seconds} giây để đồng bộ lại.'**
  String cooldown(String seconds);

  /// Accepted formats
  ///
  /// In vi, this message translates to:
  /// **'Chấp nhận các định dạng'**
  String get accepted_formats;

  /// Select file to import
  ///
  /// In vi, this message translates to:
  /// **'Chọn tệp để nhập'**
  String get select_file_to_import;

  /// Tap to browse
  ///
  /// In vi, this message translates to:
  /// **'Chạm để duyệt thiết bị hoặc lưu trữ đám mây của bạn cho các tệp.'**
  String get tap_to_browse;

  /// Protected
  ///
  /// In vi, this message translates to:
  /// **'Được bảo vệ'**
  String get protected;

  /// Protected description
  ///
  /// In vi, this message translates to:
  /// **'Dữ liệu của bạn không bao giờ rời khỏi thiết bị và được xử lý cục bộ.'**
  String get protected_description;

  /// Recent imports
  ///
  /// In vi, this message translates to:
  /// **'Nhập gần đây'**
  String get recent_imports;

  /// No recent imports
  ///
  /// In vi, this message translates to:
  /// **'Chưa có nhập dữ liệu gần đây'**
  String get no_recent_imports;

  /// Invalid format
  ///
  /// In vi, this message translates to:
  /// **'Định dạng tệp không hợp lệ.'**
  String get invalid_format;

  /// Import success
  ///
  /// In vi, this message translates to:
  /// **'Nhập thành công!'**
  String get import_success;

  /// Import success description
  ///
  /// In vi, this message translates to:
  /// **'Đã nhập thành công {count} giao dịch từ tệp.'**
  String import_success_description(String count);

  /// File format template
  ///
  /// In vi, this message translates to:
  /// **'Mẫu định dạng tệp'**
  String get file_format_template;

  /// Download sample file
  ///
  /// In vi, this message translates to:
  /// **'Tải xuống tệp mẫu {format}'**
  String download_sample_file(String format);

  /// Card
  ///
  /// In vi, this message translates to:
  /// **'Thẻ'**
  String get card;

  /// Font selection
  ///
  /// In vi, this message translates to:
  /// **'Lựa chọn Font chữ'**
  String get font_selection;

  /// Select font
  ///
  /// In vi, this message translates to:
  /// **'Chọn Font chữ'**
  String get select_font;

  /// Font
  ///
  /// In vi, this message translates to:
  /// **'Font chữ'**
  String get font;

  /// Font description
  ///
  /// In vi, this message translates to:
  /// **'Một giao dịch mỗi ngày sẽ giúp bạn tránh được \'Tháng túng thiếu\'.'**
  String get font_description;

  /// Reminder title
  ///
  /// In vi, this message translates to:
  /// **'Nhắc nhở chi tiêu hàng ngày'**
  String get reminder_title;

  /// Reminder body
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã ghi chép chi tiêu hôm nay chưa? 💸'**
  String get reminder_body;

  /// Defaulttransactiontitle
  ///
  /// In vi, this message translates to:
  /// **'Giao dịch mới'**
  String get defaultTransactionTitle;

  /// Invoice analysis
  ///
  /// In vi, this message translates to:
  /// **'Đang phân tích hóa đơn ...'**
  String get invoice_analysis;

  /// Mapbox error
  ///
  /// In vi, this message translates to:
  /// **'Lỗi tải bản đồ. Vui lòng kiểm tra cấu hình token Mapbox của bạn.'**
  String get mapbox_error;

  /// Location
  ///
  /// In vi, this message translates to:
  /// **'Vị trí'**
  String get location;

  /// Current location
  ///
  /// In vi, this message translates to:
  /// **'Vị trí hiện tại'**
  String get current_location;

  /// Select location
  ///
  /// In vi, this message translates to:
  /// **'Chọn vị trí'**
  String get select_location;

  /// No location selected
  ///
  /// In vi, this message translates to:
  /// **'Chưa chọn vị trí'**
  String get no_location_selected;

  /// Search location
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm vị trí...'**
  String get search_location;

  /// Tap to change location
  ///
  /// In vi, this message translates to:
  /// **'Chạm để thay đổi vị trí'**
  String get tap_to_change_location;

  /// Search results
  ///
  /// In vi, this message translates to:
  /// **'Kết quả tìm kiếm'**
  String get search_results;

  /// No location found
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy vị trí'**
  String get no_location_found;

  /// Recent locations
  ///
  /// In vi, this message translates to:
  /// **'Vị trí gần đây'**
  String get recent_locations;

  /// Location access error
  ///
  /// In vi, this message translates to:
  /// **'Lỗi truy cập vị trí'**
  String get location_access_error;

  /// Location permission denied
  ///
  /// In vi, this message translates to:
  /// **'Quyền truy cập vị trí bị từ chối.'**
  String get location_permission_denied;

  /// Location permission denied description
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng bật quyền truy cập vị trí trong cài đặt.'**
  String get location_permission_denied_description;

  /// Notification permission denied
  ///
  /// In vi, this message translates to:
  /// **'Nhận thông báo bị từ chối.'**
  String get notification_permission_denied;

  /// Notification permission denied description
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng bật thông báo trong cài đặt để nhận nhắc nhở.'**
  String get notification_permission_denied_description;

  /// Permission required camera
  ///
  /// In vi, this message translates to:
  /// **'Quyền truy cập camera bị từ chối'**
  String get permission_required_camera;

  /// Permission required camera description
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng bật quyền truy cập camera trong cài đặt để sử dụng tính năng quét hóa đơn.'**
  String get permission_required_camera_description;

  /// Voice input error
  ///
  /// In vi, this message translates to:
  /// **'Lỗi nhập giọng nói. Vui lòng thử lại.'**
  String get voice_input_error;

  /// Voice input not recognized
  ///
  /// In vi, this message translates to:
  /// **'Không nhận diện được giọng nói. Vui lòng thử lại.'**
  String get voice_input_not_recognized;

  /// Voice input permission denied
  ///
  /// In vi, this message translates to:
  /// **'Quyền nhập giọng nói bị từ chối. Vui lòng bật quyền truy cập micro trong cài đặt.'**
  String get voice_input_permission_denied;

  /// Error ai request
  ///
  /// In vi, this message translates to:
  /// **'AI không thể nhận dạng yêu cầu này. Hãy thử nói rõ hơn.'**
  String get error_ai_request;

  /// Voice analysis
  ///
  /// In vi, this message translates to:
  /// **'Đang phân tích giọng nói...'**
  String get voice_analysis;

  /// Scan receipt error
  ///
  /// In vi, this message translates to:
  /// **'Lỗi quét hóa đơn. Vui lòng thử lại.'**
  String get scan_receipt_error;

  /// Requires premium
  ///
  /// In vi, this message translates to:
  /// **'Tính năng này yêu cầu xem quảng cáo để sử dụng hoặc nâng cấp lên Premium.'**
  String get requires_premium;

  /// Watch ad continue
  ///
  /// In vi, this message translates to:
  /// **'Xem quảng cáo để tiếp tục'**
  String get watch_ad_continue;

  /// Permission required voice input
  ///
  /// In vi, this message translates to:
  /// **'Quyền truy cập micro bị từ chối'**
  String get permission_required_voice_input;

  /// Permission required voice input description
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng bật quyền truy cập micro trong cài đặt để sử dụng nhập giọng nói.'**
  String get permission_required_voice_input_description;

  /// Permission required location
  ///
  /// In vi, this message translates to:
  /// **'Quyền truy cập vị trí bị từ chối'**
  String get permission_required_location;

  /// Permission required location description
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng bật quyền truy cập vị trí trong cài đặt để sử dụng các tính năng vị trí.'**
  String get permission_required_location_description;

  /// Congratulations
  ///
  /// In vi, this message translates to:
  /// **'Chúc mừng!'**
  String get congratulations;

  /// Successfully purchased
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã mua thành công gói Premium. Hãy tận hưởng trải nghiệm nâng cao của bạn!'**
  String get successfully_purchased;

  /// Cancel purchase
  ///
  /// In vi, this message translates to:
  /// **'Giao dịch đã bị hủy.'**
  String get cancel_purchase;

  /// Restore no purchase description
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy giao dịch nào để khôi phục.'**
  String get restore_no_purchase_description;

  /// Ai powered
  ///
  /// In vi, this message translates to:
  /// **'Hỗ trợ bởi AI'**
  String get ai_powered;

  /// Entries pending
  ///
  /// In vi, this message translates to:
  /// **'Mục đang chờ xử lý'**
  String get entries_pending;

  /// Confirm selected entries
  ///
  /// In vi, this message translates to:
  /// **'Thêm các mục đã chọn'**
  String get confirm_selected_entries;

  /// Preview results
  ///
  /// In vi, this message translates to:
  /// **'Xem trước kết quả'**
  String get preview_results;

  /// Clear all
  ///
  /// In vi, this message translates to:
  /// **'Bỏ chọn tất cả'**
  String get clear_all;

  /// Select all
  ///
  /// In vi, this message translates to:
  /// **'Chọn tất cả'**
  String get select_all;

  /// Fail to save transactions
  ///
  /// In vi, this message translates to:
  /// **'Lưu giao dịch thất bại. Vui lòng thử lại.'**
  String get fail_to_save_transactions;

  /// Tap to check in
  ///
  /// In vi, this message translates to:
  /// **'Chạm để kiểm tra'**
  String get tap_to_check_in;

  /// Keep your streak
  ///
  /// In vi, this message translates to:
  /// **'Duy trì chuỗi của bạn!'**
  String get keep_your_streak;

  /// Keep your streak day
  ///
  /// In vi, this message translates to:
  /// **'Duy trì chuỗi {streak} ngày của bạn!'**
  String keep_your_streak_day(String streak);

  /// Streak
  ///
  /// In vi, this message translates to:
  /// **'Chuỗi'**
  String get streak;

  /// Streak days
  ///
  /// In vi, this message translates to:
  /// **'{days} ngày'**
  String streak_days(String days);

  /// Not logined
  ///
  /// In vi, this message translates to:
  /// **'Chưa đăng nhập'**
  String get not_logined;

  /// Please login to sync data
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng đăng nhập để đồng bộ dữ liệu của bạn trên các thiết bị.'**
  String get please_login_to_sync_data;

  /// Require premium to sync
  ///
  /// In vi, this message translates to:
  /// **'Bạn cần nâng cấp lên Premium hoặc xem quảng cáo để đồng bộ dữ liệu.'**
  String get require_premium_to_sync;

  /// Information and support
  ///
  /// In vi, this message translates to:
  /// **'Thông tin & Hỗ trợ'**
  String get information_and_support;

  /// Contact support
  ///
  /// In vi, this message translates to:
  /// **'Liên hệ hỗ trợ'**
  String get contact_support;

  /// Send email
  ///
  /// In vi, this message translates to:
  /// **'Gửi email hỗ trợ'**
  String get send_email;

  /// Describe issue
  ///
  /// In vi, this message translates to:
  /// **'Mô tả vấn đề của bạn ở đây...'**
  String get describe_issue;

  /// Feedback
  ///
  /// In vi, this message translates to:
  /// **'Góp ý'**
  String get feedback;

  /// Feedback description
  ///
  /// In vi, this message translates to:
  /// **'Chúng tôi rất muốn nghe ý kiến của bạn! Hãy chia sẻ suy nghĩ, đề xuất hoặc bất kỳ vấn đề nào bạn gặp phải để chúng tôi có thể cải thiện ứng dụng.'**
  String get feedback_description;

  /// Thank you feedback
  ///
  /// In vi, this message translates to:
  /// **'Cảm ơn bạn đã gửi góp ý! Chúng tôi đánh giá cao phản hồi của bạn và sẽ xem xét nó để cải thiện ứng dụng.'**
  String get thank_you_feedback;

  /// Submit feedback
  ///
  /// In vi, this message translates to:
  /// **'Gửi góp ý'**
  String get submit_feedback;

  /// Report issue
  ///
  /// In vi, this message translates to:
  /// **'Báo cáo sự cố'**
  String get report_issue;

  /// Submit issue
  ///
  /// In vi, this message translates to:
  /// **'Gửi báo cáo sự cố'**
  String get submit_issue;

  /// Report issue description
  ///
  /// In vi, this message translates to:
  /// **'Nếu bạn gặp phải bất kỳ lỗi nào hoặc có vấn đề với ứng dụng, vui lòng cho chúng tôi biết. Mô tả chi tiết vấn đề của bạn để chúng tôi có thể giải quyết nó nhanh chóng.'**
  String get report_issue_description;

  /// Thank you issue
  ///
  /// In vi, this message translates to:
  /// **'Cảm ơn bạn đã báo cáo sự cố! Chúng tôi đánh giá cao phản hồi của bạn và sẽ xem xét nó để giải quyết vấn đề bạn gặp phải.'**
  String get thank_you_issue;

  /// Request delete account
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu xóa tài khoản'**
  String get request_delete_account;

  /// Delete account description
  ///
  /// In vi, this message translates to:
  /// **'Nếu bạn muốn xóa tài khoản của mình, vui lòng cho chúng tôi biết taị sao bạn muốn xóa tài khoản. Chúng tôi sẽ xử lý yêu cầu của bạn trong thời gian sớm nhất có thể.'**
  String get delete_account_description;

  /// Submit delete request
  ///
  /// In vi, this message translates to:
  /// **'Gửi yêu cầu xóa tài khoản'**
  String get submit_delete_request;

  /// Select subject
  ///
  /// In vi, this message translates to:
  /// **'Chọn chủ đề'**
  String get select_subject;

  /// Please enter content
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập nội dung'**
  String get please_enter_content;

  /// Subject
  ///
  /// In vi, this message translates to:
  /// **'Chủ đề'**
  String get subject;

  /// Content
  ///
  /// In vi, this message translates to:
  /// **'Nội dung'**
  String get content;

  /// Send contact success
  ///
  /// In vi, this message translates to:
  /// **'Gửi liên hệ thành công! Chúng tôi sẽ liên hệ lại với bạn sớm nhất có thể.'**
  String get send_contact_success;

  /// Send contact error
  ///
  /// In vi, this message translates to:
  /// **'Lỗi khi gửi liên hệ. Vui lòng thử lại.'**
  String get send_contact_error;

  /// Contact info
  ///
  /// In vi, this message translates to:
  /// **'Thông tin liên hệ'**
  String get contact_info;

  /// Email placeholder
  ///
  /// In vi, this message translates to:
  /// **'Nhập email của bạn'**
  String get email_placeholder;

  /// Name placeholder
  ///
  /// In vi, this message translates to:
  /// **'Nhập tên của bạn'**
  String get name_placeholder;

  /// Invalid name
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập tên của bạn.'**
  String get invalid_name;

  /// Mrs
  ///
  /// In vi, this message translates to:
  /// **'Bà'**
  String get mrs;

  /// Mr
  ///
  /// In vi, this message translates to:
  /// **'Ông'**
  String get mr;

  /// Ms
  ///
  /// In vi, this message translates to:
  /// **'Cô'**
  String get ms;

  /// Salutation
  ///
  /// In vi, this message translates to:
  /// **'Danh xưng'**
  String get salutation;

  /// Delete account
  ///
  /// In vi, this message translates to:
  /// **'Xóa tài khoản'**
  String get delete_account;

  /// Delete account confirmation
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa tài khoản của mình không? Hành động này không thể hoàn tác và sẽ xóa tất cả dữ liệu của bạn.'**
  String get delete_account_confirmation;

  /// Failed to send deletion request
  ///
  /// In vi, this message translates to:
  /// **'Lỗi khi gửi yêu cầu xóa tài khoản. Vui lòng thử lại.'**
  String get failed_to_send_deletion_request;

  /// Requires recent login description
  ///
  /// In vi, this message translates to:
  /// **'Vì lý do bảo mật, vui lòng đăng xuất và đăng nhập lại sau đó thử lại yêu cầu xóa tài khoản của bạn.'**
  String get requires_recent_login_description;

  /// Delete account failed
  ///
  /// In vi, this message translates to:
  /// **'Đã xảy ra lỗi khi xoá tài khoản của bạn. Vui lòng thử lại.'**
  String get delete_account_failed;
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
