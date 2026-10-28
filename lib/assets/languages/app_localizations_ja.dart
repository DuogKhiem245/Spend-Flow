// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get app_name => 'SpendFlow';

  @override
  String get ok => 'わかりました';

  @override
  String get cancel => 'キャンセル';

  @override
  String get skip => 'スキップ';

  @override
  String get next => '次';

  @override
  String get confirm => '確認する';

  @override
  String get save => '保存';

  @override
  String get edit => '編集';

  @override
  String get delete => '消去';

  @override
  String get yes => 'はい';

  @override
  String get no => 'いいえ';

  @override
  String get done => '終わり';

  @override
  String get close => '近い';

  @override
  String get back => '戻る';

  @override
  String get start => '始める';

  @override
  String get continueAction => '続く';

  @override
  String get view_all => 'すべて見る';

  @override
  String get see_all => 'すべて見る';

  @override
  String get amount => '額';

  @override
  String get name => '名前';

  @override
  String get date => '日付';

  @override
  String get month => '月';

  @override
  String get life_time => '一生';

  @override
  String get today => '今日';

  @override
  String get other => '他の';

  @override
  String get home => '家';

  @override
  String get reports => 'レポート';

  @override
  String get budgets => '予算';

  @override
  String get all => '全て';

  @override
  String get error => 'エラー';

  @override
  String get user => 'ユーザー';

  @override
  String get success => '成功';

  @override
  String get loading => '読み込み中...';

  @override
  String get onboard_step1_title => 'すぐに録音';

  @override
  String get onboard_step1_message =>
      '支出場所を自動的に検出してログを高速化します。もうお金がどこに行ったのか悩む必要はありません。';

  @override
  String get onboard_step2_title => 'ウォレットをマスターする';

  @override
  String get onboard_step2_message =>
      'カテゴリごとに支出制限を設定します。私たちはあなたの財務目標を順調に進めていきます';

  @override
  String get onboard_step3_title => '健康的な習慣を築く';

  @override
  String get onboard_step3_message =>
      '毎日リマインダーを受け取るので、取引を見逃すことはありません。一貫性は経済的自由の鍵です。';

  @override
  String get create_first_wallet => '最初のウォレットを作成する';

  @override
  String get welcome_create_wallet => 'スペンドフローへようこそ！\nまずは最初のウォレットを作成しましょう。';

  @override
  String get enter_wallet_name => 'ウォレット名を入力してください';

  @override
  String get eg_my_wallet => '例: 私の財布、現金、クレジットカード';

  @override
  String get currency_unit => '通貨単位';

  @override
  String get create_wallet => 'ウォレットの作成';

  @override
  String get please_enter_wallet_name => 'ウォレット名を入力してください。';

  @override
  String get add_wallet => '新しいウォレットを追加する';

  @override
  String get wallet_name => 'ウォレット名';

  @override
  String get add_wallet_description => 'ウォレットを追加して、財務をより効果的に管理および追跡します。';

  @override
  String get cannot_delete_last_wallet => '最後のウォレットは削除できません。';

  @override
  String get delete_wallet => 'ウォレットの削除';

  @override
  String delete_wallet_confirmation(String walletName) {
    return 'ウォレット「$walletName」を削除してもよろしいですか?この操作は元に戻すことができません。';
  }

  @override
  String get in_use => '使用中';

  @override
  String get incomplete_details => '不完全な詳細';

  @override
  String get please_fill_required_fields => '続行するには、次の必須フィールドに入力してください。';

  @override
  String get select_wallet => 'ウォレットの選択';

  @override
  String get please_create_wallet_first => 'トランザクションを追加する前にウォレットを作成する必要があります。';

  @override
  String get create_now => '今すぐ作成';

  @override
  String get no_wallets_yet => 'まだ財布がありません';

  @override
  String get login => 'ログイン';

  @override
  String get register => '登録する';

  @override
  String get logout => 'ログアウト';

  @override
  String get email => '電子メール';

  @override
  String get password => 'パスワード';

  @override
  String get new_password => '新しいパスワード';

  @override
  String get enter_email => 'メールアドレスを入力してください';

  @override
  String get enter_your_password => 'パスワードを入力してください';

  @override
  String get confirm_password => 'パスワードを認証する';

  @override
  String get confirm_your_password => 'パスワードを確認してください';

  @override
  String get passwords_match => 'パスワードが一致します。';

  @override
  String get passwords_mismatch => 'パスワードが一致しません。';

  @override
  String get forgot_password => 'パスワードをお忘れですか？';

  @override
  String get description_forgot_password =>
      'アカウントに関連付けられている電子メールを入力して、パスワードをリセットします。';

  @override
  String get send_otp => 'OTPを送信する';

  @override
  String get enter_otp => 'OTPを入力してください';

  @override
  String get resend => '再送信';

  @override
  String get verify => '確認する';

  @override
  String get no_otp => 'コードを受信しませんか?';

  @override
  String get verify_otp => 'OTP を確認する';

  @override
  String get we_sent_otp =>
      'OTP コードについては電子メールを確認してください。受信トレイにスパムまたは迷惑メール フォルダーが表示されない場合は、忘れずに確認してください。';

  @override
  String get dont_receive_otp => 'OTP を受け取っていませんか?';

  @override
  String get plese_enter_valid_otp => '有効な OTP コードを入力してください。';

  @override
  String get otp_resent => 'OTP コードが正常に再送信されました。';

  @override
  String get register_successful => '登録が成功しました！';

  @override
  String get register_successful_description =>
      'アカウントは正常に作成されました。これで、資格情報を使用してログインできるようになります。';

  @override
  String get no_account => 'アカウントをお持ちでない場合は、';

  @override
  String get have_account => 'すでにアカウントをお持ちですか?';

  @override
  String get login_error => '無効な電子メールまたはパスワード';

  @override
  String get register_error => '登録に失敗しました';

  @override
  String get create_account => 'アカウントを作成する';

  @override
  String get create_password => '新しいパスワードを作成する';

  @override
  String get create_new_password => 'もうすぐそこです！新しいパスワードを作成します。';

  @override
  String get or_continue_with => 'または続行してください';

  @override
  String sign_in_with(String provider) {
    return '$providerでサインインします';
  }

  @override
  String get check_your_mail => 'メールを確認してください';

  @override
  String get we_have_sent_mail => 'メールを次の宛先に送信しました。';

  @override
  String get please_check_your_mail_to_verify_account =>
      'ログインする前にメールをチェックしてアカウントを確認してください。';

  @override
  String get register_failed => '登録に失敗しました';

  @override
  String get please_fill_all_fields => 'すべてのフィールドに入力してください。';

  @override
  String get please_enter_email_and_password => 'メールアドレスとパスワードの両方を入力してください。';

  @override
  String get incorrect_email_or_password => 'メールアドレスまたはパスワードが間違っています。';

  @override
  String get invalid_email_format => '電子メールの形式が無効です。';

  @override
  String get this_account_has_been_disabled => 'このアカウントは無効になっています。';

  @override
  String get too_many_requests_please_try_later => 'リクエストが多すぎます。後でもう一度試してください。';

  @override
  String get email_not_verified => 'メールが未確認';

  @override
  String get please_verify_your_email_to_continue => '続行するにはメールアドレスを確認してください。';

  @override
  String get are_you_sure_logout => 'ログアウトしてもよろしいですか?';

  @override
  String get have_error_occurred => 'エラーが発生しました。もう一度試してください。';

  @override
  String get user_not_found => 'このメールではアカウントが見つかりませんでした。';

  @override
  String get enter_otp_reset_password =>
      'OTP コードをあなたの電子メールに送信しました。 OTP を入力してパスワードをリセットしてください。';

  @override
  String get not_time_yet_to_resend_otp => 'OTP コードを再送信するまでしばらくお待ちください。';

  @override
  String get reset_password_successful => 'パスワードのリセットに成功しました';

  @override
  String get reset_password_successful_description =>
      'パスワードは正常にリセットされました。新しいパスワードでログインできるようになります。';

  @override
  String get welcome_back => 'おかえり';

  @override
  String get back_login => 'ログインに戻る';

  @override
  String get description_create_account => '今すぐ財務を管理しましょう';

  @override
  String get label_weak => '弱い';

  @override
  String get label_fair => '公平';

  @override
  String get label_good => '良い';

  @override
  String get label_strong => '強い';

  @override
  String get low_pass => '数字と記号を含む 8 文字以上である必要があります。';

  @override
  String get weak_pass => '短すぎます。もっと文字を追加してください。';

  @override
  String get fair_pass => 'より良い。数字や記号を追加してみましょう。';

  @override
  String get good_pass_char => 'もうすぐそこです！特別なキャラクターを追加して強化します。';

  @override
  String get good_pass_num => 'もうすぐそこです！数字を加えると強度が増します。';

  @override
  String get good_pass_special => 'もうすぐそこです！任意のキャラクターを追加して強化します。';

  @override
  String get strong_pass => '素晴らしい！あなたのパスワードは安全です。';

  @override
  String get password_reset_email_sent => 'パスワードをリセットするリンクをあなたの電子メールに送信しました。';

  @override
  String get forgot_password_description =>
      'アカウントに関連付けられている電子メールを入力して、パスワードをリセットします。';

  @override
  String get send_email_reset => 'メール送信リセット';

  @override
  String get password_weak_password => '指定されたパスワードは弱すぎます。';

  @override
  String get please_edit_fields => '続行するには、次のフィールドを編集してください。';

  @override
  String get something_went_wrong => '何か問題が発生しました。もう一度試してください。';

  @override
  String get email_already_in_use => 'メールアドレスはすでに別のアカウントで使用されています。';

  @override
  String get invalid_email => '電子メール アドレスが無効です。';

  @override
  String get operation_not_allowed => '操作は許可されていません。サポートにお問い合わせください。';

  @override
  String get network_error => 'ネットワークエラー。接続を確認して、もう一度試してください。';

  @override
  String get reset_password => 'パスワードのリセット';

  @override
  String get email_not_received => 'メールが届かない場合は？';

  @override
  String get verification_email_sent => '確認メールを送信しました';

  @override
  String get good_morning => 'おはよう';

  @override
  String get good_afternoon => 'こんにちは';

  @override
  String get good_evening => 'こんばんは';

  @override
  String get hello => 'こんにちは';

  @override
  String get income => '所得';

  @override
  String get expenses => '経費';

  @override
  String get balance => 'バランス';

  @override
  String get total_balance => '合計残高';

  @override
  String get spending_this_month => '今月の支出';

  @override
  String get total_spent => '総支出額';

  @override
  String get recent_transactions => '最近の取引';

  @override
  String get add_transaction => 'トランザクションの追加';

  @override
  String get no_transactions => '利用可能なデータがありません';

  @override
  String get enter_transaction_name => 'トランザクション名を入力してください';

  @override
  String get suggested_category => '推奨カテゴリー';

  @override
  String get category => 'カテゴリ';

  @override
  String get categories => 'カテゴリー';

  @override
  String get select_category => 'カテゴリの選択';

  @override
  String get edit_category => 'カテゴリの編集';

  @override
  String are_you_sure_delete_category(String categoryName) {
    return '$categoryNameを削除してもよろしいですか?';
  }

  @override
  String get system_category => 'システムカテゴリは削除できません。';

  @override
  String get system_category_description => 'このデフォルト カテゴリを編集または削除することはできません。';

  @override
  String get category_food => '食べ物';

  @override
  String get category_transport => '輸送';

  @override
  String get category_salary => '給料';

  @override
  String get category_shopping => '買い物';

  @override
  String get category_game => 'ゲーム';

  @override
  String get category_house => '家';

  @override
  String get category_gift => '贈り物';

  @override
  String get category_health => '健康';

  @override
  String get category_entertainment => 'エンターテインメント';

  @override
  String get category_bill => '請求書';

  @override
  String get category_insurance => '保険';

  @override
  String get category_education => '教育';

  @override
  String get category_pet => 'ペット';

  @override
  String get category_travel => '旅行';

  @override
  String get category_savings => '貯蓄';

  @override
  String get category_phone => '電話';

  @override
  String get category_internet => 'インターネット';

  @override
  String get category_water => '水';

  @override
  String get category_electricity => '電気';

  @override
  String get category_gas => 'ガス';

  @override
  String get category_cleaning => 'クリーニング';

  @override
  String get category_beauty => '美しさ';

  @override
  String get category_baby => '赤ちゃん';

  @override
  String get category_sport => 'スポーツ';

  @override
  String get category_music => '音楽';

  @override
  String get category_repair => '修理';

  @override
  String get category_tax => '税';

  @override
  String get note => '注記 (オプション)';

  @override
  String get enter_note => 'メモを入力してください';

  @override
  String get add_income => '収入を追加する';

  @override
  String get add_expense => '経費の追加';

  @override
  String get search_category => '検索カテゴリー';

  @override
  String get no_category_found => 'カテゴリが見つかりません';

  @override
  String get most_used => '最もよく使われる';

  @override
  String get category_suggestions => 'カテゴリの提案';

  @override
  String get all_categories => 'すべてのカテゴリ';

  @override
  String get new_category => '新しいカテゴリー';

  @override
  String get category_name => 'カテゴリ名';

  @override
  String get category_color => 'カテゴリの色';

  @override
  String get category_icon => 'カテゴリアイコン';

  @override
  String get vs_last_month => '先月との比較';

  @override
  String get transaction => '取引';

  @override
  String get delete_transaction => 'トランザクションの削除';

  @override
  String get delete_transaction_confirmation => 'このトランザクションを削除してもよろしいですか?';

  @override
  String get transaction_details => '取引詳細';

  @override
  String get spending_trend => '支出の傾向';

  @override
  String get spending_last_7_days => '過去 7 日間の支出';

  @override
  String get note_2 => '注記';

  @override
  String get scan_receipt => '領収書のスキャン';

  @override
  String get add_via_voice => '音声で追加';

  @override
  String get add_manually => '手動で追加';

  @override
  String get limit_reached => '限界に達しました';

  @override
  String limit_reached_description(String featureName, String limit) {
    return '今日は$featureName$limit回使用されました。\n明日もう一度お越しいただくか、プレミアムにアップグレードしてください。';
  }

  @override
  String get align_receipt => 'レシートを揃える';

  @override
  String get listening => 'リスニング...';

  @override
  String get voice_example => '例：食料品に50ドル使いました';

  @override
  String get tap_to_stop => 'タップして停止';

  @override
  String get tap_to_listen => 'タップして聞く';

  @override
  String get yesterday => '昨日';

  @override
  String get your_monthly_budget => '毎月の予算';

  @override
  String get spent => '過ごした';

  @override
  String get out_of => 'から';

  @override
  String get left_to_spend => '残りの時間';

  @override
  String get add_budget => '予算を追加';

  @override
  String get no_budgets_yet => 'まだ予算がありません';

  @override
  String get create_budget_description => '+ をタップして支出制限を作成します';

  @override
  String get edit_budget => '予算の編集';

  @override
  String are_you_sure_delete_budget(String budgetName) {
    return '削除してもよろしいですか$budgetName?';
  }

  @override
  String get delete_budget => '予算の削除';

  @override
  String get settings => '設定';

  @override
  String get settings_description => 'すべてのデバイス間で財務データの同期を維持します';

  @override
  String get sign_in_now => '今すぐサインイン';

  @override
  String get get_started => '始めましょう';

  @override
  String get welcome => 'いらっしゃいませ ！';

  @override
  String get general => '一般的な';

  @override
  String get security => '安全';

  @override
  String get privacy_and_security => 'プライバシーとセキュリティ';

  @override
  String get support => 'サポート';

  @override
  String get profile => 'プロフィール';

  @override
  String get language => '言語';

  @override
  String get dark_mode => 'ダークモード';

  @override
  String get notifications => '通知';

  @override
  String get appearance => '外観';

  @override
  String get currency => '通貨';

  @override
  String get about => 'について';

  @override
  String get terms_of_service => '利用規約';

  @override
  String get privacy_policy => 'プライバシーポリシー';

  @override
  String get version => 'バージョン';

  @override
  String get edit_profile => 'プロフィールの編集';

  @override
  String get full_name => 'フルネーム';

  @override
  String get enter_full_name => 'フルネームを入力してください';

  @override
  String get email_address => '電子メールアドレス';

  @override
  String get enter_email_address => 'メールアドレスを入力してください';

  @override
  String get phone_number => '電話番号';

  @override
  String get enter_phone_number => '電話番号を入力してください';

  @override
  String get day_of_birth => '生年月日';

  @override
  String get select_day_of_birth => '生年月日を選択してください';

  @override
  String get save_changes => '変更を保存';

  @override
  String get profile_updated_success => 'プロフィールが正常に更新されました。';

  @override
  String get error_updating_profile => 'プロファイルの更新中にエラーが発生しました。';

  @override
  String get error_uploading_avatar => 'アバターのアップロード中にエラーが発生しました。';

  @override
  String get require_premium_to_edit_avatar =>
      'アバターを編集するには、プレミアムにアップグレードするか、広告を視聴する必要があります。';

  @override
  String get edit_avatar => 'アバターの編集';

  @override
  String get upgrade_premium => 'プレミアムにアップグレードしてください！';

  @override
  String get upgrade_premium_description => '限定機能のロックを解除してエクスペリエンスを向上させます。';

  @override
  String get upgrade_now => '今すぐアップグレード';

  @override
  String get you_are_premium => 'プレミアム ユーザーの皆さん、準備は完了です。';

  @override
  String get you_are_premium_description => '強化されたエクスペリエンスをお楽しみください。';

  @override
  String get import_export_data => 'データのインポート/エクスポート';

  @override
  String get sync_data => 'データを同期する';

  @override
  String continue_with(String price) {
    return '$priceに進む';
  }

  @override
  String get biometric_authentication => '生体認証';

  @override
  String get password_security => 'パスワードセキュリティ';

  @override
  String get face_id_description =>
      '一目でアプリのロックを解除します。 Face ID は、独自の顔の特徴を使用して、便利かつ安全なアクセスを提供します。';

  @override
  String get touch_id_description =>
      'タッチするだけでアプリのロックを解除します。 Touch ID は、指紋を使用した迅速かつ安全なアクセスを提供します。';

  @override
  String get pass_code_description =>
      '追加の保護層を追加します。パスコードを使用すると、デバイスが侵害された場合でも、自分だけが財務データにアクセスできるようになります。';

  @override
  String get passcode => 'パスコード';

  @override
  String get change_passcode => 'パスコードの変更';

  @override
  String get old_passcode => '古いパスコード';

  @override
  String get enter_old_passcode => '古いパスコードを入力してください';

  @override
  String get new_passcode => '新しいパスコード';

  @override
  String get enter_new_passcode => '新しいパスコードを入力してください';

  @override
  String get confirm_new_passcode => '新しいパスコードを確認する';

  @override
  String get enter_confirm_new_passcode => '新しいパスコードを確認のために入力してください';

  @override
  String get turnOffPasscode => 'パスコードをオフにする';

  @override
  String get createPasscode => 'パスコードの作成';

  @override
  String get changePasscode => 'パスコードの変更';

  @override
  String get removePasscode => 'パスコードを削除する';

  @override
  String get updatePasscode => 'パスコードを更新する';

  @override
  String get description_create_passcode => '6 桁のパスコードを定期的に更新してアカウントを保護します。';

  @override
  String get description_remove_passcode => '現在のパスコードを入力してセキュリティを無効にします。';

  @override
  String get currentPasscode => '現在のパスコード';

  @override
  String get enterCurrentPin => '現在のPINを入力してください';

  @override
  String get passcode_turn_off_success => 'パスコードは正常にオフになりました。';

  @override
  String get passcode_update_success => 'パスコードが正常に更新されました。';

  @override
  String get passcode_create_success => 'パスコードが正常に作成されました。';

  @override
  String get currentPasscodeIncorrect => '現在のパスコードが正しくありません。';

  @override
  String get errorSavingData => 'データの保存中にエラーが発生しました。';

  @override
  String get newPasscodeMustBe6Digits => '新しいパスコードは 6 桁である必要があります。';

  @override
  String get passcodesDoNotMatch => 'パスコードが一致しません。';

  @override
  String get enter_passcode => 'パスコードを入力してください';

  @override
  String get incorrect_passcode => 'パスコードが間違っています。';

  @override
  String get face => '顔認証';

  @override
  String get fingerprint => '指紋';

  @override
  String get report_locked => 'ロックされたコンテンツ';

  @override
  String get unlock => 'ロックを解除する';

  @override
  String get click_to_unlock => 'クリックしてロックを解除する';

  @override
  String get unlock_untilimited_access => '無制限のアクセスのロックを解除する';

  @override
  String get unlock_untilimited_access_description =>
      'すべての制限を解除し、高度な機能にアクセスするには、プレミアムにアップグレードしてください。';

  @override
  String get daily_input_cap_reached => '1 日の入力上限に達しました';

  @override
  String get daily_input_cap_reached_description =>
      '請求書のスキャンと音声入力の 1 日の制限に達しました。続行するには今すぐアップグレードしてください。';

  @override
  String get feature_comparison => '機能の比較';

  @override
  String get feature => '特徴';

  @override
  String get free => '無料';

  @override
  String get premium => 'プレミアム';

  @override
  String get no_ads => '広告なし';

  @override
  String get transaction_locking => 'トランザクションのロック';

  @override
  String get unlimited_scans => '無制限の請求書スキャン';

  @override
  String get unlimited_voice_entries => '無制限の音声入力';

  @override
  String get day => '日';

  @override
  String get year => '年';

  @override
  String get subscription_auto_renews => 'サブスクリプションは自動更新されます。';

  @override
  String get accept_terms_conditions =>
      'サブスクリプションは自動更新されます。続行すると、サービス利用規約とプライバシー ポリシーに同意したことになります。';

  @override
  String get restore => '復元する';

  @override
  String used_up_daily_limit(String value) {
    return '今日の音声入力制限を使い果たしました。広告を視聴して$value回以上使用するか、プレミアムにアップグレードしてください。';
  }

  @override
  String get monthly_plan => '月額プラン';

  @override
  String get yearly_plan => '年間計画';

  @override
  String get lifetime_plan => 'ライフタイムプラン';

  @override
  String get pay_once_enjoy_forever => '一度支払えば永久にお楽しみいただけます';

  @override
  String get yearly_discount => '年間プランで 20% 割引';

  @override
  String get best_value => 'ベストバリュー';

  @override
  String get transaction_cancelled => '取引がキャンセルされました。';

  @override
  String get purchase_successful => '購入成功しました！';

  @override
  String get purchase_successful_description =>
      'プレミアムにアップグレードしていただきありがとうございます。強化されたエクスペリエンスをお楽しみください。';

  @override
  String get restore_successful => '復元に成功しました!';

  @override
  String get restore_successful_description =>
      '以前の購入が復元されました。プレミアム機能をお楽しみください!';

  @override
  String get nothing_to_restore => '復元するものはありません';

  @override
  String get nothing_to_restore_description => '復元できる以前の購入は見つかりませんでした。';

  @override
  String get restore_failed => '復元に失敗しました';

  @override
  String get restore_failed_description => '購入を復元中にエラーが発生しました。もう一度試してください。';

  @override
  String get purchase_failed => '購入に失敗しました';

  @override
  String get purchase_failed_description => 'トランザクション中にエラーが発生しました。もう一度試してください。';

  @override
  String get purchase_canceled => '購入がキャンセルされました';

  @override
  String get purchase_canceled_description =>
      '取引はキャンセルされました。アカウントに変更は加えられませんでした。';

  @override
  String get premium_sync_account =>
      'プレミアム アカウントは、サインインするアカウントと同期されます。シームレスなプレミアム エクスペリエンスを実現するには、すべてのデバイスで同じアカウントでサインインしていることを確認してください。';

  @override
  String get premium_sync_warning =>
      '注: 別のアカウントでプレミアム パッケージを購入した場合は、そのアカウントにサインインしてプレミアム アクセスを復元してください。同じアカウントを使用している場合は、購入を復元してプレミアム アクセスを同期してみてください。';

  @override
  String get select_language => '言語の選択';

  @override
  String get suggested => '提案された';

  @override
  String get all_languages => 'すべての言語';

  @override
  String get apply_changes => '変更を適用する';

  @override
  String get select_currency => '通貨の選択';

  @override
  String get search_currency => '通貨または国を検索...';

  @override
  String get popular => '人気のある';

  @override
  String get all_currencies => 'すべての通貨';

  @override
  String get currency_change_warning =>
      '通貨を変更すると、表示シンボルのみが更新されます。過去の取引レートは再計算されません。';

  @override
  String see_ads(String additionalUses) {
    return '広告を見る (+$additionalUsesの使用)';
  }

  @override
  String get ads_loading => '広告を読み込み中...';

  @override
  String get data_management => 'データ管理';

  @override
  String get select_format => 'フォーマットの選択';

  @override
  String get export_data => 'データのエクスポート';

  @override
  String get export_data_description => 'バックアップまたは分析のために財務データをエクスポートします。';

  @override
  String get confirm_export => 'エクスポートの確認';

  @override
  String get import_data => 'データのインポート';

  @override
  String get import_data_title => 'あなたのものを手に入れましょう';

  @override
  String get data => 'データ';

  @override
  String get import_data_title_2 => 'で。';

  @override
  String get import_data_description => '外部ソースから財務データをインポートしてアプリケーションと同期します。';

  @override
  String get confirm_import => 'インポートの確認';

  @override
  String get csv_format => 'CSV形式';

  @override
  String get csv_description =>
      'ほとんどのスプレッドシート アプリケーションと互換性のある CSV 形式でデータをエクスポートします。';

  @override
  String get json_format => 'JSON形式';

  @override
  String get json_description => '開発者や上級ユーザーに適した JSON 形式でデータをエクスポートします。';

  @override
  String get excel_format => 'Excel形式';

  @override
  String get excel_description => 'データを Excel 形式でエクスポートできるため、詳細な財務分析に最適です。';

  @override
  String get select_file => 'ファイルの選択';

  @override
  String get no_file_selected => 'ファイルが選択されていません。';

  @override
  String get import_successful => 'インポート成功';

  @override
  String get error_importing_data =>
      'データのインポート中にエラーが発生しました。ファイル形式が正しいことを確認してください。';

  @override
  String get sync_data_now => '今すぐ同期';

  @override
  String last_synced(String time) {
    return '最終同期:$time';
  }

  @override
  String get syncing => '同期中...';

  @override
  String get never_synced => '決して同期しない';

  @override
  String get unauthenticated => 'デバイス間でデータを同期するにはログインしてください。';

  @override
  String sync_error(String error) {
    return '同期エラー:$error';
  }

  @override
  String get premium_required_to_sync =>
      'データを同期するには、プレミアムにアップグレードするか、広告を視聴する必要があります。';

  @override
  String get sync_in_progress => '同期が進行中です。お待​​ちください。';

  @override
  String cooldown(String time) {
    return '行動が早すぎます。再度同期する前に$time待ってください。';
  }

  @override
  String get logout_delete_local_data_message =>
      'このデバイス上のデータを削除しますか?同期されたクラウド データは安全に保たれます。';

  @override
  String get keep_local_data => 'いいえ、ログアウトしてください';

  @override
  String get delete_local_data => 'データの削除';

  @override
  String get accepted_formats => '受け入れられる形式';

  @override
  String get select_file_to_import => 'インポートするファイルを選択してください';

  @override
  String get tap_to_browse => 'タップしてデバイスまたはクラウドを参照します\nファイル用のストレージ。';

  @override
  String get protected => '保護されています';

  @override
  String get protected_description => 'データがデバイスの外に出ることはなく、ローカルで処理されます。';

  @override
  String get recent_imports => '最近のインポート';

  @override
  String get no_recent_imports => '最近のデータインポートはありません';

  @override
  String get invalid_format => '無効なファイル形式です。';

  @override
  String get import_success => '無事にインポートされました！';

  @override
  String import_success_description(String count) {
    return '$countトランザクションをファイルから正常にインポートしました。';
  }

  @override
  String get file_format_template => 'ファイル形式テンプレート';

  @override
  String download_sample_file(String format) {
    return 'サンプル ファイル$formatをダウンロード';
  }

  @override
  String get card => 'カード';

  @override
  String get font_selection => 'フォントの選択';

  @override
  String get select_font => 'フォントの選択';

  @override
  String get font => 'フォント';

  @override
  String get font_description => '1 日あたりのトランザクションにより、「壊れた月」を避けることができます。';

  @override
  String get reminder_title => '毎日の出費リマインダー';

  @override
  String get reminder_body => '今日の出費を記録しましたか？ 💸';

  @override
  String get defaultTransactionTitle => '新しいトランザクション';

  @override
  String get invoice_analysis => '請求書を分析しています...';

  @override
  String get mapbox_error => 'マップ読み込みエラー。 Mapbox トークンの構成を確認してください。';

  @override
  String get location => '位置';

  @override
  String get current_location => '現在地';

  @override
  String get select_location => '場所の選択';

  @override
  String get no_location_selected => '場所が選択されていません';

  @override
  String get search_location => '場所を検索...';

  @override
  String get tap_to_change_location => 'タップして場所を変更します';

  @override
  String get search_results => '検索結果';

  @override
  String get no_location_found => '場所が見つかりません';

  @override
  String get recent_locations => '最近の場所';

  @override
  String get location_access_error => '位置情報アクセスエラー';

  @override
  String get location_permission_denied => '位置情報の許可が拒否されました。';

  @override
  String get location_permission_denied_description =>
      '設定で位置情報へのアクセスを有効にしてください。';

  @override
  String get notification_permission_denied => '通知の許可が拒否されました。';

  @override
  String get notification_permission_denied_description =>
      'リマインダーを受信するには、設定で通知アクセスを有効にしてください。';

  @override
  String get permission_required_camera => 'カメラへのアクセスが拒否されました';

  @override
  String get permission_required_camera_description =>
      'レシートスキャン機能を使用するには、設定でカメラアクセスを有効にしてください。';

  @override
  String get voice_input_error => '音声入力エラーです。もう一度試してください。';

  @override
  String get voice_input_not_recognized => '音声入力が認識されません。もう一度試してください。';

  @override
  String get voice_input_permission_denied =>
      '音声入力の許可が拒否されました。設定でマイクへのアクセスを有効にしてください。';

  @override
  String get error_ai_request => 'AIはこのリクエストを認識できません。もっと具体的にしてみてください。';

  @override
  String get voice_analysis => '音声入力を分析しています...';

  @override
  String get scan_receipt_error => 'レシートスキャンエラー。もう一度試してください。';

  @override
  String get requires_premium => 'この機能を使用するには広告を視聴するか、プレミアムにアップグレードする必要があります。';

  @override
  String get watch_ad_continue => '広告を見て続きを読む';

  @override
  String get permission_required_voice_input => 'マイクへのアクセスが拒否されました';

  @override
  String get permission_required_voice_input_description =>
      '音声入力を使用するには、設定でマイクへのアクセスを有効にしてください。';

  @override
  String get permission_required_location => '位置情報へのアクセスが拒否されました';

  @override
  String get permission_required_location_description =>
      '位置情報機能を使用するには、設定で位置情報へのアクセスを有効にしてください。';

  @override
  String get congratulations => 'おめでとう！';

  @override
  String get successfully_purchased => 'プレミアムを購入しました。強化されたエクスペリエンスをお楽しみください。';

  @override
  String get cancel_purchase => '購入をキャンセルする';

  @override
  String get restore_no_purchase_description => '復元できる以前の購入は見つかりませんでした。';

  @override
  String get ai_powered => 'AI を活用した';

  @override
  String get entries_pending => '保留中のエントリー';

  @override
  String get confirm_selected_entries => '選択したエントリを追加する';

  @override
  String get preview_results => '結果のプレビュー';

  @override
  String get clear_all => 'すべてクリア';

  @override
  String get select_all => 'すべて選択';

  @override
  String get fail_to_save_transactions => 'トランザクションの保存に失敗しました。もう一度試してください。';

  @override
  String get tap_to_check_in => 'タップしてチェックイン';

  @override
  String get keep_your_streak => '連勝記録を維持しましょう！';

  @override
  String keep_your_streak_day(String streak) {
    return '$streak日の連続記録を維持しましょう!';
  }

  @override
  String get streak => 'ストリーク';

  @override
  String streak_days(String days) {
    return '$days日';
  }

  @override
  String get not_logined => 'ログインしていません';

  @override
  String get please_login_to_sync_data => 'デバイス間でデータを同期するにはログインしてください。';

  @override
  String get require_premium_to_sync =>
      'データを同期するには、プレミアムにアップグレードするか、広告を視聴する必要があります。';

  @override
  String get information_and_support => '情報とサポート';

  @override
  String get contact_support => 'サポートに連絡する';

  @override
  String get send_email => '電子メールを送信する';

  @override
  String get describe_issue => '問題や質問を詳しく説明してください。弊社のサポートチームができるだけ早くご連絡いたします。';

  @override
  String get feedback => 'フィードバック';

  @override
  String get feedback_description =>
      'SpendFlow の改善に役立つご意見やご提案をお待ちしております。ぜひフィードバックをお聞かせください。';

  @override
  String get thank_you_feedback => 'フィードバックをいただきありがとうございます。';

  @override
  String get submit_feedback => 'フィードバックを送信する';

  @override
  String get report_issue => 'レポートの問題';

  @override
  String get submit_issue => '問題を送信する';

  @override
  String get report_issue_description =>
      'バグや問題が発生した場合は、ここで報告してください。あなたの意見は、すべての人のためにアプリを改善するのに役立ちます。';

  @override
  String get thank_you_issue => '問題をご報告いただきありがとうございます。できるだけ早く調査させていただきます。';

  @override
  String get request_delete_account => 'アカウント削除のリクエスト';

  @override
  String get delete_account_description =>
      'アカウントを削除したい場合は、削除する理由をお知らせください。できるだけ早くリクエストを処理させていただきます。';

  @override
  String get submit_delete_request => 'リクエストの送信';

  @override
  String get select_subject => '件名を選択してください';

  @override
  String get please_enter_content => '内容を入力してください';

  @override
  String get subject => '主題';

  @override
  String get content => 'コンテンツ';

  @override
  String get send_contact_success => 'メッセージは正常に送信されました。できるだけ早くご連絡させていただきます。';

  @override
  String get send_contact_error => 'メッセージの送信中にエラーが発生しました。もう一度試してください。';

  @override
  String get contact_info => '連絡先';

  @override
  String get email_placeholder => 'メールアドレスを入力してください';

  @override
  String get name_placeholder => 'あなたの名前を入力してください';

  @override
  String get invalid_name => '有効な名前を入力してください。';

  @override
  String get mrs => '夫人';

  @override
  String get mr => '氏';

  @override
  String get ms => 'MS。';

  @override
  String get salutation => '挨拶';

  @override
  String get delete_account => 'アカウントの削除';

  @override
  String get delete_account_confirmation =>
      'アカウントを削除してもよろしいですか?この操作は元に戻すことができず、すべてのデータが削除されます。';

  @override
  String get failed_to_send_deletion_request =>
      'アカウント削除リクエストの送信に失敗しました。もう一度試してください。';

  @override
  String get requires_recent_login_description =>
      'セキュリティ上の理由から、アカウントを削除する前に、サインアウトしてから再度サインインしてください。';

  @override
  String get delete_account_failed => 'アカウントの削除中にエラーが発生しました。もう一度試してください。';

  @override
  String get left => '左';

  @override
  String get edit_transaction => 'トランザクションの編集';

  @override
  String get save_expense_change => '更新費用';

  @override
  String get save_income_change => '収入を更新';

  @override
  String get transaction_updated => 'トランザクションが正常に更新されました';

  @override
  String get bank_sync => 'バンク同期';

  @override
  String get bank_sync_description => '銀行口座の取引フィードを自動的に接続して同期する';

  @override
  String get coming_soon => '近日公開';

  @override
  String get feature_under_development =>
      'この機能は現在開発中であり、今後のアップデートで利用可能になる予定です。';

  @override
  String get remaining_budget => '残りの予算';

  @override
  String get monthly_spending => '月々の支出グラフ';

  @override
  String get quick_add_voice => 'タップして話す';

  @override
  String get ad_no_fill_title => '利用可能な広告がありません';

  @override
  String get ad_no_fill_message =>
      '現在表示できる広告がありません。しばらくしてからもう一度お試しいただくか、Premiumにアップグレードしてください。';

  @override
  String get ad_network_error_title => '接続エラー';

  @override
  String get ad_network_error_message =>
      '広告の読み込みに失敗しました。ネットワーク接続を確認して再試行してください。';

  @override
  String get ad_load_failed_title => '広告読み込みエラー';

  @override
  String get ad_load_failed_message => '広告の読み込み中にエラーが発生しました。後でもう一度お試しください。';

  @override
  String get ad_show_failed_title => '表示エラー';

  @override
  String get ad_show_failed_message => '広告を表示できませんでした。後でもう一度お試しください。';

  @override
  String get ad_loading_timeout_message => '広告の読み込みがタイムアウトしました。後でもう一度お試しください。';

  @override
  String get ad_preparing => '広告を準備中...';
}
