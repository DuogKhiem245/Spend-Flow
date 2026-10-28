// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get app_name => 'SpendFlow';

  @override
  String get ok => '好的';

  @override
  String get cancel => '取消';

  @override
  String get skip => '跳过';

  @override
  String get next => '下一个';

  @override
  String get confirm => '确认';

  @override
  String get save => '节省';

  @override
  String get edit => '编辑';

  @override
  String get delete => '删除';

  @override
  String get yes => '是的';

  @override
  String get no => '不';

  @override
  String get done => '完毕';

  @override
  String get close => '关闭';

  @override
  String get back => '后退';

  @override
  String get start => '开始';

  @override
  String get continueAction => '继续';

  @override
  String get view_all => '查看全部';

  @override
  String get see_all => '查看全部';

  @override
  String get amount => '数量';

  @override
  String get name => '姓名';

  @override
  String get date => '日期';

  @override
  String get month => '月';

  @override
  String get life_time => '寿命';

  @override
  String get today => '今天';

  @override
  String get other => '其他';

  @override
  String get home => '家';

  @override
  String get reports => '报告';

  @override
  String get budgets => '预算';

  @override
  String get all => '全部';

  @override
  String get error => '错误';

  @override
  String get user => '用户';

  @override
  String get success => '成功';

  @override
  String get loading => '加载中...';

  @override
  String get onboard_step1_title => '瞬间记录';

  @override
  String get onboard_step1_message => '自动检测支出位置以加快记录速度。再也不用想知道你的钱去了哪里。';

  @override
  String get onboard_step2_title => '掌控你的钱包';

  @override
  String get onboard_step2_message => '为每个类别设置支出限额。我们将帮助您实现财务目标';

  @override
  String get onboard_step3_title => '养成健康的习惯';

  @override
  String get onboard_step3_message => '获取每日提醒，这样您就不会错过任何交易。一致性是财务自由的关键。';

  @override
  String get create_first_wallet => '创建您的第一个钱包';

  @override
  String get welcome_create_wallet => '欢迎来到消费流！\n让我们开始创建您的第一个钱包。';

  @override
  String get enter_wallet_name => '输入钱包名称';

  @override
  String get eg_my_wallet => '例如，我的钱包、现金、信用卡';

  @override
  String get currency_unit => '货币单位';

  @override
  String get create_wallet => '创建钱包';

  @override
  String get please_enter_wallet_name => '请输入钱包名称。';

  @override
  String get add_wallet => '添加新钱包';

  @override
  String get wallet_name => '钱包名称';

  @override
  String get add_wallet_description => '添加更多钱包以更有效地管理和跟踪您的财务状况。';

  @override
  String get cannot_delete_last_wallet => '您无法删除最后一个钱包。';

  @override
  String get delete_wallet => '删除钱包';

  @override
  String delete_wallet_confirmation(String walletName) {
    return '您确定要删除钱包“$walletName”吗？此操作无法撤消。';
  }

  @override
  String get in_use => '使用中';

  @override
  String get incomplete_details => '细节不完整';

  @override
  String get please_fill_required_fields => '请填写以下必填字段以继续：';

  @override
  String get select_wallet => '选择钱包';

  @override
  String get please_create_wallet_first => '在添加交易之前，您需要创建一个钱包。';

  @override
  String get create_now => '立即创建';

  @override
  String get no_wallets_yet => '还没有钱包';

  @override
  String get login => '登录';

  @override
  String get register => '登记';

  @override
  String get logout => '退出';

  @override
  String get email => '电子邮件';

  @override
  String get password => '密码';

  @override
  String get new_password => '新密码';

  @override
  String get enter_email => '输入您的电子邮件';

  @override
  String get enter_your_password => '输入您的密码';

  @override
  String get confirm_password => '确认密码';

  @override
  String get confirm_your_password => '确认您的密码';

  @override
  String get passwords_match => '密码匹配。';

  @override
  String get passwords_mismatch => '密码不匹配。';

  @override
  String get forgot_password => '忘记密码？';

  @override
  String get description_forgot_password => '输入与您的帐户关联的电子邮件以重置您的密码。';

  @override
  String get send_otp => '发送一次性密码';

  @override
  String get enter_otp => '输入一次性密码';

  @override
  String get resend => '重新发送';

  @override
  String get verify => '核实';

  @override
  String get no_otp => '没有收到代码？';

  @override
  String get verify_otp => '验证一次性密码';

  @override
  String get we_sent_otp =>
      '请检查您的电子邮件以获取 OTP 代码。如果您在收件箱中没有看到垃圾邮件或垃圾邮件文件夹，请不要忘记检查它。';

  @override
  String get dont_receive_otp => '没有收到 OTP？';

  @override
  String get plese_enter_valid_otp => '请输入有效的 OTP 代码。';

  @override
  String get otp_resent => 'OTP 代码重新发送成功。';

  @override
  String get register_successful => '注册成功！';

  @override
  String get register_successful_description => '您的帐户已成功创建。您现在可以使用您的凭据登录。';

  @override
  String get no_account => '没有帐户？';

  @override
  String get have_account => '已经有帐户？';

  @override
  String get login_error => '电子邮件或密码无效';

  @override
  String get register_error => '注册失败';

  @override
  String get create_account => '创建一个帐户';

  @override
  String get create_password => '创建新密码';

  @override
  String get create_new_password => '快到了！创建您的新密码。';

  @override
  String get or_continue_with => '或者继续';

  @override
  String sign_in_with(String provider) {
    return '使用$provider登录';
  }

  @override
  String get check_your_mail => '检查您的邮件';

  @override
  String get we_have_sent_mail => '我们已发送电子邮件至：';

  @override
  String get please_check_your_mail_to_verify_account =>
      '请在登录前检查您的电子邮件以验证您的帐户。';

  @override
  String get register_failed => '注册失败';

  @override
  String get please_fill_all_fields => '请填写所有字段。';

  @override
  String get please_enter_email_and_password => '请输入电子邮件和密码。';

  @override
  String get incorrect_email_or_password => '电子邮件或密码不正确。';

  @override
  String get invalid_email_format => '电子邮件格式无效。';

  @override
  String get this_account_has_been_disabled => '该帐户已被禁用。';

  @override
  String get too_many_requests_please_try_later => '请求太多。请稍后重试。';

  @override
  String get email_not_verified => '电子邮件未验证';

  @override
  String get please_verify_your_email_to_continue => '请验证您的电子邮件以继续。';

  @override
  String get are_you_sure_logout => '您确定要退出吗？';

  @override
  String get have_error_occurred => '发生错误。请再试一次。';

  @override
  String get user_not_found => '未找到此电子邮件的帐户。';

  @override
  String get enter_otp_reset_password =>
      '我们已将 OTP 代码发送到您的电子邮件。请输入一次性密码以重置您的密码。';

  @override
  String get not_time_yet_to_resend_otp => '请稍候，我们正在重新发送 OTP 代码。';

  @override
  String get reset_password_successful => '密码重置成功';

  @override
  String get reset_password_successful_description => '您的密码已成功重置。您现在可以使用新密码登录。';

  @override
  String get welcome_back => '欢迎回来';

  @override
  String get back_login => '返回登录';

  @override
  String get description_create_account => '今天就掌控您的财务';

  @override
  String get label_weak => '虚弱的';

  @override
  String get label_fair => '公平的';

  @override
  String get label_good => '好的';

  @override
  String get label_strong => '强的';

  @override
  String get low_pass => '必须至少 8 个字符，包含数字和符号。';

  @override
  String get weak_pass => '过短。请添加更多字符。';

  @override
  String get fair_pass => '更好的。尝试添加数字和符号！';

  @override
  String get good_pass_char => '快到了！添加特殊角色使其更强。';

  @override
  String get good_pass_num => '快到了！添加一个数字以使其更强。';

  @override
  String get good_pass_special => '快到了！添加任意角色以使其更强。';

  @override
  String get strong_pass => '伟大的！您的密码是安全的。';

  @override
  String get password_reset_email_sent => '我们已将密码重置链接发送到您的电子邮件。';

  @override
  String get forgot_password_description => '输入与您的帐户关联的电子邮件以重置您的密码。';

  @override
  String get send_email_reset => '发送电子邮件 重置';

  @override
  String get password_weak_password => '提供的密码太弱。';

  @override
  String get please_edit_fields => '请编辑以下字段以继续：';

  @override
  String get something_went_wrong => '出了点问题。请再试一次。';

  @override
  String get email_already_in_use => '该电子邮件地址已被其他帐户使用。';

  @override
  String get invalid_email => '该电子邮件地址无效。';

  @override
  String get operation_not_allowed => '不允许操作。请联系支持人员。';

  @override
  String get network_error => '网络错误。请检查您的连接并重试。';

  @override
  String get reset_password => '重置密码';

  @override
  String get email_not_received => '未收到电子邮件？';

  @override
  String get verification_email_sent => '验证邮件已发送';

  @override
  String get good_morning => '早上好';

  @override
  String get good_afternoon => '下午好';

  @override
  String get good_evening => '晚上好';

  @override
  String get hello => '你好';

  @override
  String get income => '收入';

  @override
  String get expenses => '开支';

  @override
  String get balance => '平衡';

  @override
  String get total_balance => '总余额';

  @override
  String get spending_this_month => '本月支出';

  @override
  String get total_spent => '总花费';

  @override
  String get recent_transactions => '最近交易';

  @override
  String get add_transaction => '添加交易';

  @override
  String get no_transactions => '无可用数据';

  @override
  String get enter_transaction_name => '输入交易名称';

  @override
  String get suggested_category => '推荐类别';

  @override
  String get category => '类别';

  @override
  String get categories => '类别';

  @override
  String get select_category => '选择类别';

  @override
  String get edit_category => '编辑类别';

  @override
  String are_you_sure_delete_category(String categoryName) {
    return '您确定要删除$categoryName吗？';
  }

  @override
  String get system_category => '系统类别无法删除。';

  @override
  String get system_category_description => '您无法编辑或删除此默认类别。';

  @override
  String get category_food => '食物';

  @override
  String get category_transport => '运输';

  @override
  String get category_salary => '薪水';

  @override
  String get category_shopping => '购物';

  @override
  String get category_game => '游戏';

  @override
  String get category_house => '房子';

  @override
  String get category_gift => '礼物';

  @override
  String get category_health => '健康';

  @override
  String get category_entertainment => '娱乐';

  @override
  String get category_bill => '账单';

  @override
  String get category_insurance => '保险';

  @override
  String get category_education => '教育';

  @override
  String get category_pet => '宠物';

  @override
  String get category_travel => '旅行';

  @override
  String get category_savings => '储蓄';

  @override
  String get category_phone => '电话';

  @override
  String get category_internet => '互联网';

  @override
  String get category_water => '水';

  @override
  String get category_electricity => '电';

  @override
  String get category_gas => '气体';

  @override
  String get category_cleaning => '打扫';

  @override
  String get category_beauty => '美丽';

  @override
  String get category_baby => '婴儿';

  @override
  String get category_sport => '运动';

  @override
  String get category_music => '音乐';

  @override
  String get category_repair => '维修';

  @override
  String get category_tax => '税';

  @override
  String get note => '注意（可选）';

  @override
  String get enter_note => '输入备注';

  @override
  String get add_income => '增加收入';

  @override
  String get add_expense => '添加费用';

  @override
  String get search_category => '搜索类别';

  @override
  String get no_category_found => '没有找到类别';

  @override
  String get most_used => '最常用';

  @override
  String get category_suggestions => '类别建议';

  @override
  String get all_categories => '所有类别';

  @override
  String get new_category => '新类别';

  @override
  String get category_name => '类别名称';

  @override
  String get category_color => '类别 颜色';

  @override
  String get category_icon => '类别图标';

  @override
  String get vs_last_month => '与上个月相比';

  @override
  String get transaction => '交易';

  @override
  String get delete_transaction => '删除交易';

  @override
  String get delete_transaction_confirmation => '您确定要删除此交易吗？';

  @override
  String get transaction_details => '交易详情';

  @override
  String get spending_trend => '消费趋势';

  @override
  String get spending_last_7_days => '过去 7 天内的支出';

  @override
  String get note_2 => '笔记';

  @override
  String get scan_receipt => '扫描收据';

  @override
  String get add_via_voice => '通过语音添加';

  @override
  String get add_manually => '手动添加';

  @override
  String get limit_reached => '已达到限制';

  @override
  String limit_reached_description(String featureName, String limit) {
    return '您今天已使用$featureName$limit次。\n请明天回来或升级到高级版。';
  }

  @override
  String get align_receipt => '对齐您的收据';

  @override
  String get listening => '听...';

  @override
  String get voice_example => '例如，我在杂货上花了 50 美元';

  @override
  String get tap_to_stop => '点击停止';

  @override
  String get tap_to_listen => '点击收听';

  @override
  String get yesterday => '昨天';

  @override
  String get your_monthly_budget => '您的每月预算';

  @override
  String get spent => '花费';

  @override
  String get out_of => '出于';

  @override
  String get left_to_spend => '留下来花费';

  @override
  String get add_budget => '添加预算';

  @override
  String get no_budgets_yet => '还没有预算';

  @override
  String get create_budget_description => '点击 + 创建支出限额';

  @override
  String get edit_budget => '编辑预算';

  @override
  String are_you_sure_delete_budget(String budgetName) {
    return '您确定要删除吗$budgetName？';
  }

  @override
  String get delete_budget => '删除预算';

  @override
  String get settings => '设置';

  @override
  String get settings_description => '让您的财务数据在所有设备上保持同步';

  @override
  String get sign_in_now => '立即登录';

  @override
  String get get_started => '开始使用';

  @override
  String get welcome => '欢迎 ！';

  @override
  String get general => '一般的';

  @override
  String get security => '安全';

  @override
  String get privacy_and_security => '隐私与安全';

  @override
  String get support => '支持';

  @override
  String get profile => '轮廓';

  @override
  String get language => '语言';

  @override
  String get dark_mode => '深色模式';

  @override
  String get notifications => '通知';

  @override
  String get appearance => '外貌';

  @override
  String get currency => '货币';

  @override
  String get about => '关于';

  @override
  String get terms_of_service => '服务条款';

  @override
  String get privacy_policy => '隐私政策';

  @override
  String get version => '版本';

  @override
  String get edit_profile => '编辑个人资料';

  @override
  String get full_name => '姓名';

  @override
  String get enter_full_name => '输入全名';

  @override
  String get email_address => '电子邮件';

  @override
  String get enter_email_address => '输入电子邮件地址';

  @override
  String get phone_number => '电话号码';

  @override
  String get enter_phone_number => '输入电话号码';

  @override
  String get day_of_birth => '出生日期';

  @override
  String get select_day_of_birth => '选择出生日期';

  @override
  String get save_changes => '保存更改';

  @override
  String get profile_updated_success => '个人资料更新成功！';

  @override
  String get error_updating_profile => '更新个人资料时出错。';

  @override
  String get error_uploading_avatar => '上传头像时出错。';

  @override
  String get require_premium_to_edit_avatar => '您需要升级到高级版或观看广告才能编辑您的头像。';

  @override
  String get edit_avatar => '编辑头像';

  @override
  String get upgrade_premium => '升级至高级版！';

  @override
  String get upgrade_premium_description => '解锁专属功能并增强您的体验。';

  @override
  String get upgrade_now => '立即升级';

  @override
  String get you_are_premium => '一切就绪，高级用户！';

  @override
  String get you_are_premium_description => '享受增强的体验。';

  @override
  String get import_export_data => '导入/导出数据';

  @override
  String get sync_data => '同步数据';

  @override
  String continue_with(String price) {
    return '继续$price';
  }

  @override
  String get biometric_authentication => '生物识别认证';

  @override
  String get password_security => '密码安全';

  @override
  String get face_id_description =>
      '一目了然地解锁您的应用程序。 Face ID 利用您独特的面部特征提供方便、安全的访问。';

  @override
  String get touch_id_description => '只需触摸即可解锁您的应用程序。 Touch ID 使用指纹提供快速、安全的访问。';

  @override
  String get pass_code_description =>
      '添加额外的保护层。即使您的设备受到威胁，密码也可确保只有您才能访问您的财务数据。';

  @override
  String get passcode => '密码';

  @override
  String get change_passcode => '更改密码';

  @override
  String get old_passcode => '旧密码';

  @override
  String get enter_old_passcode => '输入旧密码';

  @override
  String get new_passcode => '新密码';

  @override
  String get enter_new_passcode => '输入新密码';

  @override
  String get confirm_new_passcode => '确认新密码';

  @override
  String get enter_confirm_new_passcode => '输入确认新密码';

  @override
  String get turnOffPasscode => '关闭密码';

  @override
  String get createPasscode => '创建密码';

  @override
  String get changePasscode => '更改密码';

  @override
  String get removePasscode => '删除密码';

  @override
  String get updatePasscode => '更新密码';

  @override
  String get description_create_passcode => '通过定期更新您的 6 位密码来保护您的帐户。';

  @override
  String get description_remove_passcode => '输入您当前的密码以禁用安全性。';

  @override
  String get currentPasscode => '当前密码';

  @override
  String get enterCurrentPin => '输入当前 PIN 码';

  @override
  String get passcode_turn_off_success => '密码关闭成功！';

  @override
  String get passcode_update_success => '密码更新成功！';

  @override
  String get passcode_create_success => '密码创建成功！';

  @override
  String get currentPasscodeIncorrect => '当前密码不正确。';

  @override
  String get errorSavingData => '保存数据时出错。';

  @override
  String get newPasscodeMustBe6Digits => '新密码必须是 6 位数字。';

  @override
  String get passcodesDoNotMatch => '密码不匹配。';

  @override
  String get enter_passcode => '输入密码';

  @override
  String get incorrect_passcode => '密码不正确。';

  @override
  String get face => '人脸识别';

  @override
  String get fingerprint => '指纹';

  @override
  String get report_locked => '锁定内容';

  @override
  String get unlock => '开锁';

  @override
  String get click_to_unlock => '点击解锁';

  @override
  String get unlock_untilimited_access => '解锁无限访问';

  @override
  String get unlock_untilimited_access_description => '升级到高级版可消除所有限制并访问高级功能。';

  @override
  String get daily_input_cap_reached => '已达到每日投入上限';

  @override
  String get daily_input_cap_reached_description =>
      '您已达到发票扫描和语音输入的每日限制。立即升级以继续。';

  @override
  String get feature_comparison => '特性比较';

  @override
  String get feature => '特征';

  @override
  String get free => '自由的';

  @override
  String get premium => '优质的';

  @override
  String get no_ads => '无广告';

  @override
  String get transaction_locking => '交易锁定';

  @override
  String get unlimited_scans => '无限次发票扫描';

  @override
  String get unlimited_voice_entries => '无限语音输入';

  @override
  String get day => '天';

  @override
  String get year => '年';

  @override
  String get subscription_auto_renews => '订阅自动续订。';

  @override
  String get accept_terms_conditions => '订阅自动续订。继续即表示您同意我们的服务条款和隐私政策。';

  @override
  String get restore => '恢复';

  @override
  String used_up_daily_limit(String value) {
    return '您今天已用完语音输入限制。观看广告即可获得$value更多使用次数或升级到高级版。';
  }

  @override
  String get monthly_plan => '月度计划';

  @override
  String get yearly_plan => '年度计划';

  @override
  String get lifetime_plan => '终身计划';

  @override
  String get pay_once_enjoy_forever => '一次付费，终身享受';

  @override
  String get yearly_discount => '按年计划节省 20%';

  @override
  String get best_value => '最超值';

  @override
  String get transaction_cancelled => '交易已取消。';

  @override
  String get purchase_successful => '购买成功！';

  @override
  String get purchase_successful_description => '感谢您升级到高级版！享受增强的体验。';

  @override
  String get restore_successful => '恢复成功！';

  @override
  String get restore_successful_description => '您之前的购买已恢复。享受您的高级功能！';

  @override
  String get nothing_to_restore => '没有什么可恢复的';

  @override
  String get nothing_to_restore_description => '没有发现以前的购买可以恢复。';

  @override
  String get restore_failed => '恢复失败';

  @override
  String get restore_failed_description => '恢复购买时发生错误。请再试一次。';

  @override
  String get purchase_failed => '购买失败';

  @override
  String get purchase_failed_description => '交易期间发生错误。请再试一次。';

  @override
  String get purchase_canceled => '购买已取消';

  @override
  String get purchase_canceled_description => '交易被取消。您的帐户没有发生任何更改。';

  @override
  String get premium_sync_account =>
      '您的高级帐户将与您登录的帐户同步。请确保您在所有设备上使用同一帐户登录，以获得无缝的高级体验。';

  @override
  String get premium_sync_warning =>
      '注意：如果您使用其他帐户购买了高级套餐，请登录该帐户以恢复您的高级访问权限。如果您使用同一帐户，请尝试恢复购买以同步您的高级访问权限。';

  @override
  String get select_language => '选择语言';

  @override
  String get suggested => '建议';

  @override
  String get all_languages => '所有语言';

  @override
  String get apply_changes => '应用更改';

  @override
  String get select_currency => '选择货币';

  @override
  String get search_currency => '搜索货币或国家...';

  @override
  String get popular => '受欢迎的';

  @override
  String get all_currencies => '所有货币';

  @override
  String get currency_change_warning => '更改货币只会更新显示符号。过去的交易费率将不会重新计算。';

  @override
  String see_ads(String additionalUses) {
    return '查看广告（+$additionalUses使用）';
  }

  @override
  String get ads_loading => '广告加载中...';

  @override
  String get data_management => '数据管理';

  @override
  String get select_format => '选择格式';

  @override
  String get export_data => '导出数据';

  @override
  String get export_data_description => '导出您的财务数据以进行备份或分析。';

  @override
  String get confirm_export => '确认导出';

  @override
  String get import_data => '导入数据';

  @override
  String get import_data_title => '让我们得到你的';

  @override
  String get data => '数据';

  @override
  String get import_data_title_2 => '在。';

  @override
  String get import_data_description => '从外部来源导入财务数据以与应用程序同步。';

  @override
  String get confirm_import => '确认导入';

  @override
  String get csv_format => 'CSV 格式';

  @override
  String get csv_description => '以 CSV 格式导出数据，与大多数电子表格应用程序兼容。';

  @override
  String get json_format => 'JSON 格式';

  @override
  String get json_description => '以JSON格式导出数据，适合开发者和高级用户。';

  @override
  String get excel_format => 'Excel格式';

  @override
  String get excel_description => '以 Excel 格式导出数据，非常适合详细的财务分析。';

  @override
  String get select_file => '选择文件';

  @override
  String get no_file_selected => '未选择文件。';

  @override
  String get import_successful => '导入成功';

  @override
  String get error_importing_data => '导入数据时出错。请确保文件格式正确。';

  @override
  String get sync_data_now => '立即同步';

  @override
  String last_synced(String time) {
    return '最后同步：$time';
  }

  @override
  String get syncing => '正在同步...';

  @override
  String get never_synced => '从未同步';

  @override
  String get unauthenticated => '请登录以跨设备同步您的数据。';

  @override
  String sync_error(String error) {
    return '同步错误：$error';
  }

  @override
  String get premium_required_to_sync => '您需要升级到高级版或观看广告才能同步数据。';

  @override
  String get sync_in_progress => '正在同步，请稍候。';

  @override
  String cooldown(String time) {
    return '你动作太快了。请等待$time，然后再再次同步。';
  }

  @override
  String get logout_delete_local_data_message => '您想删除该设备上的数据吗？同步的云数据将保持安全。';

  @override
  String get keep_local_data => '不，只需退出';

  @override
  String get delete_local_data => '删除数据';

  @override
  String get accepted_formats => '接受的格式';

  @override
  String get select_file_to_import => '选择要导入的文件';

  @override
  String get tap_to_browse => '点击即可浏览您的设备或云\n文件的存储。';

  @override
  String get protected => '受保护';

  @override
  String get protected_description => '您的数据永远不会离开您的设备，并在本地进行处理。';

  @override
  String get recent_imports => '最近的进口';

  @override
  String get no_recent_imports => '没有最近的数据导入';

  @override
  String get invalid_format => '文件格式无效。';

  @override
  String get import_success => '导入成功！';

  @override
  String import_success_description(String count) {
    return '已成功从文件导入$count交易。';
  }

  @override
  String get file_format_template => '文件格式模板';

  @override
  String download_sample_file(String format) {
    return '下载示例文件$format';
  }

  @override
  String get card => '卡片';

  @override
  String get font_selection => '字体选择';

  @override
  String get select_font => '选择字体';

  @override
  String get font => '字体';

  @override
  String get font_description => '每天一笔交易，让“破产月”远离。';

  @override
  String get reminder_title => '每日费用提醒';

  @override
  String get reminder_body => '你今天的开支记好了吗？ 💸';

  @override
  String get defaultTransactionTitle => '新交易';

  @override
  String get invoice_analysis => '正在分析发票...';

  @override
  String get mapbox_error => '地图加载错误。请检查您的 Mapbox 令牌配置。';

  @override
  String get location => '地点';

  @override
  String get current_location => '当前位置';

  @override
  String get select_location => '选择位置';

  @override
  String get no_location_selected => '未选择地点';

  @override
  String get search_location => '搜索位置...';

  @override
  String get tap_to_change_location => '点击以更改位置';

  @override
  String get search_results => '搜索结果';

  @override
  String get no_location_found => '没有找到位置';

  @override
  String get recent_locations => '最近的地点';

  @override
  String get location_access_error => '位置访问错误';

  @override
  String get location_permission_denied => '位置权限被拒绝。';

  @override
  String get location_permission_denied_description => '请在设置中启用位置访问。';

  @override
  String get notification_permission_denied => '通知权限被拒绝。';

  @override
  String get notification_permission_denied_description =>
      '请在设置中启用通知访问权限以接收提醒。';

  @override
  String get permission_required_camera => '相机访问被拒绝';

  @override
  String get permission_required_camera_description => '请在设置中启用相机访问才能使用收据扫描功能。';

  @override
  String get voice_input_error => '语音输入错误。请再试一次。';

  @override
  String get voice_input_not_recognized => '无法识别语音输入。请再试一次。';

  @override
  String get voice_input_permission_denied => '语音输入权限被拒绝。请在设置中启用麦克风访问。';

  @override
  String get error_ai_request => 'AI无法识别这个请求。请尝试更具体。';

  @override
  String get voice_analysis => '正在分析语音输入...';

  @override
  String get scan_receipt_error => '收据扫描错误。请再试一次。';

  @override
  String get requires_premium => '此功能需要观看广告才能使用或升级到高级版。';

  @override
  String get watch_ad_continue => '观看广告以继续';

  @override
  String get permission_required_voice_input => '麦克风访问被拒绝';

  @override
  String get permission_required_voice_input_description =>
      '请在设置中启用麦克风访问才能使用语音输入。';

  @override
  String get permission_required_location => '位置访问被拒绝';

  @override
  String get permission_required_location_description => '请在设置中启用位置访问以使用位置功能。';

  @override
  String get congratulations => '恭喜！';

  @override
  String get successfully_purchased => '您已成功购买高级版。享受增强的体验！';

  @override
  String get cancel_purchase => '取消购买';

  @override
  String get restore_no_purchase_description => '没有发现以前的购买可以恢复。';

  @override
  String get ai_powered => '人工智能驱动';

  @override
  String get entries_pending => '参赛作品待定';

  @override
  String get confirm_selected_entries => '添加选定的条目';

  @override
  String get preview_results => '预览结果';

  @override
  String get clear_all => '全部清除';

  @override
  String get select_all => '选择全部';

  @override
  String get fail_to_save_transactions => '无法保存交易。请再试一次。';

  @override
  String get tap_to_check_in => '点按即可签到';

  @override
  String get keep_your_streak => '保持你的连胜！';

  @override
  String keep_your_streak_day(String streak) {
    return '保持$streak天的连续记录！';
  }

  @override
  String get streak => '条纹';

  @override
  String streak_days(String days) {
    return '$days天';
  }

  @override
  String get not_logined => '未登录';

  @override
  String get please_login_to_sync_data => '请登录以跨设备同步您的数据。';

  @override
  String get require_premium_to_sync => '您需要升级到高级版或观看广告才能同步数据。';

  @override
  String get information_and_support => '信息与支持';

  @override
  String get contact_support => '联系支持人员';

  @override
  String get send_email => '发送电子邮件';

  @override
  String get describe_issue => '详细描述您的问题或疑问。我们的支持团队将尽快与您联系。';

  @override
  String get feedback => '反馈';

  @override
  String get feedback_description =>
      '我们很想听听您的想法和建议，以帮助我们改进 SpendFlow。请与我们分享您的反馈！';

  @override
  String get thank_you_feedback => '感谢您的反馈！';

  @override
  String get submit_feedback => '提交反馈';

  @override
  String get report_issue => '报告问题';

  @override
  String get submit_issue => '提交问题';

  @override
  String get report_issue_description =>
      '如果您遇到任何错误或问题，请在此处报告。您的意见有助于我们为每个人改进应用程序。';

  @override
  String get thank_you_issue => '感谢您报告该问题！我们将尽快调查此事。';

  @override
  String get request_delete_account => '请求删除帐户';

  @override
  String get delete_account_description =>
      '如果您想删除您的帐户，请告诉我们您为什么要删除它。我们将尽快处理您的请求。';

  @override
  String get submit_delete_request => '提交请求';

  @override
  String get select_subject => '选择主题';

  @override
  String get please_enter_content => '请输入内容';

  @override
  String get subject => '主题';

  @override
  String get content => '内容';

  @override
  String get send_contact_success => '您的消息已发送成功！我们会尽快回复您。';

  @override
  String get send_contact_error => '发送您的消息时发生错误。请再试一次。';

  @override
  String get contact_info => '联系信息';

  @override
  String get email_placeholder => '输入您的电子邮件';

  @override
  String get name_placeholder => '输入你的名字';

  @override
  String get invalid_name => '请输入有效的名称。';

  @override
  String get mrs => '太太。';

  @override
  String get mr => '先生。';

  @override
  String get ms => '多发性硬化症。';

  @override
  String get salutation => '称呼';

  @override
  String get delete_account => '删除账户';

  @override
  String get delete_account_confirmation => '您确定要删除您的帐户吗？此操作无法撤消，并将删除您的所有数据。';

  @override
  String get failed_to_send_deletion_request => '无法发送帐户删除请求。请再试一次。';

  @override
  String get requires_recent_login_description =>
      '出于安全原因，请先退出并重新登录，然后再尝试删除您的帐户。';

  @override
  String get delete_account_failed => '删除您的帐户时发生错误。请再试一次。';

  @override
  String get left => '左边';

  @override
  String get edit_transaction => '编辑交易';

  @override
  String get save_expense_change => '更新费用';

  @override
  String get save_income_change => '更新收入';

  @override
  String get transaction_updated => '交易更新成功';

  @override
  String get bank_sync => '银行同步';

  @override
  String get bank_sync_description => '自动连接并同步银行账户交易源';

  @override
  String get coming_soon => '即将推出';

  @override
  String get feature_under_development => '此功能目前正在开发中，将在即将推出的更新中提供！';

  @override
  String get remaining_budget => '剩余预算';

  @override
  String get monthly_spending => '每月支出图表';

  @override
  String get quick_add_voice => '点击即可说话';

  @override
  String get ad_no_fill_title => '暂无广告';

  @override
  String get ad_no_fill_message => '当前暂无可用广告。请稍后再试或升级为高级版。';

  @override
  String get ad_network_error_title => '网络连接错误';

  @override
  String get ad_network_error_message => '无法连接以加载广告。请检查网络后重试。';

  @override
  String get ad_load_failed_title => '广告加载失败';

  @override
  String get ad_load_failed_message => '加载广告时发生错误。请稍后再试。';

  @override
  String get ad_show_failed_title => '显示错误';

  @override
  String get ad_show_failed_message => '无法显示广告。请稍后再试。';

  @override
  String get ad_loading_timeout_message => '广告加载超时。请稍后再试。';

  @override
  String get ad_preparing => '正在准备广告...';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get app_name => 'SpendFlow';

  @override
  String get ok => '好的';

  @override
  String get cancel => '取消';

  @override
  String get skip => '跳過';

  @override
  String get next => '下一個';

  @override
  String get confirm => '確認';

  @override
  String get save => '節省';

  @override
  String get edit => '編輯';

  @override
  String get delete => '刪除';

  @override
  String get yes => '是的';

  @override
  String get no => '不';

  @override
  String get done => '完畢';

  @override
  String get close => '關閉';

  @override
  String get back => '後退';

  @override
  String get start => '開始';

  @override
  String get continueAction => '繼續';

  @override
  String get view_all => '看全部';

  @override
  String get see_all => '看全部';

  @override
  String get amount => '數量';

  @override
  String get name => '姓名';

  @override
  String get date => '日期';

  @override
  String get month => '月';

  @override
  String get life_time => '壽命';

  @override
  String get today => '今天';

  @override
  String get other => '其他';

  @override
  String get home => '家';

  @override
  String get reports => '報告';

  @override
  String get budgets => '預算';

  @override
  String get all => '全部';

  @override
  String get error => '錯誤';

  @override
  String get user => '使用者';

  @override
  String get success => '成功';

  @override
  String get loading => '載入中...';

  @override
  String get onboard_step1_title => '瞬間記錄';

  @override
  String get onboard_step1_message => '自動偵測支出位置以加快記錄速度。再也不用想知道你的錢去了哪裡。';

  @override
  String get onboard_step2_title => '掌控你的錢包';

  @override
  String get onboard_step2_message => '為每個類別設定支出限額。我們將協助您實現財務目標';

  @override
  String get onboard_step3_title => '養成健康的習慣';

  @override
  String get onboard_step3_message => '取得每日提醒，這樣您就不會錯過任何交易。一致性是財務自由的關鍵。';

  @override
  String get create_first_wallet => '創建您的第一個錢包';

  @override
  String get welcome_create_wallet => '歡迎來到消費流！\n讓我們開始創建您的第一個錢包。';

  @override
  String get enter_wallet_name => '輸入錢包名稱';

  @override
  String get eg_my_wallet => '例如，我的錢包、現金、信用卡';

  @override
  String get currency_unit => '貨幣單位';

  @override
  String get create_wallet => '創建錢包';

  @override
  String get please_enter_wallet_name => '請輸入錢包名稱。';

  @override
  String get add_wallet => '新增錢包';

  @override
  String get wallet_name => '錢包名稱';

  @override
  String get add_wallet_description => '添加更多錢包以更有效地管理和追蹤您的財務狀況。';

  @override
  String get cannot_delete_last_wallet => '您無法刪除最後一個錢包。';

  @override
  String get delete_wallet => '刪除錢包';

  @override
  String delete_wallet_confirmation(String walletName) {
    return '您確定要刪除錢包「$walletName」嗎？此操作無法撤銷。';
  }

  @override
  String get in_use => '使用中';

  @override
  String get incomplete_details => '細節不完整';

  @override
  String get please_fill_required_fields => '請填寫以下必填欄位以繼續：';

  @override
  String get select_wallet => '選擇錢包';

  @override
  String get please_create_wallet_first => '在新增交易之前，您需要建立一個錢包。';

  @override
  String get create_now => '立即創建';

  @override
  String get no_wallets_yet => '還沒有錢包';

  @override
  String get login => '登入';

  @override
  String get register => '登記';

  @override
  String get logout => '退出';

  @override
  String get email => '電子郵件';

  @override
  String get password => '密碼';

  @override
  String get new_password => '新密碼';

  @override
  String get enter_email => '輸入您的電子郵件';

  @override
  String get enter_your_password => '輸入您的密碼';

  @override
  String get confirm_password => '確認密碼';

  @override
  String get confirm_your_password => '確認您的密碼';

  @override
  String get passwords_match => '密碼匹配。';

  @override
  String get passwords_mismatch => '密碼不符。';

  @override
  String get forgot_password => '忘記密碼？';

  @override
  String get description_forgot_password => '輸入與您的帳戶關聯的電子郵件以重設您的密碼。';

  @override
  String get send_otp => '發送一次性密碼';

  @override
  String get enter_otp => '輸入一次性密碼';

  @override
  String get resend => '重新發送';

  @override
  String get verify => '核實';

  @override
  String get no_otp => '沒有收到代碼？';

  @override
  String get verify_otp => '驗證一次性密碼';

  @override
  String get we_sent_otp =>
      '請檢查您的電子郵件以取得 OTP 代碼。如果您在收件匣中沒有看到垃圾郵件或垃圾郵件資料夾，請不要忘記檢查它。';

  @override
  String get dont_receive_otp => '沒有收到 OTP？';

  @override
  String get plese_enter_valid_otp => '請輸入有效的 OTP 碼。';

  @override
  String get otp_resent => 'OTP 代碼重新發送成功。';

  @override
  String get register_successful => '註冊成功！';

  @override
  String get register_successful_description => '您的帳戶已成功建立。現在您可以使用您的憑證登入。';

  @override
  String get no_account => '沒有帳戶？';

  @override
  String get have_account => '已經有帳戶？';

  @override
  String get login_error => '電子郵件或密碼無效';

  @override
  String get register_error => '註冊失敗';

  @override
  String get create_account => '建立一個帳戶';

  @override
  String get create_password => '建立新密碼';

  @override
  String get create_new_password => '快到了！建立您的新密碼。';

  @override
  String get or_continue_with => '或繼續';

  @override
  String sign_in_with(String provider) {
    return '使用$provider登入';
  }

  @override
  String get check_your_mail => '檢查您的郵件';

  @override
  String get we_have_sent_mail => '我們已發送電子郵件至：';

  @override
  String get please_check_your_mail_to_verify_account =>
      '請在登入前檢查您的電子郵件以驗證您的帳戶。';

  @override
  String get register_failed => '註冊失敗';

  @override
  String get please_fill_all_fields => '請填寫所有欄位。';

  @override
  String get please_enter_email_and_password => '請輸入電子郵件和密碼。';

  @override
  String get incorrect_email_or_password => '電子郵件或密碼不正確。';

  @override
  String get invalid_email_format => '電子郵件格式無效。';

  @override
  String get this_account_has_been_disabled => '該帳戶已被停用。';

  @override
  String get too_many_requests_please_try_later => '請求太多。請稍後重試。';

  @override
  String get email_not_verified => '電子郵件未驗證';

  @override
  String get please_verify_your_email_to_continue => '請驗證您的電子郵件以繼續。';

  @override
  String get are_you_sure_logout => '您確定要退出嗎？';

  @override
  String get have_error_occurred => '發生錯誤。請再試一次。';

  @override
  String get user_not_found => '未找到此電子郵件的帳號。';

  @override
  String get enter_otp_reset_password =>
      '我們已將 OTP 代碼傳送到您的電子郵件。請輸入一次性密碼以重設您的密碼。';

  @override
  String get not_time_yet_to_resend_otp => '請稍候，我們正在重新發送 OTP 代碼。';

  @override
  String get reset_password_successful => '密碼重置成功';

  @override
  String get reset_password_successful_description => '您的密碼已成功重設。現在您可以使用新密碼登入。';

  @override
  String get welcome_back => '歡迎回來';

  @override
  String get back_login => '返回登入';

  @override
  String get description_create_account => '今天就掌控您的財務';

  @override
  String get label_weak => '虛弱的';

  @override
  String get label_fair => '公平的';

  @override
  String get label_good => '好的';

  @override
  String get label_strong => '強的';

  @override
  String get low_pass => '必須至少 8 個字符，包含數字和符號。';

  @override
  String get weak_pass => '過短。請添加更多字元。';

  @override
  String get fair_pass => '更好的。嘗試添加數字和符號！';

  @override
  String get good_pass_char => '快到了！添加特殊角色使其更強。';

  @override
  String get good_pass_num => '快到了！添加一個數字以使其更強。';

  @override
  String get good_pass_special => '快到了！添加任意角色以使其更強。';

  @override
  String get strong_pass => '偉大的！您的密碼是安全的。';

  @override
  String get password_reset_email_sent => '我們已將密碼重設連結傳送到您的電子郵件。';

  @override
  String get forgot_password_description => '輸入與您的帳戶關聯的電子郵件以重設您的密碼。';

  @override
  String get send_email_reset => '傳送電子郵件 重置';

  @override
  String get password_weak_password => '提供的密碼太弱。';

  @override
  String get please_edit_fields => '請編輯以下欄位以繼續：';

  @override
  String get something_went_wrong => '出了點問題。請再試一次。';

  @override
  String get email_already_in_use => '該電子郵件地址已被其他帳號使用。';

  @override
  String get invalid_email => '該電子郵件地址無效。';

  @override
  String get operation_not_allowed => '不允許操作。請聯絡支援人員。';

  @override
  String get network_error => '網路錯誤。請檢查您的連線並重試。';

  @override
  String get reset_password => '重設密碼';

  @override
  String get email_not_received => '未收到電子郵件？';

  @override
  String get verification_email_sent => '驗證郵件已發送';

  @override
  String get good_morning => '早安';

  @override
  String get good_afternoon => '午安';

  @override
  String get good_evening => '晚安';

  @override
  String get hello => '你好';

  @override
  String get income => '收入';

  @override
  String get expenses => '開支';

  @override
  String get balance => '平衡';

  @override
  String get total_balance => '總餘額';

  @override
  String get spending_this_month => '本月支出';

  @override
  String get total_spent => '總花費';

  @override
  String get recent_transactions => '最近交易';

  @override
  String get add_transaction => '新增交易';

  @override
  String get no_transactions => '無可用數據';

  @override
  String get enter_transaction_name => '輸入交易名稱';

  @override
  String get suggested_category => '推薦類別';

  @override
  String get category => '類別';

  @override
  String get categories => '類別';

  @override
  String get select_category => '選擇類別';

  @override
  String get edit_category => '編輯類別';

  @override
  String are_you_sure_delete_category(String categoryName) {
    return '您確定要刪除$categoryName嗎？';
  }

  @override
  String get system_category => '系統類別無法刪除。';

  @override
  String get system_category_description => '您無法編輯或刪除此預設類別。';

  @override
  String get category_food => '食物';

  @override
  String get category_transport => '運輸';

  @override
  String get category_salary => '薪水';

  @override
  String get category_shopping => '購物';

  @override
  String get category_game => '遊戲';

  @override
  String get category_house => '房子';

  @override
  String get category_gift => '禮物';

  @override
  String get category_health => '健康';

  @override
  String get category_entertainment => '娛樂';

  @override
  String get category_bill => '帳單';

  @override
  String get category_insurance => '保險';

  @override
  String get category_education => '教育';

  @override
  String get category_pet => '寵物';

  @override
  String get category_travel => '旅行';

  @override
  String get category_savings => '儲蓄';

  @override
  String get category_phone => '電話';

  @override
  String get category_internet => '網際網路';

  @override
  String get category_water => '水';

  @override
  String get category_electricity => '電';

  @override
  String get category_gas => '氣體';

  @override
  String get category_cleaning => '打掃';

  @override
  String get category_beauty => '美麗';

  @override
  String get category_baby => '嬰兒';

  @override
  String get category_sport => '運動';

  @override
  String get category_music => '音樂';

  @override
  String get category_repair => '維修';

  @override
  String get category_tax => '稅';

  @override
  String get note => '注意（可選）';

  @override
  String get enter_note => '輸入備註';

  @override
  String get add_income => '增加收入';

  @override
  String get add_expense => '新增費用';

  @override
  String get search_category => '搜尋類別';

  @override
  String get no_category_found => '沒有找到類別';

  @override
  String get most_used => '最常用';

  @override
  String get category_suggestions => '類別建議';

  @override
  String get all_categories => '所有類別';

  @override
  String get new_category => '新類別';

  @override
  String get category_name => '類別名稱';

  @override
  String get category_color => '類別 顏色';

  @override
  String get category_icon => '類別圖示';

  @override
  String get vs_last_month => '與上個月相比';

  @override
  String get transaction => '交易';

  @override
  String get delete_transaction => '刪除交易';

  @override
  String get delete_transaction_confirmation => '您確定要刪除此交易嗎？';

  @override
  String get transaction_details => '交易詳情';

  @override
  String get spending_trend => '消費趨勢';

  @override
  String get spending_last_7_days => '過去 7 天內的支出';

  @override
  String get note_2 => '筆記';

  @override
  String get scan_receipt => '掃描收據';

  @override
  String get add_via_voice => '透過語音添加';

  @override
  String get add_manually => '手動新增';

  @override
  String get limit_reached => '已達到限制';

  @override
  String limit_reached_description(String featureName, String limit) {
    return '您今天已使用$featureName$limit次。\n請明天回來或升級到高級版。';
  }

  @override
  String get align_receipt => '對齊您的收據';

  @override
  String get listening => '聽...';

  @override
  String get voice_example => '例如，我在雜貨上花了 50 美元';

  @override
  String get tap_to_stop => '點擊停止';

  @override
  String get tap_to_listen => '點擊收聽';

  @override
  String get yesterday => '昨天';

  @override
  String get your_monthly_budget => '您的每月預算';

  @override
  String get spent => '花費';

  @override
  String get out_of => '出於';

  @override
  String get left_to_spend => '留下來花費';

  @override
  String get add_budget => '添加預算';

  @override
  String get no_budgets_yet => '還沒有預算';

  @override
  String get create_budget_description => '點擊 + 建立支出限額';

  @override
  String get edit_budget => '編輯預算';

  @override
  String are_you_sure_delete_budget(String budgetName) {
    return '您確定要刪除嗎$budgetName？';
  }

  @override
  String get delete_budget => '刪除預算';

  @override
  String get settings => '設定';

  @override
  String get settings_description => '讓您的財務資料在所有裝置上保持同步';

  @override
  String get sign_in_now => '立即登入';

  @override
  String get get_started => '開始使用';

  @override
  String get welcome => '歡迎 ！';

  @override
  String get general => '一般的';

  @override
  String get security => '安全';

  @override
  String get privacy_and_security => '隱私與安全';

  @override
  String get support => '支援';

  @override
  String get profile => '輪廓';

  @override
  String get language => '語言';

  @override
  String get dark_mode => '深色模式';

  @override
  String get notifications => '通知';

  @override
  String get appearance => '外貌';

  @override
  String get currency => '貨幣';

  @override
  String get about => '關於';

  @override
  String get terms_of_service => '服務條款';

  @override
  String get privacy_policy => '隱私權政策';

  @override
  String get version => '版本';

  @override
  String get edit_profile => '編輯個人資料';

  @override
  String get full_name => '姓名';

  @override
  String get enter_full_name => '輸入全名';

  @override
  String get email_address => '電子郵件';

  @override
  String get enter_email_address => '輸入電子郵件地址';

  @override
  String get phone_number => '電話號碼';

  @override
  String get enter_phone_number => '輸入電話號碼';

  @override
  String get day_of_birth => '出生日期';

  @override
  String get select_day_of_birth => '選擇出生日期';

  @override
  String get save_changes => '儲存變更';

  @override
  String get profile_updated_success => '個人資料更新成功！';

  @override
  String get error_updating_profile => '更新個人資料時發生錯誤。';

  @override
  String get error_uploading_avatar => '上傳頭像時發生錯誤。';

  @override
  String get require_premium_to_edit_avatar => '您需要升級到高級版或觀看廣告才能編輯您的頭像。';

  @override
  String get edit_avatar => '編輯頭像';

  @override
  String get upgrade_premium => '升級至高級版！';

  @override
  String get upgrade_premium_description => '解鎖專屬功能並增強您的體驗。';

  @override
  String get upgrade_now => '立即升級';

  @override
  String get you_are_premium => '一切就緒，高級用戶！';

  @override
  String get you_are_premium_description => '享受增強的體驗。';

  @override
  String get import_export_data => '導入/匯出數據';

  @override
  String get sync_data => '同步數據';

  @override
  String continue_with(String price) {
    return '繼續$price';
  }

  @override
  String get biometric_authentication => '生物辨識認證';

  @override
  String get password_security => '密碼安全';

  @override
  String get face_id_description =>
      '一目了然地解鎖您的應用程式。 Face ID 利用您獨特的臉部特徵提供方便、安全的存取。';

  @override
  String get touch_id_description => '只需觸摸即可解鎖您的應用程式。 Touch ID 使用指紋提供快速、安全的存取。';

  @override
  String get pass_code_description =>
      '添加額外的保護層。即使您的裝置受到威脅，密碼也可確保只有您才能存取您的財務資料。';

  @override
  String get passcode => '密碼';

  @override
  String get change_passcode => '更改密碼';

  @override
  String get old_passcode => '舊密碼';

  @override
  String get enter_old_passcode => '輸入舊密碼';

  @override
  String get new_passcode => '新密碼';

  @override
  String get enter_new_passcode => '輸入新密碼';

  @override
  String get confirm_new_passcode => '確認新密碼';

  @override
  String get enter_confirm_new_passcode => '輸入確認新密碼';

  @override
  String get turnOffPasscode => '關閉密碼';

  @override
  String get createPasscode => '建立密碼';

  @override
  String get changePasscode => '更改密碼';

  @override
  String get removePasscode => '刪除密碼';

  @override
  String get updatePasscode => '更新密碼';

  @override
  String get description_create_passcode => '透過定期更新您的 6 位密碼來保護您的帳戶。';

  @override
  String get description_remove_passcode => '輸入您目前的密碼以停用安全性。';

  @override
  String get currentPasscode => '目前密碼';

  @override
  String get enterCurrentPin => '輸入目前 PIN 碼';

  @override
  String get passcode_turn_off_success => '密碼關閉成功！';

  @override
  String get passcode_update_success => '密碼更新成功！';

  @override
  String get passcode_create_success => '密碼創建成功！';

  @override
  String get currentPasscodeIncorrect => '目前密碼不正確。';

  @override
  String get errorSavingData => '儲存資料時發生錯誤。';

  @override
  String get newPasscodeMustBe6Digits => '新密碼必須是 6 位數字。';

  @override
  String get passcodesDoNotMatch => '密碼不符。';

  @override
  String get enter_passcode => '輸入密碼';

  @override
  String get incorrect_passcode => '密碼不正確。';

  @override
  String get face => '人臉辨識';

  @override
  String get fingerprint => '指紋';

  @override
  String get report_locked => '鎖定內容';

  @override
  String get unlock => '開鎖';

  @override
  String get click_to_unlock => '點擊解鎖';

  @override
  String get unlock_untilimited_access => '解鎖無限訪問';

  @override
  String get unlock_untilimited_access_description => '升級至高級版可消除所有限制並存取高級功能。';

  @override
  String get daily_input_cap_reached => '已達每日投入上限';

  @override
  String get daily_input_cap_reached_description =>
      '您已達到發票掃描和語音輸入的每日限制。立即升級以繼續。';

  @override
  String get feature_comparison => '特性比較';

  @override
  String get feature => '特徵';

  @override
  String get free => '自由的';

  @override
  String get premium => '優質的';

  @override
  String get no_ads => '無廣告';

  @override
  String get transaction_locking => '交易鎖定';

  @override
  String get unlimited_scans => '無限次發票掃描';

  @override
  String get unlimited_voice_entries => '無限語音輸入';

  @override
  String get day => '天';

  @override
  String get year => '年';

  @override
  String get subscription_auto_renews => '訂閱自動續訂。';

  @override
  String get accept_terms_conditions => '訂閱自動續訂。繼續即表示您同意我們的服務條款和隱私權政策。';

  @override
  String get restore => '恢復';

  @override
  String used_up_daily_limit(String value) {
    return '您今天已用完語音輸入限制。觀看廣告即可獲得$value更多使用次數或升級至進階版。';
  }

  @override
  String get monthly_plan => '每月計劃';

  @override
  String get yearly_plan => '年度計劃';

  @override
  String get lifetime_plan => '終身規劃';

  @override
  String get pay_once_enjoy_forever => '一次付費，終身享受';

  @override
  String get yearly_discount => '全年計畫節省 20%';

  @override
  String get best_value => '最超值';

  @override
  String get transaction_cancelled => '交易已取消。';

  @override
  String get purchase_successful => '購買成功！';

  @override
  String get purchase_successful_description => '感謝您升級到高級版！享受增強的體驗。';

  @override
  String get restore_successful => '恢復成功！';

  @override
  String get restore_successful_description => '您之前的購買已恢復。享受您的高級功能！';

  @override
  String get nothing_to_restore => '沒有什麼可恢復的';

  @override
  String get nothing_to_restore_description => '沒有發現以前的購買可以恢復。';

  @override
  String get restore_failed => '恢復失敗';

  @override
  String get restore_failed_description => '恢復購買時發生錯誤。請再試一次。';

  @override
  String get purchase_failed => '購買失敗';

  @override
  String get purchase_failed_description => '交易期間發生錯誤。請再試一次。';

  @override
  String get purchase_canceled => '購買已取消';

  @override
  String get purchase_canceled_description => '交易被取消。您的帳戶沒有發生任何變更。';

  @override
  String get premium_sync_account =>
      '您的高級帳戶將與您登入的帳戶同步。請確保您在所有裝置上使用相同帳戶登錄，以獲得無縫的高級體驗。';

  @override
  String get premium_sync_warning =>
      '注意：如果您使用其他帳戶購買了高級套餐，請登入該帳戶以恢復您的高級存取權限。如果您使用相同帳戶，請嘗試恢復購買以同步您的進階存取權限。';

  @override
  String get select_language => '選擇語言';

  @override
  String get suggested => '建議';

  @override
  String get all_languages => '所有語言';

  @override
  String get apply_changes => '應用程式變更';

  @override
  String get select_currency => '選擇貨幣';

  @override
  String get search_currency => '搜尋貨幣或國家...';

  @override
  String get popular => '受歡迎的';

  @override
  String get all_currencies => '所有貨幣';

  @override
  String get currency_change_warning => '更改貨幣只會更新顯示符號。過去的交易費率將不會重新計算。';

  @override
  String see_ads(String additionalUses) {
    return '查看廣告（+$additionalUses使用）';
  }

  @override
  String get ads_loading => '廣告加載中...';

  @override
  String get data_management => '資料管理';

  @override
  String get select_format => '選擇格式';

  @override
  String get export_data => '匯出數據';

  @override
  String get export_data_description => '匯出您的財務資料以進行備份或分析。';

  @override
  String get confirm_export => '確認導出';

  @override
  String get import_data => '導入數據';

  @override
  String get import_data_title => '讓我們得到你的';

  @override
  String get data => '數據';

  @override
  String get import_data_title_2 => '在。';

  @override
  String get import_data_description => '從外部來源匯入財務資料以與應用程式同步。';

  @override
  String get confirm_import => '確認導入';

  @override
  String get csv_format => 'CSV 格式';

  @override
  String get csv_description => '以 CSV 格式匯出數據，與大多數電子表格應用程式相容。';

  @override
  String get json_format => 'JSON 格式';

  @override
  String get json_description => '以JSON格式匯出數據，適合開發者和進階使用者。';

  @override
  String get excel_format => 'Excel格式';

  @override
  String get excel_description => '以 Excel 格式匯出數據，非常適合詳細的財務分析。';

  @override
  String get select_file => '選擇文件';

  @override
  String get no_file_selected => '未選擇檔案。';

  @override
  String get import_successful => '導入成功';

  @override
  String get error_importing_data => '導入資料時發生錯誤。請確保文件格式正確。';

  @override
  String get sync_data_now => '立即同步';

  @override
  String last_synced(String time) {
    return '最後同步：$time';
  }

  @override
  String get syncing => '正在同步...';

  @override
  String get never_synced => '從未同步';

  @override
  String get unauthenticated => '請登入以跨裝置同步您的資料。';

  @override
  String sync_error(String error) {
    return '同步錯誤：$error';
  }

  @override
  String get premium_required_to_sync => '您需要升級到高級版或觀看廣告才能同步資料。';

  @override
  String get sync_in_progress => '正在同步，請稍候。';

  @override
  String cooldown(String time) {
    return '你動作太快了。請等待$time，然後再同步。';
  }

  @override
  String get logout_delete_local_data_message => '您想刪除該裝置上的資料嗎？同步的雲端資料將保持安全。';

  @override
  String get keep_local_data => '不，只需退出';

  @override
  String get delete_local_data => '刪除數據';

  @override
  String get accepted_formats => '接受的格式';

  @override
  String get select_file_to_import => '選擇要匯入的文件';

  @override
  String get tap_to_browse => '點擊即可瀏覽您的裝置或雲\n文件的儲存。';

  @override
  String get protected => '受保護';

  @override
  String get protected_description => '您的資料永遠不會離開您的設備，並在本地進行處理。';

  @override
  String get recent_imports => '最近的進口';

  @override
  String get no_recent_imports => '沒有最近的數據導入';

  @override
  String get invalid_format => '文件格式無效。';

  @override
  String get import_success => '導入成功！';

  @override
  String import_success_description(String count) {
    return '已成功從檔案匯入$count交易。';
  }

  @override
  String get file_format_template => '文件格式模板';

  @override
  String download_sample_file(String format) {
    return '下載範例檔案$format';
  }

  @override
  String get card => '卡片';

  @override
  String get font_selection => '字體選擇';

  @override
  String get select_font => '選擇字體';

  @override
  String get font => '字體';

  @override
  String get font_description => '每天一筆交易，讓「破產月」遠離。';

  @override
  String get reminder_title => '每日費用提醒';

  @override
  String get reminder_body => '你今天的開支記好了嗎？ 💸';

  @override
  String get defaultTransactionTitle => '新交易';

  @override
  String get invoice_analysis => '正在分析發票...';

  @override
  String get mapbox_error => '地圖載入錯誤。請檢查您的 Mapbox 令牌配置。';

  @override
  String get location => '地點';

  @override
  String get current_location => '目前位置';

  @override
  String get select_location => '選擇位置';

  @override
  String get no_location_selected => '未選擇地點';

  @override
  String get search_location => '搜尋位置...';

  @override
  String get tap_to_change_location => '點擊以更改位置';

  @override
  String get search_results => '搜尋結果';

  @override
  String get no_location_found => '沒有找到位置';

  @override
  String get recent_locations => '最近的地點';

  @override
  String get location_access_error => '位置存取錯誤';

  @override
  String get location_permission_denied => '位置權限被拒絕。';

  @override
  String get location_permission_denied_description => '請在設定中啟用位置存取。';

  @override
  String get notification_permission_denied => '通知權限被拒絕。';

  @override
  String get notification_permission_denied_description =>
      '請在設定中啟用通知存取權限以接收提醒。';

  @override
  String get permission_required_camera => '相機訪問被拒絕';

  @override
  String get permission_required_camera_description => '請在設定中啟用相機存取才能使用收據掃描功能。';

  @override
  String get voice_input_error => '語音輸入錯誤。請再試一次。';

  @override
  String get voice_input_not_recognized => '無法辨識語音輸入。請再試一次。';

  @override
  String get voice_input_permission_denied => '語音輸入權限被拒絕。請在設定中啟用麥克風存取。';

  @override
  String get error_ai_request => 'AI無法辨識這個請求。請嘗試更具體。';

  @override
  String get voice_analysis => '正在分析語音輸入...';

  @override
  String get scan_receipt_error => '收據掃描錯誤。請再試一次。';

  @override
  String get requires_premium => '此功能需要觀看廣告才能使用或升級至進階版。';

  @override
  String get watch_ad_continue => '觀看廣告以繼續';

  @override
  String get permission_required_voice_input => '麥克風存取被拒絕';

  @override
  String get permission_required_voice_input_description =>
      '請在設定中啟用麥克風存取才能使用語音輸入。';

  @override
  String get permission_required_location => '位置存取被拒絕';

  @override
  String get permission_required_location_description => '請在設定中啟用位置存取以使用位置功能。';

  @override
  String get congratulations => '恭喜！';

  @override
  String get successfully_purchased => '您已成功購買高級版。享受增強的體驗！';

  @override
  String get cancel_purchase => '取消購買';

  @override
  String get restore_no_purchase_description => '沒有發現以前的購買可以恢復。';

  @override
  String get ai_powered => '人工智慧驅動';

  @override
  String get entries_pending => '參賽作品待定';

  @override
  String get confirm_selected_entries => '新增選定的條目';

  @override
  String get preview_results => '預覽結果';

  @override
  String get clear_all => '全部清除';

  @override
  String get select_all => '選擇全部';

  @override
  String get fail_to_save_transactions => '無法保存交易。請再試一次。';

  @override
  String get tap_to_check_in => '點按即可簽到';

  @override
  String get keep_your_streak => '保持你的連勝！';

  @override
  String keep_your_streak_day(String streak) {
    return '保持$streak天的連續記錄！';
  }

  @override
  String get streak => '條紋';

  @override
  String streak_days(String days) {
    return '$days天';
  }

  @override
  String get not_logined => '未登入';

  @override
  String get please_login_to_sync_data => '請登入以跨裝置同步您的資料。';

  @override
  String get require_premium_to_sync => '您需要升級到高級版或觀看廣告才能同步資料。';

  @override
  String get information_and_support => '資訊與支援';

  @override
  String get contact_support => '聯繫支援人員';

  @override
  String get send_email => '傳送電子郵件';

  @override
  String get describe_issue => '詳細描述您的問題或問題。我們的支援團隊將盡快與您聯繫。';

  @override
  String get feedback => '回饋';

  @override
  String get feedback_description =>
      '我們很想聽聽您的想法和建議，以幫助我們改進 SpendFlow。請與我們分享您的回饋！';

  @override
  String get thank_you_feedback => '感謝您的回饋！';

  @override
  String get submit_feedback => '提交回饋';

  @override
  String get report_issue => '報告問題';

  @override
  String get submit_issue => '提交問題';

  @override
  String get report_issue_description =>
      '如果您遇到任何錯誤或問題，請在此處報告。您的意見有助於我們為每個人改進應用程式。';

  @override
  String get thank_you_issue => '感謝您回報問題！我們將盡快調查此事。';

  @override
  String get request_delete_account => '請求刪除帳戶';

  @override
  String get delete_account_description =>
      '如果您想刪除您的帳戶，請告訴我們您為什麼要刪除它。我們將盡快處理您的請求。';

  @override
  String get submit_delete_request => '提交請求';

  @override
  String get select_subject => '選擇主題';

  @override
  String get please_enter_content => '請輸入內容';

  @override
  String get subject => '主題';

  @override
  String get content => '內容';

  @override
  String get send_contact_success => '您的訊息已發送成功！我們會盡快回覆您。';

  @override
  String get send_contact_error => '發送您的訊息時發生錯誤。請再試一次。';

  @override
  String get contact_info => '聯絡資訊';

  @override
  String get email_placeholder => '輸入您的電子郵件';

  @override
  String get name_placeholder => '輸入你的名字';

  @override
  String get invalid_name => '請輸入有效的名稱。';

  @override
  String get mrs => '太太。';

  @override
  String get mr => '先生。';

  @override
  String get ms => '多發性硬化症。';

  @override
  String get salutation => '稱呼';

  @override
  String get delete_account => '刪除帳戶';

  @override
  String get delete_account_confirmation => '您確定要刪除您的帳戶嗎？此操作無法撤消，並將刪除您的所有資料。';

  @override
  String get failed_to_send_deletion_request => '無法發送帳戶刪除請求。請再試一次。';

  @override
  String get requires_recent_login_description =>
      '出於安全原因，請先退出並重新登錄，然後再嘗試刪除您的帳戶。';

  @override
  String get delete_account_failed => '刪除您的帳戶時發生錯誤。請再試一次。';

  @override
  String get left => '左邊';

  @override
  String get edit_transaction => '編輯交易';

  @override
  String get save_expense_change => '更新費用';

  @override
  String get save_income_change => '更新收入';

  @override
  String get transaction_updated => '交易更新成功';

  @override
  String get bank_sync => '銀行同步';

  @override
  String get bank_sync_description => '自動連線並同步銀行帳戶交易來源';

  @override
  String get coming_soon => '即將推出';

  @override
  String get feature_under_development => '此功能目前正在開發中，將在即將推出的更新中提供！';

  @override
  String get remaining_budget => '剩餘預算';

  @override
  String get monthly_spending => '每月支出圖表';

  @override
  String get quick_add_voice => '點擊即可說話';

  @override
  String get ad_no_fill_title => '暫無廣告';

  @override
  String get ad_no_fill_message => '目前暫無可用廣告。請稍後再試或升級為高級版。';

  @override
  String get ad_network_error_title => '連線錯誤';

  @override
  String get ad_network_error_message => '無法連線以載入廣告。請檢查網絡後重試。';

  @override
  String get ad_load_failed_title => '廣告載入失敗';

  @override
  String get ad_load_failed_message => '載入廣告時發生錯誤。請稍後再試。';

  @override
  String get ad_show_failed_title => '顯示錯誤';

  @override
  String get ad_show_failed_message => '無法顯示廣告。請稍後再試。';

  @override
  String get ad_loading_timeout_message => '廣告載入超時。請稍後再試。';

  @override
  String get ad_preparing => '正在準備廣告...';
}
