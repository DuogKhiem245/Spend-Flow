// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get app_name => 'SpendFlow';

  @override
  String get ok => 'Đồng ý';

  @override
  String get cancel => 'Hủy';

  @override
  String get skip => 'Bỏ qua';

  @override
  String get next => 'Tiếp theo';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get save => 'Lưu';

  @override
  String get edit => 'Sửa';

  @override
  String get delete => 'Xóa';

  @override
  String get yes => 'Có';

  @override
  String get no => 'Không';

  @override
  String get done => 'Hoàn tất';

  @override
  String get close => 'Đóng';

  @override
  String get back => 'Quay lại';

  @override
  String get start => 'Bắt đầu';

  @override
  String get continueAction => 'Tiếp tục';

  @override
  String get view_all => 'Xem tất cả';

  @override
  String get see_all => 'Xem tất cả';

  @override
  String get amount => 'Số tiền';

  @override
  String get name => 'Tên giao dịch';

  @override
  String get date => 'Ngày';

  @override
  String get month => 'Tháng';

  @override
  String get today => 'Hôm nay';

  @override
  String get other => 'Khác';

  @override
  String get home => 'Trang chủ';

  @override
  String get reports => 'Báo cáo';

  @override
  String get budgets => 'Ngân sách';

  @override
  String get all => 'Tất cả';

  @override
  String get error => 'Lỗi';

  @override
  String get user => 'Người dùng';

  @override
  String get success => 'Thành công';

  @override
  String get loading => 'Đang tải...';

  @override
  String get onboard_step1_title => 'Đơn giản hóa tài chính';

  @override
  String get onboard_step1_message =>
      'Tất cả tài khoản của bạn trong một nơi. Xem tiền của bạn đi đâu và đạt mục tiêu tài chính dễ dàng.';

  @override
  String get onboard_step2_title => 'Kiểm soát chi tiêu của bạn';

  @override
  String get onboard_step2_message =>
      'Đặt hạn mức chi tiêu, theo dõi các danh mục và luôn nắm vững mục tiêu tài chính bằng cách tạo ngân sách cá nhân.';

  @override
  String get onboard_step3_title => 'Xem khoản tiết kiệm tăng trưởng';

  @override
  String get onboard_step3_message =>
      'Thiết lập mục tiêu tiết kiệm tự động, làm tròn các giao dịch và khám phá cách thông minh để tiết kiệm tiền dễ dàng.';

  @override
  String get create_first_wallet => 'Tạo ví đầu tiên của bạn';

  @override
  String get welcome_create_wallet =>
      'Chào mừng đến với SpendFlow!\nHãy tạo ví đầu tiên của bạn để bắt đầu.';

  @override
  String get enter_wallet_name => 'Nhập tên ví';

  @override
  String get eg_my_wallet => 'ví dụ: Ví của tôi, Tiền mặt, Thẻ tín dụng';

  @override
  String get currency_unit => 'Đơn vị tiền tệ';

  @override
  String get create_wallet => 'Tạo ví';

  @override
  String get please_enter_wallet_name => 'Vui lòng nhập tên ví.';

  @override
  String get add_wallet => 'Thêm ví mới';

  @override
  String get wallet_name => 'Tên ví';

  @override
  String get add_wallet_description =>
      'Thêm nhiều ví để quản lí và theo dõi tài chính hiệu quả hơn.';

  @override
  String get cannot_delete_last_wallet => 'Bạn không thể xóa ví duy nhất.';

  @override
  String get delete_wallet => 'Xóa ví';

  @override
  String delete_wallet_confirmation(Object walletName) {
    return 'Bạn có chắc chắn muốn xóa ví \'$walletName\' không? Hành động này không thể hoàn tác.';
  }

  @override
  String get in_use => 'Đang sử dụng';

  @override
  String get login => 'Đăng nhập';

  @override
  String get register => 'Đăng ký';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mật khẩu';

  @override
  String get new_password => 'Mật khẩu mới';

  @override
  String get enter_email => 'Nhập email của bạn';

  @override
  String get enter_your_password => 'Nhập mật khẩu của bạn';

  @override
  String get confirm_password => 'Nhập lại mật khẩu';

  @override
  String get confirm_your_password => 'Nhập lại mật khẩu';

  @override
  String get passwords_match => 'Mật khẩu trùng khớp.';

  @override
  String get passwords_mismatch => 'Mật khẩu không trùng khớp.';

  @override
  String get forgot_password => 'Quên mật khẩu?';

  @override
  String get description_forgot_password =>
      'Nhập email được liên kết với tài khoản của bạn để đặt lại mật khẩu.';

  @override
  String get send_otp => 'Gửi OTP';

  @override
  String get enter_otp => 'Nhập OTP';

  @override
  String get resend => 'Gửi lại';

  @override
  String get verify => 'Xác thực';

  @override
  String get no_otp => 'Không nhận được mã?';

  @override
  String get no_account => 'Chưa có tài khoản?';

  @override
  String get have_account => 'Đã có tài khoản?';

  @override
  String get login_error => 'Email hoặc mật khẩu không hợp lệ';

  @override
  String get register_error => 'Đăng ký thất bại';

  @override
  String get create_account => 'Đăng kí tài khoản';

  @override
  String get create_password => 'Tạo mật khẩu mới';

  @override
  String get create_new_password => 'Gần xong rồi! Tạo mật khẩu mới của bạn.';

  @override
  String get or_continue_with => 'Hoặc đăng nhập với';

  @override
  String sign_in_with(Object provider) {
    return 'Đăng nhập với $provider';
  }

  @override
  String get check_your_mail => 'Kiểm tra email của bạn';

  @override
  String get we_have_sent_mail => 'Chúng tôi đã gửi một email đến:';

  @override
  String get please_check_your_mail_to_verify_account =>
      'Vui lòng kiểm tra email của bạn để xác thực tài khoản trước khi đăng nhập.';

  @override
  String get register_failed => 'Đăng ký thất bại';

  @override
  String get please_fill_all_fields => 'Vui lòng điền vào tất cả các trường.';

  @override
  String get please_enter_email_and_password =>
      'Vui lòng nhập cả email và mật khẩu.';

  @override
  String get incorrect_email_or_password => 'Email hoặc mật khẩu không đúng.';

  @override
  String get invalid_email_format => 'Định dạng email không hợp lệ.';

  @override
  String get this_account_has_been_disabled =>
      'Tài khoản này đã bị vô hiệu hóa.';

  @override
  String get too_many_requests_please_try_later =>
      'Quá nhiều yêu cầu. Vui lòng thử lại sau.';

  @override
  String get email_not_verified => 'Email chưa được xác thực';

  @override
  String get please_verify_your_email_to_continue =>
      'Vui lòng xác thực email của bạn để tiếp tục.';

  @override
  String get are_you_sure_logout => 'Bạn có chắc chắn muốn đăng xuất không?';

  @override
  String get have_error_occurred => 'Đã xảy ra lỗi. Vui lòng thử lại.';

  @override
  String get welcome_back => 'Chào mừng trở lại';

  @override
  String get back_login => 'Quay lại đăng nhập';

  @override
  String get description_create_account =>
      'Kiểm soát tài chính của bạn ngay hôm nay';

  @override
  String get label_weak => 'Yếu';

  @override
  String get label_fair => 'Trung bình';

  @override
  String get label_good => 'Tốt';

  @override
  String get label_strong => 'Mạnh';

  @override
  String get low_pass => 'Tối thiểu 8 ký tự, bao gồm chữ số và ký tự đặc biệt.';

  @override
  String get weak_pass => 'Quá ngắn. Vui lòng nhập thêm ký tự.';

  @override
  String get fair_pass => 'Khá hơn rồi. Hãy thêm số và ký tự đặt biệt.';

  @override
  String get good_pass_char =>
      'Sắp hoàn hảo! Hãy thêm ký tự đặc biệt để tăng bảo mật.';

  @override
  String get good_pass_num => 'Sắp hoàn hảo! Hãy thêm số để tăng bảo mật.';

  @override
  String get good_pass_special =>
      'Sắp hoàn hảo! Hãy thêm ký tự bất kì để tăng bảo mật.';

  @override
  String get strong_pass => 'Tuyệt vời! Mật khẩu của bạn đã an toàn.';

  @override
  String get password_reset_email_sent =>
      'Chúng tôi đã gửi một liên kết đặt lại mật khẩu đến email của bạn.';

  @override
  String get forgot_password_description =>
      'Nhập email được liên kết với tài khoản của bạn để đặt lại mật khẩu.';

  @override
  String get send_email_reset => 'Gửi email đặt lại';

  @override
  String get good_morning => 'Chào buổi sáng';

  @override
  String get good_afternoon => 'Chào buổi chiều';

  @override
  String get good_evening => 'Chào buổi tối';

  @override
  String get hello => 'Xin chào';

  @override
  String get income => 'Thu nhập';

  @override
  String get expenses => 'Chi tiêu';

  @override
  String get balance => 'Còn lại';

  @override
  String get total_balance => 'Tổng số dư';

  @override
  String get spending_this_month => 'Chi tiêu trong tháng này';

  @override
  String get total_spent => 'Tổng chi tiêu';

  @override
  String get recent_transactions => 'Giao dịch gần đây';

  @override
  String get add_transaction => 'Thêm giao dịch';

  @override
  String get no_transactions => 'Không có dữ liệu';

  @override
  String get enter_transaction_name => 'Nhập tên giao dịch';

  @override
  String get suggested_category => 'Danh mục gợi ý';

  @override
  String get category => 'Danh mục';

  @override
  String get categories => 'Danh mục';

  @override
  String get select_category => 'Chọn danh mục';

  @override
  String get edit_category => 'Chỉnh sửa danh mục';

  @override
  String are_you_sure_delete_category(Object categoryName) {
    return 'Bạn có chắc chắn muốn xóa danh mục $categoryName?';
  }

  @override
  String get system_category => 'Danh mục hệ thống không thể xóa.';

  @override
  String get system_category_description =>
      'Bạn không thể chỉnh sửa hoặc xóa danh mục mặc định này.';

  @override
  String get category_food => 'Ăn uống';

  @override
  String get category_transport => 'Di chuyển';

  @override
  String get category_salary => 'Lương';

  @override
  String get category_shopping => 'Mua sắm';

  @override
  String get category_game => 'Trò chơi';

  @override
  String get category_house => 'Nhà cửa';

  @override
  String get category_gift => 'Quà tặng';

  @override
  String get category_health => 'Sức khỏe';

  @override
  String get category_entertainment => 'Giải trí';

  @override
  String get category_bill => 'Hóa đơn';

  @override
  String get category_insurance => 'Bảo hiểm';

  @override
  String get category_education => 'Giáo dục';

  @override
  String get category_pet => 'Thú cưng';

  @override
  String get category_travel => 'Du lịch';

  @override
  String get category_savings => 'Tiết kiệm';

  @override
  String get category_phone => 'Điện thoại';

  @override
  String get category_internet => 'Internet';

  @override
  String get category_water => 'Nước';

  @override
  String get category_electricity => 'Điện';

  @override
  String get category_gas => 'Gas';

  @override
  String get category_cleaning => 'Dọn dẹp';

  @override
  String get category_beauty => 'Làm đẹp';

  @override
  String get category_baby => 'Em bé';

  @override
  String get category_sport => 'Thể thao';

  @override
  String get category_music => 'Âm nhạc';

  @override
  String get category_repair => 'Sửa chữa';

  @override
  String get category_tax => 'Thuế';

  @override
  String get note => 'Ghi chú (tùy chọn)';

  @override
  String get enter_note => 'Nhập ghi chú';

  @override
  String get add_income => 'Thêm thu nhập';

  @override
  String get add_expense => 'Thêm chi tiêu';

  @override
  String get search_category => 'Tìm kiếm danh mục';

  @override
  String get no_category_found => 'Không tìm thấy danh mục';

  @override
  String get most_used => 'Sử dụng nhiều nhất';

  @override
  String get category_suggestions => 'Danh mục gợi ý';

  @override
  String get all_categories => 'Tất cả danh mục';

  @override
  String get new_category => 'Danh mục mới';

  @override
  String get category_name => 'Tên danh mục';

  @override
  String get category_color => 'Màu danh mục';

  @override
  String get category_icon => 'Biểu tượng danh mục';

  @override
  String get vs_last_month => 'so với Tháng trước';

  @override
  String get transaction => 'Giao dịch';

  @override
  String get delete_transaction => 'Xóa giao dịch';

  @override
  String get delete_transaction_confirmation =>
      'Bạn có chắc chắn muốn xóa giao dịch này không?';

  @override
  String get transaction_details => 'Chi tiết giao dịch';

  @override
  String get spending_trend => 'Xu hướng chi tiêu';

  @override
  String get spending_last_7_days => 'Chi tiêu trong 7 ngày qua';

  @override
  String get note_2 => 'Ghi chú';

  @override
  String get scan_receipt => 'Quét hóa đơn';

  @override
  String get add_via_voice => 'Thêm bằng giọng nói';

  @override
  String get add_manually => 'Thêm thủ công';

  @override
  String get limit_reached => 'Đã đạt giới hạn';

  @override
  String limit_reached_description(Object featureName, Object limit) {
    return 'Bạn đã sử dụng $featureName $limit lần hôm nay.\nVui lòng quay lại vào ngày mai hoặc nâng cấp lên Premium.';
  }

  @override
  String get align_receipt => 'Căn chỉnh hóa đơn của bạn vào khung';

  @override
  String get listening => 'Đang nghe...';

  @override
  String get voice_example => 'Ví dụ: Tôi đã chi 50 đô la cho thực phẩm';

  @override
  String get tap_to_stop => 'Chạm để dừng';

  @override
  String get tap_to_listen => 'Chạm để nghe';

  @override
  String get yesterday => 'Hôm qua';

  @override
  String get your_monthly_budget => 'Ngân sách hàng tháng của bạn';

  @override
  String get spent => 'Đã chi ';

  @override
  String get out_of => ' trong tổng ';

  @override
  String get left_to_spend => 'còn lại để chi tiêu';

  @override
  String get add_budget => 'Thêm ngân sách';

  @override
  String get no_budgets_yet => 'Chưa có ngân sách nào';

  @override
  String get create_budget_description => 'Nhấn + để tạo giới hạn chi tiêu';

  @override
  String get edit_budget => 'Sửa ngân sách';

  @override
  String are_you_sure_delete_budget(Object budgetName) {
    return 'Bạn có chắc muốn xóa ngân sách $budgetName? \n';
  }

  @override
  String get settings => 'Cài đặt';

  @override
  String get settings_description =>
      'Giữ dữ liệu tài chính luôn đồng bộ trên tất cả thiết bị của bạn';

  @override
  String get sign_in_now => 'Đăng nhập ngay';

  @override
  String get get_started => 'Bắt đầu ngay';

  @override
  String get welcome => 'Chào mừng !';

  @override
  String get general => 'Cài đặt chung';

  @override
  String get security => 'Bảo mật';

  @override
  String get support => 'Hỗ trợ';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get dark_mode => 'Chế độ tối';

  @override
  String get notifications => 'Thông báo';

  @override
  String get appearance => 'Giao diện';

  @override
  String get currency => 'Tiền tệ';

  @override
  String get about => 'Giới thiệu';

  @override
  String get terms => 'Điều khoản & Điều kiện';

  @override
  String get privacy_policy => 'Chính sách quyền riêng tư';

  @override
  String get version => 'Phiên bản';

  @override
  String get edit_profile => 'Chỉnh sửa hồ sơ';

  @override
  String get full_name => 'Họ và tên';

  @override
  String get enter_full_name => 'Nhập họ và tên';

  @override
  String get email_address => 'Địa chỉ email';

  @override
  String get enter_email_address => 'Nhập địa chỉ email';

  @override
  String get phone_number => 'Số điện thoại';

  @override
  String get enter_phone_number => 'Nhập số điện thoại';

  @override
  String get day_of_birth => 'Ngày sinh';

  @override
  String get select_day_of_birth => 'Chọn ngày sinh';

  @override
  String get save_changes => 'Lưu thay đổi';

  @override
  String get profile_updated_success => 'Cập nhật hồ sơ thành công!';

  @override
  String get error_updating_profile => 'Lỗi khi cập nhật hồ sơ.';

  @override
  String get error_uploading_avatar => 'Lỗi khi tải lên ảnh đại diện.';

  @override
  String get upgrade_premium => 'Nâng cấp lên Premium!';

  @override
  String get upgrade_premium_description =>
      'Mở khóa các tính năng cao cấp và nâng cao trải nghiệm của bạn.';

  @override
  String get upgrade_now => 'Nâng cấp ngay';

  @override
  String get you_are_premium => 'Bạn đã sẵn sàng, người dùng Premium!';

  @override
  String get you_are_premium_description =>
      'Tận hưởng trải nghiệm nâng cao của bạn.';

  @override
  String get import_export_data => 'Nhập/Xuất dữ liệu';

  @override
  String get sync_data => 'Đồng bộ dữ liệu';

  @override
  String continue_with(Object price) {
    return 'Tiếp tục với $price / tháng';
  }

  @override
  String get biometric_authentication => 'Xác thực sinh trắc học';

  @override
  String get password_security => 'Bảo mật mật mã';

  @override
  String get face_id_description =>
      'Mở khóa ứng dụng chỉ bằng một ánh nhìn. Face ID mang lại sự tiện lợi và bảo mật bằng cách nhận diện khuôn mặt của bạn.';

  @override
  String get touch_id_description =>
      'Mở khóa ứng dụng chỉ bằng một cú chạm. Touch ID giúp truy cập nhanh chóng và an toàn bằng vân tay của bạn.';

  @override
  String get pass_code_description =>
      'Thêm một lớp bảo vệ. Mã khóa đảm bảo chỉ bạn mới có thể truy cập dữ liệu tài chính, ngay cả khi thiết bị bị xâm phạm.';

  @override
  String get passcode => 'Passcode';

  @override
  String get change_passcode => 'Đổi passcode';

  @override
  String get old_passcode => 'Mã khóa cũ';

  @override
  String get enter_old_passcode => 'Nhập mã khóa cũ';

  @override
  String get new_passcode => 'Passcode mới';

  @override
  String get enter_new_passcode => 'Nhập Passcode mới';

  @override
  String get confirm_new_passcode => 'Xác nhận Passcode mới';

  @override
  String get enter_confirm_new_passcode => 'Nhập lại Passcode mới';

  @override
  String get turnOffPasscode => 'Tắt Passcode';

  @override
  String get createPasscode => 'Tạo Passcode';

  @override
  String get changePasscode => 'Đổi Passcode';

  @override
  String get removePasscode => 'Xóa Passcode';

  @override
  String get updatePasscode => 'Cập nhật Passcode';

  @override
  String get description_create_passcode =>
      'Bảo vệ tài khoản của bạn bằng cách thường xuyên cập nhật Passcode 6 chữ số.';

  @override
  String get description_remove_passcode =>
      'Nhập Passcode hiện tại của bạn để tắt bảo mật.';

  @override
  String get currentPasscode => 'Passcode hiện tại';

  @override
  String get enterCurrentPin => 'Nhập mã PIN hiện tại';

  @override
  String get passcode_turn_off_success => 'Passcode đã được tắt thành công!';

  @override
  String get passcode_update_success => 'Cập nhật Passcode thành công!';

  @override
  String get passcode_create_success => 'Tạo Passcode thành công!';

  @override
  String get currentPasscodeIncorrect => 'Passcode hiện tại không đúng.';

  @override
  String get errorSavingData => 'Lỗi khi lưu dữ liệu.';

  @override
  String get newPasscodeMustBe6Digits => 'Passcode mới phải có 6 chữ số.';

  @override
  String get passcodesDoNotMatch => 'Passcode không khớp.';

  @override
  String get enter_passcode => 'Nhập Passcode';

  @override
  String get incorrect_passcode => 'Passcode không đúng.';

  @override
  String get face => 'Face ID';

  @override
  String get fingerprint => 'Vân tay';

  @override
  String get report_locked => 'Nội dung được khóa';

  @override
  String get unlock => 'Mở khóa';

  @override
  String get unlock_untilimited_access => 'Mở khóa truy cập không giới hạn';

  @override
  String get unlock_untilimited_access_description =>
      'Nâng cấp lên Premium để loại bỏ mọi giới hạn và truy cập các tính năng nâng cao.';

  @override
  String get daily_input_cap_reached => 'Đã đạt giới hạn nhập hàng ngày';

  @override
  String get daily_input_cap_reached_description =>
      'Bạn đã đạt giới hạn nhập hàng ngày cho việc quét hóa đơn và nhập giọng nói. Nâng cấp ngay để tiếp tục.';

  @override
  String get feature_comparison => 'So sánh tính năng';

  @override
  String get feature => 'Tính năng';

  @override
  String get free => 'Miễn phí';

  @override
  String get premium => 'Cao cấp';

  @override
  String get no_ads => 'Không quảng cáo';

  @override
  String get transaction_locking => 'Khóa sổ giao dịch';

  @override
  String get unlimited_scans => 'Quét hóa đơn không giới hạn';

  @override
  String get unlimited_voice_entries => 'Nhập giọng nói không giới hạn';

  @override
  String get day => 'ngày';

  @override
  String get accept_terms_conditions =>
      'Đăng ký tự động gia hạn. Bằng cách tiếp tục, bạn đồng ý với Điều khoản Dịch vụ và Chính sách Quyền riêng tư của chúng tôi.';

  @override
  String get restore => 'Khôi phục';

  @override
  String get select_language => 'Chọn ngôn ngữ';

  @override
  String get suggested => 'Gợi ý';

  @override
  String get all_languages => 'Tất cả ngôn ngữ';

  @override
  String get apply_changes => 'Áp dụng thay đổi';

  @override
  String get select_currency => 'Chọn tiền tệ';

  @override
  String get search_currency => 'Tìm kiếm tiền tệ hoặc quốc gia...';

  @override
  String get popular => 'Phổ biến';

  @override
  String get all_currencies => 'Tất cả tiền tệ';

  @override
  String get currency_change_warning =>
      'Thay đổi tiền tệ chỉ cập nhật ký hiệu hiển thị. Tỷ giá giao dịch trước đó sẽ không được tính toán lại.';

  @override
  String get data_management => 'Quản lý dữ liệu';

  @override
  String get select_format => 'Chọn định dạng';

  @override
  String get export_data => 'Xuất dữ liệu';

  @override
  String get export_data_description =>
      'Xuất dữ liệu tài chính của bạn để sao lưu hoặc phân tích.';

  @override
  String get confirm_export => 'Xác nhận xuất';

  @override
  String get import_data => 'Nhập dữ liệu';

  @override
  String get import_data_description =>
      'Nhập dữ liệu tài chính của bạn từ tệp sao lưu.';

  @override
  String get confirm_import => 'Xác nhận nhập';

  @override
  String get csv_format => 'Định dạng CSV';

  @override
  String get csv_description =>
      'Dữ liệu được phân tách bằng dấu phẩy, tương thích với hầu hết các ứng dụng bảng tính.';

  @override
  String get json_format => 'Định dạng JSON';

  @override
  String get json_description =>
      'Định dạng dữ liệu linh hoạt, lý tưởng cho việc trao đổi dữ liệu giữa các ứng dụng.';

  @override
  String get excel_format => 'Định dạng Excel';

  @override
  String get excel_description =>
      'Định dạng bảng tính phổ biến, hỗ trợ các tính năng nâng cao và phân tích dữ liệu.';

  @override
  String get select_file => 'Chọn tệp';

  @override
  String get no_file_selected => 'Chưa chọn tệp nào';

  @override
  String get import_successful => 'Nhập dữ liệu thành công!';

  @override
  String get error_importing_data => 'Lỗi khi nhập dữ liệu.';

  @override
  String get card => 'Thẻ';

  @override
  String get reminder_title => 'Nhắc nhở chi tiêu hàng ngày';

  @override
  String get reminder_body => 'Bạn đã ghi chép chi tiêu hôm nay chưa? 💸';

  @override
  String get defaultTransactionTitle => 'Giao dịch mới';

  @override
  String get invoice_analysis => 'Đang phân tích hóa đơn ...';
}
