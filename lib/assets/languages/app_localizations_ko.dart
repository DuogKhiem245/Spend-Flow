// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get app_name => 'SpendFlow';

  @override
  String get ok => '좋아요';

  @override
  String get cancel => '취소';

  @override
  String get skip => '건너뛰다';

  @override
  String get next => '다음';

  @override
  String get confirm => '확인하다';

  @override
  String get save => '구하다';

  @override
  String get edit => '편집하다';

  @override
  String get delete => '삭제';

  @override
  String get yes => '예';

  @override
  String get no => '아니요';

  @override
  String get done => '완료';

  @override
  String get close => '닫다';

  @override
  String get back => '뒤쪽에';

  @override
  String get start => '시작';

  @override
  String get continueAction => '계속하다';

  @override
  String get view_all => '모두 보기';

  @override
  String get see_all => '모두 보기';

  @override
  String get amount => '양';

  @override
  String get name => '이름';

  @override
  String get date => '날짜';

  @override
  String get month => '월';

  @override
  String get life_time => '일생';

  @override
  String get today => '오늘';

  @override
  String get other => '다른';

  @override
  String get home => '집';

  @override
  String get reports => '보고서';

  @override
  String get budgets => '예산';

  @override
  String get all => '모두';

  @override
  String get error => '오류';

  @override
  String get user => '사용자';

  @override
  String get success => '성공';

  @override
  String get loading => '로드 중...';

  @override
  String get onboard_step1_title => '스냅으로 녹음하기';

  @override
  String get onboard_step1_message =>
      '더 빠른 로깅을 위해 지출 위치를 자동으로 감지합니다. 다시는 돈이 어디로 갔는지 궁금해하지 마세요.';

  @override
  String get onboard_step2_title => '지갑을 마스터하세요';

  @override
  String get onboard_step2_message =>
      '카테고리별로 지출 한도를 설정하세요. 귀하의 재정적 목표를 계속해서 추적해 드리겠습니다.';

  @override
  String get onboard_step3_title => '건강한 습관을 기르세요';

  @override
  String get onboard_step3_message =>
      '매일 알림을 받아 거래를 놓치지 마세요. 일관성은 재정적 자유의 열쇠입니다.';

  @override
  String get create_first_wallet => '첫 번째 지갑 만들기';

  @override
  String get welcome_create_wallet =>
      '지출 흐름에 오신 것을 환영합니다!\n시작하려면 첫 번째 지갑을 만들어 보겠습니다.';

  @override
  String get enter_wallet_name => '지갑 이름을 입력하세요';

  @override
  String get eg_my_wallet => '예: 내 지갑, 현금, 신용카드';

  @override
  String get currency_unit => '화폐 단위';

  @override
  String get create_wallet => '지갑 생성';

  @override
  String get please_enter_wallet_name => '지갑 이름을 입력해주세요.';

  @override
  String get add_wallet => '새 지갑 추가';

  @override
  String get wallet_name => '지갑 이름';

  @override
  String get add_wallet_description => '더 많은 지갑을 추가하여 재정을 보다 효과적으로 관리하고 추적하세요.';

  @override
  String get cannot_delete_last_wallet => '마지막 지갑은 삭제할 수 없습니다.';

  @override
  String get delete_wallet => '지갑 삭제';

  @override
  String delete_wallet_confirmation(String walletName) {
    return '정말로 \'$walletName\' 지갑을 삭제하시겠습니까? 이 작업은 취소할 수 없습니다.';
  }

  @override
  String get in_use => '사용 중';

  @override
  String get incomplete_details => '불완전한 세부정보';

  @override
  String get please_fill_required_fields => '계속 진행하려면 다음 필수 입력란을 작성하세요.';

  @override
  String get select_wallet => '지갑 선택';

  @override
  String get please_create_wallet_first => '거래를 추가하기 전에 지갑을 생성해야 합니다.';

  @override
  String get create_now => '지금 만들기';

  @override
  String get no_wallets_yet => '아직 지갑이 없습니다';

  @override
  String get login => '로그인';

  @override
  String get register => '등록하다';

  @override
  String get logout => '로그아웃';

  @override
  String get email => '이메일';

  @override
  String get password => '비밀번호';

  @override
  String get new_password => '새 비밀번호';

  @override
  String get enter_email => '이메일을 입력하세요';

  @override
  String get enter_your_password => '비밀번호를 입력하세요';

  @override
  String get confirm_password => '비밀번호 확인';

  @override
  String get confirm_your_password => '비밀번호를 확인하세요';

  @override
  String get passwords_match => '비밀번호가 일치합니다.';

  @override
  String get passwords_mismatch => '비밀번호가 일치하지 않습니다.';

  @override
  String get forgot_password => '비밀번호를 잊으셨나요?';

  @override
  String get description_forgot_password => '비밀번호를 재설정하려면 계정과 연결된 이메일을 입력하세요.';

  @override
  String get send_otp => 'OTP 보내기';

  @override
  String get enter_otp => 'OTP 입력';

  @override
  String get resend => '재전송';

  @override
  String get verify => '확인하다';

  @override
  String get no_otp => '코드를 받지 못하셨나요?';

  @override
  String get verify_otp => 'OTP 확인';

  @override
  String get we_sent_otp =>
      'OTP 코드는 이메일을 확인하세요. 받은 편지함에 스팸 또는 정크 폴더가 표시되지 않으면 꼭 확인하세요.';

  @override
  String get dont_receive_otp => 'OTP를 받지 못하셨나요?';

  @override
  String get plese_enter_valid_otp => '유효한 OTP 코드를 입력하세요.';

  @override
  String get otp_resent => 'OTP 코드가 성공적으로 재전송되었습니다.';

  @override
  String get register_successful => '등록이 완료되었습니다!';

  @override
  String get register_successful_description =>
      '귀하의 계정이 성공적으로 생성되었습니다. 이제 자격 증명을 사용하여 로그인할 수 있습니다.';

  @override
  String get no_account => '계정이 없나요?';

  @override
  String get have_account => '이미 계정이 있나요?';

  @override
  String get login_error => '잘못된 이메일 또는 비밀번호';

  @override
  String get register_error => '등록 실패';

  @override
  String get create_account => '계정 만들기';

  @override
  String get create_password => '새 비밀번호 만들기';

  @override
  String get create_new_password => '거의 다 왔어요! 새 비밀번호를 만드세요.';

  @override
  String get or_continue_with => '아니면 계속해서';

  @override
  String sign_in_with(String provider) {
    return '$provider(으)로 로그인';
  }

  @override
  String get check_your_mail => '메일을 확인하세요';

  @override
  String get we_have_sent_mail => '다음 주소로 이메일을 보냈습니다.';

  @override
  String get please_check_your_mail_to_verify_account =>
      '로그인하기 전에 이메일을 확인하여 계정을 확인하세요.';

  @override
  String get register_failed => '등록 실패';

  @override
  String get please_fill_all_fields => '모든 필드를 작성해 주세요.';

  @override
  String get please_enter_email_and_password => '이메일과 비밀번호를 모두 입력해주세요.';

  @override
  String get incorrect_email_or_password => '이메일이나 비밀번호가 잘못되었습니다.';

  @override
  String get invalid_email_format => '이메일 형식이 잘못되었습니다.';

  @override
  String get this_account_has_been_disabled => '이 계정은 비활성화되었습니다.';

  @override
  String get too_many_requests_please_try_later =>
      '요청이 너무 많습니다. 나중에 다시 시도해 주세요.';

  @override
  String get email_not_verified => '이메일이 확인되지 않음';

  @override
  String get please_verify_your_email_to_continue => '계속하려면 이메일을 확인하세요.';

  @override
  String get are_you_sure_logout => '정말로 로그아웃하시겠습니까?';

  @override
  String get have_error_occurred => '오류가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get user_not_found => '이 이메일에는 계정이 없습니다.';

  @override
  String get enter_otp_reset_password =>
      '귀하의 이메일로 OTP 코드를 보냈습니다. 비밀번호 재설정을 위해 OTP를 입력해주세요.';

  @override
  String get not_time_yet_to_resend_otp => 'OTP 코드를 재전송하는 동안 잠시 기다려 주세요.';

  @override
  String get reset_password_successful => '비밀번호 재설정 성공';

  @override
  String get reset_password_successful_description =>
      '귀하의 비밀번호가 성공적으로 재설정되었습니다. 이제 새 비밀번호로 로그인하실 수 있습니다.';

  @override
  String get welcome_back => '돌아온 것을 환영합니다';

  @override
  String get back_login => '로그인으로 돌아가기';

  @override
  String get description_create_account => '오늘 당신의 재정을 관리해보세요';

  @override
  String get label_weak => '약한';

  @override
  String get label_fair => '공정한';

  @override
  String get label_good => '좋은';

  @override
  String get label_strong => '강한';

  @override
  String get low_pass => '숫자와 기호를 포함하여 8자 이상이어야 합니다.';

  @override
  String get weak_pass => '너무 짧습니다. 문자를 더 추가해주세요.';

  @override
  String get fair_pass => '더 나은. 숫자와 기호를 추가해보세요!';

  @override
  String get good_pass_char => '거의 다 왔어요! 특수문자를 추가하면 더욱 강력해집니다.';

  @override
  String get good_pass_num => '거의 다 왔어요! 더 강하게 만들려면 숫자를 추가하세요.';

  @override
  String get good_pass_special => '거의 다 왔어요! 캐릭터를 추가하면 더욱 강력해집니다.';

  @override
  String get strong_pass => '엄청난! 귀하의 비밀번호는 안전합니다.';

  @override
  String get password_reset_email_sent => '귀하의 이메일로 비밀번호 재설정 링크를 보내드렸습니다.';

  @override
  String get forgot_password_description => '비밀번호를 재설정하려면 계정과 연결된 이메일을 입력하세요.';

  @override
  String get send_email_reset => '이메일 재설정 보내기';

  @override
  String get password_weak_password => '제공된 비밀번호가 너무 취약합니다.';

  @override
  String get please_edit_fields => '계속하려면 다음 필드를 편집하십시오.';

  @override
  String get something_went_wrong => '문제가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get email_already_in_use => '해당 이메일 주소는 이미 다른 계정에서 사용 중입니다.';

  @override
  String get invalid_email => '이메일 주소가 유효하지 않습니다.';

  @override
  String get operation_not_allowed => '작업이 허용되지 않습니다. 지원팀에 문의하세요.';

  @override
  String get network_error => '네트워크 오류입니다. 연결을 확인하고 다시 시도해 주세요.';

  @override
  String get reset_password => '비밀번호 재설정';

  @override
  String get email_not_received => '이메일을 받지 못하셨나요?';

  @override
  String get verification_email_sent => '확인 이메일이 전송되었습니다';

  @override
  String get good_morning => '좋은 아침이에요';

  @override
  String get good_afternoon => '좋은 오후에요';

  @override
  String get good_evening => '좋은 저녁이에요';

  @override
  String get hello => '안녕하세요';

  @override
  String get income => '소득';

  @override
  String get expenses => '경비';

  @override
  String get balance => '균형';

  @override
  String get total_balance => '총 잔액';

  @override
  String get spending_this_month => '이번 달 지출';

  @override
  String get total_spent => '총 지출';

  @override
  String get recent_transactions => '최근 거래';

  @override
  String get add_transaction => '거래 추가';

  @override
  String get no_transactions => '사용 가능한 데이터가 없습니다.';

  @override
  String get enter_transaction_name => '거래명을 입력하세요';

  @override
  String get suggested_category => '추천 카테고리';

  @override
  String get category => '범주';

  @override
  String get categories => '카테고리';

  @override
  String get select_category => '카테고리 선택';

  @override
  String get edit_category => '카테고리 편집';

  @override
  String are_you_sure_delete_category(String categoryName) {
    return '$categoryName을(를) 삭제하시겠습니까?';
  }

  @override
  String get system_category => '시스템 카테고리는 삭제할 수 없습니다.';

  @override
  String get system_category_description => '이 기본 카테고리는 편집하거나 삭제할 수 없습니다.';

  @override
  String get category_food => '음식';

  @override
  String get category_transport => '수송';

  @override
  String get category_salary => '샐러리';

  @override
  String get category_shopping => '쇼핑';

  @override
  String get category_game => '게임';

  @override
  String get category_house => '집';

  @override
  String get category_gift => '선물';

  @override
  String get category_health => '건강';

  @override
  String get category_entertainment => '오락';

  @override
  String get category_bill => '청구서';

  @override
  String get category_insurance => '보험';

  @override
  String get category_education => '교육';

  @override
  String get category_pet => '애완 동물';

  @override
  String get category_travel => '여행하다';

  @override
  String get category_savings => '저금';

  @override
  String get category_phone => '핸드폰';

  @override
  String get category_internet => '인터넷';

  @override
  String get category_water => '물';

  @override
  String get category_electricity => '전기';

  @override
  String get category_gas => '가스';

  @override
  String get category_cleaning => '청소';

  @override
  String get category_beauty => '아름다움';

  @override
  String get category_baby => '아기';

  @override
  String get category_sport => '스포츠';

  @override
  String get category_music => '음악';

  @override
  String get category_repair => '수리하다';

  @override
  String get category_tax => '세';

  @override
  String get note => '참고(선택사항)';

  @override
  String get enter_note => '메모 입력';

  @override
  String get add_income => '소득 추가';

  @override
  String get add_expense => '비용 추가';

  @override
  String get search_category => '카테고리 검색';

  @override
  String get no_category_found => '카테고리를 찾을 수 없습니다';

  @override
  String get most_used => '가장 많이 사용됨';

  @override
  String get category_suggestions => '카테고리 제안';

  @override
  String get all_categories => '모든 카테고리';

  @override
  String get new_category => '새 카테고리';

  @override
  String get category_name => '카테고리 이름';

  @override
  String get category_color => '카테고리 색상';

  @override
  String get category_icon => '카테고리 아이콘';

  @override
  String get vs_last_month => '지난달 대비';

  @override
  String get transaction => '거래';

  @override
  String get delete_transaction => '거래 삭제';

  @override
  String get delete_transaction_confirmation => '정말로 이 거래를 삭제하시겠습니까?';

  @override
  String get transaction_details => '거래 세부정보';

  @override
  String get spending_trend => '지출 동향';

  @override
  String get spending_last_7_days => '지난 7일 동안의 지출';

  @override
  String get note_2 => '메모';

  @override
  String get scan_receipt => '영수증 스캔';

  @override
  String get add_via_voice => '음성으로 추가';

  @override
  String get add_manually => '수동으로 추가';

  @override
  String get limit_reached => '한도 도달';

  @override
  String limit_reached_description(String featureName, String limit) {
    return '오늘$featureName$limit회 사용하셨습니다.\n내일 다시 방문하거나 프리미엄으로 업그레이드하세요.';
  }

  @override
  String get align_receipt => '영수증을 정렬하세요';

  @override
  String get listening => '청취...';

  @override
  String get voice_example => '예를 들어 식료품 구입에 50달러를 썼습니다.';

  @override
  String get tap_to_stop => '중지하려면 탭하세요.';

  @override
  String get tap_to_listen => '탭하여 듣기';

  @override
  String get yesterday => '어제';

  @override
  String get your_monthly_budget => '귀하의 월예산';

  @override
  String get spent => '지출';

  @override
  String get out_of => '밖으로';

  @override
  String get left_to_spend => '남은 지출';

  @override
  String get add_budget => '예산 추가';

  @override
  String get no_budgets_yet => '아직 예산이 없습니다.';

  @override
  String get create_budget_description => '지출 한도를 설정하려면 +를 탭하세요.';

  @override
  String get edit_budget => '예산 수정';

  @override
  String are_you_sure_delete_budget(String budgetName) {
    return '삭제하시겠습니까?$budgetName?';
  }

  @override
  String get delete_budget => '예산 삭제';

  @override
  String get settings => '설정';

  @override
  String get settings_description => '모든 기기에서 금융 데이터를 동기화된 상태로 유지하세요';

  @override
  String get sign_in_now => '지금 로그인하세요';

  @override
  String get get_started => '시작하기';

  @override
  String get welcome => '환영 !';

  @override
  String get general => '일반적인';

  @override
  String get security => '보안';

  @override
  String get privacy_and_security => '개인 정보 보호 및 보안';

  @override
  String get support => '지원하다';

  @override
  String get profile => '윤곽';

  @override
  String get language => '언어';

  @override
  String get dark_mode => '다크 모드';

  @override
  String get notifications => '알림';

  @override
  String get appearance => '모습';

  @override
  String get currency => '통화';

  @override
  String get about => '에 대한';

  @override
  String get terms_of_service => '서비스 약관';

  @override
  String get privacy_policy => '개인 정보 보호 정책';

  @override
  String get version => '버전';

  @override
  String get edit_profile => '프로필 편집';

  @override
  String get full_name => '성명';

  @override
  String get enter_full_name => '이름을 입력하세요';

  @override
  String get email_address => '이메일 주소';

  @override
  String get enter_email_address => '이메일 주소를 입력하세요';

  @override
  String get phone_number => '전화 번호';

  @override
  String get enter_phone_number => '전화번호를 입력하세요';

  @override
  String get day_of_birth => '생일';

  @override
  String get select_day_of_birth => '생년월일 선택';

  @override
  String get save_changes => '변경 사항 저장';

  @override
  String get profile_updated_success => '프로필이 업데이트되었습니다!';

  @override
  String get error_updating_profile => '프로필을 업데이트하는 중에 오류가 발생했습니다.';

  @override
  String get error_uploading_avatar => '아바타를 업로드하는 중에 오류가 발생했습니다.';

  @override
  String get require_premium_to_edit_avatar =>
      '아바타를 편집하려면 프리미엄으로 업그레이드하거나 광고를 시청해야 합니다.';

  @override
  String get edit_avatar => '아바타 편집';

  @override
  String get upgrade_premium => '프리미엄으로 업그레이드하세요!';

  @override
  String get upgrade_premium_description => '독점 기능을 잠금 해제하고 경험을 향상하세요.';

  @override
  String get upgrade_now => '지금 업그레이드';

  @override
  String get you_are_premium => '모든 준비가 완료되었습니다, 프리미엄 사용자님!';

  @override
  String get you_are_premium_description => '향상된 경험을 즐겨보세요.';

  @override
  String get import_export_data => '데이터 가져오기/내보내기';

  @override
  String get sync_data => '데이터 동기화';

  @override
  String continue_with(String price) {
    return '$price로 계속';
  }

  @override
  String get biometric_authentication => '생체인증';

  @override
  String get password_security => '비밀번호 보안';

  @override
  String get face_id_description =>
      '한 눈에 앱의 잠금을 해제하세요. Face ID는 고유한 얼굴 특징을 사용하여 편리하고 안전한 액세스를 제공합니다.';

  @override
  String get touch_id_description =>
      '터치 한 번으로 앱의 잠금을 해제하세요. Touch ID는 지문을 사용하여 빠르고 안전하게 액세스할 수 있습니다.';

  @override
  String get pass_code_description =>
      '추가 보호 계층을 추가하세요. 비밀번호를 사용하면 기기가 손상되더라도 본인만 금융 데이터에 액세스할 수 있습니다.';

  @override
  String get passcode => '비밀번호';

  @override
  String get change_passcode => '비밀번호 변경';

  @override
  String get old_passcode => '이전 비밀번호';

  @override
  String get enter_old_passcode => '이전 비밀번호를 입력하세요';

  @override
  String get new_passcode => '새 비밀번호';

  @override
  String get enter_new_passcode => '새 비밀번호를 입력하세요';

  @override
  String get confirm_new_passcode => '새 비밀번호 확인';

  @override
  String get enter_confirm_new_passcode => '새 비밀번호 확인을 입력하세요.';

  @override
  String get turnOffPasscode => '비밀번호 끄기';

  @override
  String get createPasscode => '비밀번호 생성';

  @override
  String get changePasscode => '비밀번호 변경';

  @override
  String get removePasscode => '비밀번호 제거';

  @override
  String get updatePasscode => '비밀번호 업데이트';

  @override
  String get description_create_passcode => '6자리 비밀번호를 정기적으로 업데이트하여 계정을 보호하세요.';

  @override
  String get description_remove_passcode => '보안을 비활성화하려면 현재 비밀번호를 입력하세요.';

  @override
  String get currentPasscode => '현재 비밀번호';

  @override
  String get enterCurrentPin => '현재 PIN을 입력하세요';

  @override
  String get passcode_turn_off_success => '비밀번호가 성공적으로 꺼졌습니다!';

  @override
  String get passcode_update_success => '비밀번호가 성공적으로 업데이트되었습니다!';

  @override
  String get passcode_create_success => '비밀번호가 성공적으로 생성되었습니다!';

  @override
  String get currentPasscodeIncorrect => '현재 비밀번호가 올바르지 않습니다.';

  @override
  String get errorSavingData => '데이터를 저장하는 중에 오류가 발생했습니다.';

  @override
  String get newPasscodeMustBe6Digits => '새 비밀번호는 6자리여야 합니다.';

  @override
  String get passcodesDoNotMatch => '비밀번호가 일치하지 않습니다.';

  @override
  String get enter_passcode => '비밀번호 입력';

  @override
  String get incorrect_passcode => '잘못된 비밀번호입니다.';

  @override
  String get face => '페이스 아이디';

  @override
  String get fingerprint => '지문';

  @override
  String get report_locked => '잠긴 콘텐츠';

  @override
  String get unlock => '터놓다';

  @override
  String get click_to_unlock => '잠금을 해제하려면 클릭하세요.';

  @override
  String get unlock_untilimited_access => '무제한 액세스 잠금 해제';

  @override
  String get unlock_untilimited_access_description =>
      '모든 제한을 제거하고 고급 기능에 액세스하려면 프리미엄으로 업그레이드하세요.';

  @override
  String get daily_input_cap_reached => '일일 입력 한도 도달';

  @override
  String get daily_input_cap_reached_description =>
      '송장 스캔 및 음성 입력에 대한 일일 한도에 도달했습니다. 계속하려면 지금 업그레이드하세요.';

  @override
  String get feature_comparison => '기능 비교';

  @override
  String get feature => '특징';

  @override
  String get free => '무료';

  @override
  String get premium => '프리미엄';

  @override
  String get no_ads => '광고 없음';

  @override
  String get transaction_locking => '거래 잠금';

  @override
  String get unlimited_scans => '무제한 송장 스캔';

  @override
  String get unlimited_voice_entries => '무제한 음성 입력';

  @override
  String get day => '낮';

  @override
  String get year => '년도';

  @override
  String get subscription_auto_renews => '구독이 자동 갱신됩니다.';

  @override
  String get accept_terms_conditions =>
      '구독이 자동 갱신됩니다. 계속하면 서비스 약관 및 개인정보 보호정책에 동의하게 됩니다.';

  @override
  String get restore => '복원하다';

  @override
  String used_up_daily_limit(String value) {
    return '오늘의 음성 입력 한도를 모두 사용했습니다. 광고를 시청하여$value더 많이 사용하거나 Premium으로 업그레이드하세요.';
  }

  @override
  String get monthly_plan => '월간 요금제';

  @override
  String get yearly_plan => '연간 요금제';

  @override
  String get lifetime_plan => '평생 계획';

  @override
  String get pay_once_enjoy_forever => '한 번만 지불하면 영원히 즐길 수 있습니다';

  @override
  String get yearly_discount => '연간 요금제로 20% 할인';

  @override
  String get best_value => '최고의 가치';

  @override
  String get transaction_cancelled => '거래가 취소되었습니다.';

  @override
  String get purchase_successful => '구매 성공!';

  @override
  String get purchase_successful_description =>
      '프리미엄으로 업그레이드해주셔서 감사합니다! 향상된 경험을 즐겨보세요.';

  @override
  String get restore_successful => '복원 성공!';

  @override
  String get restore_successful_description =>
      '이전 구매가 복원되었습니다. 프리미엄 기능을 즐겨보세요!';

  @override
  String get nothing_to_restore => '복원할 항목이 없습니다.';

  @override
  String get nothing_to_restore_description => '복원할 이전 구매 항목이 없습니다.';

  @override
  String get restore_failed => '복원 실패';

  @override
  String get restore_failed_description =>
      '구매를 복원하는 중에 오류가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get purchase_failed => '구매 실패';

  @override
  String get purchase_failed_description => '거래 중에 오류가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get purchase_canceled => '구매가 취소되었습니다.';

  @override
  String get purchase_canceled_description =>
      '거래가 취소되었습니다. 귀하의 계정에 변경 사항이 없습니다.';

  @override
  String get premium_sync_account =>
      '귀하의 프리미엄 계정은 귀하가 로그인한 계정과 동기화됩니다. 원활한 프리미엄 경험을 위해 모든 기기에서 동일한 계정으로 로그인하시기 바랍니다.';

  @override
  String get premium_sync_warning =>
      '참고: 다른 계정으로 프리미엄 패키지를 구매한 경우 해당 계정으로 로그인하여 프리미엄 액세스를 복원하세요. 동일한 계정을 사용하는 경우 구매를 복원하여 프리미엄 액세스를 동기화해 보세요.';

  @override
  String get select_language => '언어 선택';

  @override
  String get suggested => '제안';

  @override
  String get all_languages => '모든 언어';

  @override
  String get apply_changes => '변경 사항 적용';

  @override
  String get select_currency => '통화 선택';

  @override
  String get search_currency => '통화 또는 국가 검색...';

  @override
  String get popular => '인기 있는';

  @override
  String get all_currencies => '모든 통화';

  @override
  String get currency_change_warning =>
      '통화를 변경하면 표시 기호만 업데이트됩니다. 과거 거래율은 다시 계산되지 않습니다.';

  @override
  String see_ads(String additionalUses) {
    return '광고 보기(+$additionalUses사용)';
  }

  @override
  String get ads_loading => '광고 로드 중...';

  @override
  String get data_management => '데이터 관리';

  @override
  String get select_format => '형식 선택';

  @override
  String get export_data => '데이터 내보내기';

  @override
  String get export_data_description => '백업 또는 분석을 위해 재무 데이터를 내보냅니다.';

  @override
  String get confirm_export => '내보내기 확인';

  @override
  String get import_data => '데이터 가져오기';

  @override
  String get import_data_title => '당신의 것을 얻자';

  @override
  String get data => '데이터';

  @override
  String get import_data_title_2 => '안에.';

  @override
  String get import_data_description => '외부 소스에서 재무 데이터를 가져와 애플리케이션과 동기화합니다.';

  @override
  String get confirm_import => '가져오기 확인';

  @override
  String get csv_format => 'CSV 형식';

  @override
  String get csv_description => '대부분의 스프레드시트 애플리케이션과 호환되는 CSV 형식으로 데이터를 내보냅니다.';

  @override
  String get json_format => 'JSON 형식';

  @override
  String get json_description => '개발자와 고급 사용자에게 적합한 JSON 형식으로 데이터를 내보냅니다.';

  @override
  String get excel_format => '엑셀 형식';

  @override
  String get excel_description => '상세한 재무 분석에 이상적인 Excel 형식으로 데이터를 내보냅니다.';

  @override
  String get select_file => '파일 선택';

  @override
  String get no_file_selected => '선택한 파일이 없습니다.';

  @override
  String get import_successful => '가져오기 성공';

  @override
  String get error_importing_data =>
      '데이터를 가져오는 중에 오류가 발생했습니다. 파일 형식이 올바른지 확인하세요.';

  @override
  String get sync_data_now => '지금 동기화';

  @override
  String last_synced(String time) {
    return '마지막 동기화:$time';
  }

  @override
  String get syncing => '동기화 중...';

  @override
  String get never_synced => '동기화되지 않음';

  @override
  String get unauthenticated => '여러 기기에서 데이터를 동기화하려면 로그인하세요.';

  @override
  String sync_error(String error) {
    return '동기화 오류:$error';
  }

  @override
  String get premium_required_to_sync =>
      '데이터를 동기화하려면 프리미엄으로 업그레이드하거나 광고를 시청해야 합니다.';

  @override
  String get sync_in_progress => '동기화가 진행 중입니다. 잠시 기다려 주세요.';

  @override
  String cooldown(String time) {
    return '당신은 너무 빨리 행동하고 있습니다. 다시 동기화하기 전에$time을 기다려주세요.';
  }

  @override
  String get logout_delete_local_data_message =>
      '이 기기의 데이터를 삭제하시겠습니까? 동기화된 클라우드 데이터는 안전하게 유지됩니다.';

  @override
  String get keep_local_data => '아니요 그냥 로그아웃하세요';

  @override
  String get delete_local_data => '데이터 삭제';

  @override
  String get accepted_formats => '허용되는 형식';

  @override
  String get select_file_to_import => '가져올 파일을 선택하세요.';

  @override
  String get tap_to_browse => '기기나 클라우드를 탐색하려면 탭하세요.\n파일 저장.';

  @override
  String get protected => '보호됨';

  @override
  String get protected_description => '귀하의 데이터는 귀하의 장치를 떠나지 않으며 로컬에서 처리됩니다.';

  @override
  String get recent_imports => '최근 수입품';

  @override
  String get no_recent_imports => '최근 가져온 데이터가 없습니다.';

  @override
  String get invalid_format => '파일 형식이 잘못되었습니다.';

  @override
  String get import_success => '성공적으로 가져왔습니다!';

  @override
  String import_success_description(String count) {
    return '파일에서$count거래를 성공적으로 가져왔습니다.';
  }

  @override
  String get file_format_template => '파일 형식 템플릿';

  @override
  String download_sample_file(String format) {
    return '샘플 파일 다운로드$format';
  }

  @override
  String get card => '카드';

  @override
  String get font_selection => '글꼴 선택';

  @override
  String get select_font => '글꼴 선택';

  @override
  String get font => '세례반';

  @override
  String get font_description => '하루에 한 번의 거래로 \'부산월\'을 피할 수 있습니다.';

  @override
  String get reminder_title => '일일 비용 알림';

  @override
  String get reminder_body => '오늘 지출을 기록하셨나요? 💸';

  @override
  String get defaultTransactionTitle => '새로운 거래';

  @override
  String get invoice_analysis => '송장 분석 중...';

  @override
  String get mapbox_error => '지도 로딩 오류입니다. Mapbox 토큰 구성을 확인하세요.';

  @override
  String get location => '위치';

  @override
  String get current_location => '현재 위치';

  @override
  String get select_location => '위치 선택';

  @override
  String get no_location_selected => '선택한 위치가 없습니다.';

  @override
  String get search_location => '위치 검색...';

  @override
  String get tap_to_change_location => '위치를 변경하려면 탭하세요.';

  @override
  String get search_results => '검색결과';

  @override
  String get no_location_found => '위치를 찾을 수 없습니다.';

  @override
  String get recent_locations => '최근 위치';

  @override
  String get location_access_error => '위치 접근 오류';

  @override
  String get location_permission_denied => '위치 권한이 거부되었습니다.';

  @override
  String get location_permission_denied_description => '설정에서 위치 액세스를 활성화하세요.';

  @override
  String get notification_permission_denied => '알림 권한이 거부되었습니다.';

  @override
  String get notification_permission_denied_description =>
      '알림을 받으려면 설정에서 알림 액세스를 활성화하세요.';

  @override
  String get permission_required_camera => '카메라 액세스가 거부되었습니다.';

  @override
  String get permission_required_camera_description =>
      '영수증 스캔 기능을 사용하려면 설정에서 카메라 액세스를 활성화하세요.';

  @override
  String get voice_input_error => '음성 입력 오류입니다. 다시 시도해 주세요.';

  @override
  String get voice_input_not_recognized => '음성 입력이 인식되지 않습니다. 다시 시도해 주세요.';

  @override
  String get voice_input_permission_denied =>
      '음성 입력 권한이 거부되었습니다. 설정에서 마이크 액세스를 활성화하세요.';

  @override
  String get error_ai_request => 'AI는 이 요청을 인식할 수 없습니다. 좀 더 구체적으로 설명해주세요.';

  @override
  String get voice_analysis => '음성 입력 분석 중...';

  @override
  String get scan_receipt_error => '영수증 스캔 오류입니다. 다시 시도해 주세요.';

  @override
  String get requires_premium => '이 기능을 사용하려면 광고를 시청하거나 프리미엄으로 업그레이드해야 합니다.';

  @override
  String get watch_ad_continue => '계속하려면 광고를 시청하세요';

  @override
  String get permission_required_voice_input => '마이크 액세스가 거부되었습니다.';

  @override
  String get permission_required_voice_input_description =>
      '음성 입력을 사용하려면 설정에서 마이크 액세스를 활성화하세요.';

  @override
  String get permission_required_location => '위치 액세스가 거부되었습니다.';

  @override
  String get permission_required_location_description =>
      '위치 기능을 사용하려면 설정에서 위치 액세스를 활성화하세요.';

  @override
  String get congratulations => '축하해요!';

  @override
  String get successfully_purchased => '프리미엄을 성공적으로 구매하셨습니다. 향상된 경험을 즐겨보세요!';

  @override
  String get cancel_purchase => '구매 취소';

  @override
  String get restore_no_purchase_description => '복원할 이전 구매 항목이 없습니다.';

  @override
  String get ai_powered => 'AI 기반';

  @override
  String get entries_pending => '출품작 대기 중';

  @override
  String get confirm_selected_entries => '선택한 항목 추가';

  @override
  String get preview_results => '결과 미리보기';

  @override
  String get clear_all => '모두 지우기';

  @override
  String get select_all => '모두 선택';

  @override
  String get fail_to_save_transactions => '거래를 저장하지 못했습니다. 다시 시도해 주세요.';

  @override
  String get tap_to_check_in => '탭하여 체크인하세요';

  @override
  String get keep_your_streak => '연속 행진을 유지하세요!';

  @override
  String keep_your_streak_day(String streak) {
    return '$streak-일 연속 기록을 유지하세요!';
  }

  @override
  String get streak => '줄';

  @override
  String streak_days(String days) {
    return '$days일';
  }

  @override
  String get not_logined => '로그인되지 않음';

  @override
  String get please_login_to_sync_data => '여러 기기에서 데이터를 동기화하려면 로그인하세요.';

  @override
  String get require_premium_to_sync =>
      '데이터를 동기화하려면 프리미엄으로 업그레이드하거나 광고를 시청해야 합니다.';

  @override
  String get information_and_support => '정보 및 지원';

  @override
  String get contact_support => '지원팀에 문의';

  @override
  String get send_email => '이메일 보내기';

  @override
  String get describe_issue =>
      '문제나 질문을 자세히 설명하세요. 우리 지원팀이 가능한 한 빨리 연락을 드릴 것입니다.';

  @override
  String get feedback => '피드백';

  @override
  String get feedback_description =>
      '우리는 SendFlow를 개선하는 데 도움이 되는 귀하의 생각과 제안을 듣고 싶습니다. 피드백을 공유해주세요!';

  @override
  String get thank_you_feedback => '피드백을 보내주셔서 감사합니다!';

  @override
  String get submit_feedback => '피드백 제출';

  @override
  String get report_issue => '문제 보고';

  @override
  String get submit_issue => '이슈 제출';

  @override
  String get report_issue_description =>
      '버그나 문제가 발생하면 여기에 보고해 주세요. 귀하의 의견은 모든 사람을 위해 앱을 개선하는 데 도움이 됩니다.';

  @override
  String get thank_you_issue => '문제를 신고해 주셔서 감사합니다! 최대한 빨리 조사해보겠습니다.';

  @override
  String get request_delete_account => '계정 삭제 요청';

  @override
  String get delete_account_description =>
      '계정을 삭제하고 싶다면 삭제하려는 이유를 알려주세요. 가능한 한 빨리 귀하의 요청을 처리해 드리겠습니다.';

  @override
  String get submit_delete_request => '요청 제출';

  @override
  String get select_subject => '주제 선택';

  @override
  String get please_enter_content => '내용을 입력해주세요';

  @override
  String get subject => '주제';

  @override
  String get content => '콘텐츠';

  @override
  String get send_contact_success => '귀하의 메시지가 성공적으로 전송되었습니다! 최대한 빨리 연락드리겠습니다.';

  @override
  String get send_contact_error => '메시지를 보내는 동안 오류가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get contact_info => '연락처 정보';

  @override
  String get email_placeholder => '이메일을 입력하세요';

  @override
  String get name_placeholder => '이름을 입력하세요';

  @override
  String get invalid_name => '올바른 이름을 입력하세요.';

  @override
  String get mrs => '부인';

  @override
  String get mr => '씨.';

  @override
  String get ms => '부인';

  @override
  String get salutation => '인사말';

  @override
  String get delete_account => '계정 삭제';

  @override
  String get delete_account_confirmation =>
      '정말로 계정을 삭제하시겠습니까? 이 작업은 취소할 수 없으며 모든 데이터가 삭제됩니다.';

  @override
  String get failed_to_send_deletion_request =>
      '계정 삭제 요청을 보내지 못했습니다. 다시 시도해 주세요.';

  @override
  String get requires_recent_login_description =>
      '보안상의 이유로 계정 삭제를 시도하기 전에 로그아웃했다가 다시 로그인하십시오.';

  @override
  String get delete_account_failed => '계정을 삭제하는 동안 오류가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get left => '왼쪽';

  @override
  String get edit_transaction => '거래 편집';

  @override
  String get save_expense_change => '비용 업데이트';

  @override
  String get save_income_change => '소득 업데이트';

  @override
  String get transaction_updated => '거래가 성공적으로 업데이트되었습니다.';

  @override
  String get bank_sync => '은행 동기화';

  @override
  String get bank_sync_description => '은행 계좌 거래 피드 자동 연결 및 동기화';

  @override
  String get coming_soon => '출시 예정';

  @override
  String get feature_under_development =>
      '이 기능은 현재 개발 중이며 향후 업데이트에서 사용할 수 있습니다!';

  @override
  String get remaining_budget => '남은 예산';

  @override
  String get monthly_spending => '월간 지출 차트';

  @override
  String get quick_add_voice => '탭하여 말하세요';

  @override
  String get ad_no_fill_title => '표시할 광고 없음';

  @override
  String get ad_no_fill_message =>
      '현재 표시할 수 있는 광고가 없습니다. 잠시 후 다시 시도하거나 Premium으로 업그레이드하세요.';

  @override
  String get ad_network_error_title => '네트워크 오류';

  @override
  String get ad_network_error_message =>
      '광고를 로드할 수 없습니다. 네트워크 연결을 확인하고 다시 시도하세요.';

  @override
  String get ad_load_failed_title => '광고 로드 실패';

  @override
  String get ad_load_failed_message => '광고를 로드하는 동안 오류가 발생했습니다. 나중에 다시 시도하세요.';

  @override
  String get ad_show_failed_title => '표시 오류';

  @override
  String get ad_show_failed_message => '광고를 표시할 수 없습니다. 나중에 다시 시도하세요.';

  @override
  String get ad_loading_timeout_message => '광고 로드 시간이 초과되었습니다. 나중에 다시 시도하세요.';

  @override
  String get ad_preparing => '광고 준비 중...';
}
