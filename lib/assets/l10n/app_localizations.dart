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
  /// **'Đăng nhập ngay.'**
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

  /// No description provided for @change_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Đổi mã khóa'**
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
  /// **'Mã khóa mới'**
  String get new_passcode;

  /// No description provided for @enter_new_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã khóa mới'**
  String get enter_new_passcode;

  /// No description provided for @confirm_new_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận mã khóa mới'**
  String get confirm_new_passcode;

  /// No description provided for @enter_confirm_new_passcode.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mã khóa mới'**
  String get enter_confirm_new_passcode;

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
