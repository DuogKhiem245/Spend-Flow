// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'SpendFlow';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get confirm => 'Confirm';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get done => 'Done';

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';

  @override
  String get start => 'Start';

  @override
  String get continueAction => 'Continue';

  @override
  String get view_all => 'View All';

  @override
  String get see_all => 'See All';

  @override
  String get amount => 'Amount';

  @override
  String get name => 'Name';

  @override
  String get date => 'Date';

  @override
  String get month => 'Month';

  @override
  String get life_time => 'Lifetime';

  @override
  String get today => 'Today';

  @override
  String get other => 'Other';

  @override
  String get home => 'Home';

  @override
  String get reports => 'Reports';

  @override
  String get budgets => 'Budgets';

  @override
  String get all => 'All';

  @override
  String get error => 'Error';

  @override
  String get user => 'User';

  @override
  String get success => 'Success';

  @override
  String get loading => 'Loading...';

  @override
  String get onboard_step1_title => 'Record in a Snap';

  @override
  String get onboard_step1_message =>
      'Automatically detect spending locations for faster logging. Never wonder where your money went again.';

  @override
  String get onboard_step2_title => 'Master Your Wallet';

  @override
  String get onboard_step2_message =>
      'Set spending limits for each category. We’ll keep you on track with your financial goals';

  @override
  String get onboard_step3_title => 'Build Healthy Habits';

  @override
  String get onboard_step3_message =>
      'Get daily reminders so you never miss a transaction. Consistency is the key to financial freedom.';

  @override
  String get create_first_wallet => 'Create Your First Wallet';

  @override
  String get welcome_create_wallet =>
      'Welcome to Spend Flow!\nLet\'s create your first wallet to get started.';

  @override
  String get enter_wallet_name => 'Enter wallet name';

  @override
  String get eg_my_wallet => 'e.g., My Wallet, Cash, Credit Card';

  @override
  String get currency_unit => 'Currency unit';

  @override
  String get create_wallet => 'Create Wallet';

  @override
  String get please_enter_wallet_name => 'Please enter wallet name.';

  @override
  String get add_wallet => 'Add New Wallet';

  @override
  String get wallet_name => 'Wallet Name';

  @override
  String get add_wallet_description =>
      'Add more wallets to manage and track your finances more effectively.';

  @override
  String get cannot_delete_last_wallet => 'You cannot delete the last wallet.';

  @override
  String get delete_wallet => 'Delete Wallet';

  @override
  String delete_wallet_confirmation(String walletName) {
    return 'Are you sure you want to delete the wallet \'$walletName\'? This action cannot be undone.';
  }

  @override
  String get in_use => 'In Use';

  @override
  String get incomplete_details => 'Incomplete Details';

  @override
  String get please_fill_required_fields =>
      'Please fill out the following required fields to proceed:';

  @override
  String get select_wallet => 'Select Wallet';

  @override
  String get please_create_wallet_first =>
      'You need to create a wallet before adding a transaction.';

  @override
  String get create_now => 'Create Now';

  @override
  String get no_wallets_yet => 'No wallets yet';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get logout => 'Logout';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get new_password => 'New password';

  @override
  String get enter_email => 'Enter your email';

  @override
  String get enter_your_password => 'Enter your password';

  @override
  String get confirm_password => 'Confirm Password';

  @override
  String get confirm_your_password => 'Confirm your password';

  @override
  String get passwords_match => 'Passwords match.';

  @override
  String get passwords_mismatch => 'Passwords do not match.';

  @override
  String get forgot_password => 'Forgot Password?';

  @override
  String get description_forgot_password =>
      'Enter the email associated with your account to reset your password.';

  @override
  String get send_otp => 'Send OTP';

  @override
  String get enter_otp => 'Enter OTP';

  @override
  String get resend => 'Resend';

  @override
  String get verify => 'Verify';

  @override
  String get no_otp => 'Don\'t receive code?';

  @override
  String get verify_otp => 'Verify OTP';

  @override
  String get we_sent_otp =>
      'Please check your email for the OTP code. Don\'t forget to check your Spam or Junk folder if you don\'t see it in your inbox.';

  @override
  String get dont_receive_otp => 'Didn\'t receive the OTP?';

  @override
  String get plese_enter_valid_otp => 'Please enter a valid OTP code.';

  @override
  String get otp_resent => 'OTP code resent successfully.';

  @override
  String get register_successful => 'Registration successful!';

  @override
  String get register_successful_description =>
      'Your account has been created successfully. You can now log in with your credentials.';

  @override
  String get no_account => 'Don\'t have an account?';

  @override
  String get have_account => 'Already have an account?';

  @override
  String get login_error => 'Invalid email or password';

  @override
  String get register_error => 'Registration failed';

  @override
  String get create_account => 'Create an Account';

  @override
  String get create_password => 'Create New Password';

  @override
  String get create_new_password => 'Almost there! Create your new password.';

  @override
  String get or_continue_with => 'Or continue with';

  @override
  String sign_in_with(String provider) {
    return 'Sign in with $provider';
  }

  @override
  String get check_your_mail => 'Check your mail';

  @override
  String get we_have_sent_mail => 'We have sent an email to:';

  @override
  String get please_check_your_mail_to_verify_account =>
      'Please check your email to verify your account before logging in.';

  @override
  String get register_failed => 'Registration failed';

  @override
  String get please_fill_all_fields => 'Please fill in all fields.';

  @override
  String get please_enter_email_and_password =>
      'Please enter both email and password.';

  @override
  String get incorrect_email_or_password => 'Incorrect email or password.';

  @override
  String get invalid_email_format => 'Invalid email format.';

  @override
  String get this_account_has_been_disabled =>
      'This account has been disabled.';

  @override
  String get too_many_requests_please_try_later =>
      'Too many requests. Please try again later.';

  @override
  String get email_not_verified => 'Email Not Verified';

  @override
  String get please_verify_your_email_to_continue =>
      'Please verify your email to continue.';

  @override
  String get are_you_sure_logout => 'Are you sure you want to logout?';

  @override
  String get have_error_occurred => 'An error has occurred. Please try again.';

  @override
  String get user_not_found => 'No account found with this email.';

  @override
  String get enter_otp_reset_password =>
      'We have sent an OTP code to your email. Please enter the OTP to reset your password.';

  @override
  String get not_time_yet_to_resend_otp =>
      'Please wait a moment while we resend the OTP code.';

  @override
  String get reset_password_successful => 'Password Reset Successful';

  @override
  String get reset_password_successful_description =>
      'Your password has been reset successfully. You can now log in with your new password.';

  @override
  String get welcome_back => 'Welcome Back';

  @override
  String get back_login => 'Back to Login';

  @override
  String get description_create_account =>
      'Take control of your finances today';

  @override
  String get label_weak => 'Weak';

  @override
  String get label_fair => 'Fair';

  @override
  String get label_good => 'Good';

  @override
  String get label_strong => 'Strong';

  @override
  String get low_pass =>
      'Must be at least 8 characters, with a number and a symbol.';

  @override
  String get weak_pass => 'Too short. Please add more characters.';

  @override
  String get fair_pass => 'Better. Try adding numbers and symbols!';

  @override
  String get good_pass_char =>
      'Almost there! Add a special character to make it stronger.';

  @override
  String get good_pass_num => 'Almost there! Add a number to make it stronger.';

  @override
  String get good_pass_special =>
      'Almost there! Add any character to make it stronger.';

  @override
  String get strong_pass => 'Great! Your password is secure.';

  @override
  String get password_reset_email_sent =>
      'We have sent a password reset link to your email.';

  @override
  String get forgot_password_description =>
      'Enter the email associated with your account to reset your password.';

  @override
  String get send_email_reset => 'Send Email Reset';

  @override
  String get password_weak_password => 'The password provided is too weak.';

  @override
  String get please_edit_fields =>
      'Please edit the following fields to proceed:';

  @override
  String get something_went_wrong => 'Something went wrong. Please try again.';

  @override
  String get email_already_in_use =>
      'The email address is already in use by another account.';

  @override
  String get invalid_email => 'The email address is not valid.';

  @override
  String get operation_not_allowed =>
      'Operation not allowed. Please contact support.';

  @override
  String get network_error =>
      'Network error. Please check your connection and try again.';

  @override
  String get reset_password => 'Reset Password';

  @override
  String get email_not_received => 'Email not received?';

  @override
  String get verification_email_sent => 'Verification Email Sent';

  @override
  String get good_morning => 'Good Morning';

  @override
  String get good_afternoon => 'Good Afternoon';

  @override
  String get good_evening => 'Good Evening';

  @override
  String get hello => 'Hello';

  @override
  String get income => 'Income';

  @override
  String get expenses => 'Expenses';

  @override
  String get balance => 'Balance';

  @override
  String get total_balance => 'Total Balance';

  @override
  String get spending_this_month => 'Spending This Month';

  @override
  String get total_spent => 'Total Spent';

  @override
  String get recent_transactions => 'Recent Transactions';

  @override
  String get add_transaction => 'Add Transaction';

  @override
  String get no_transactions => 'No data available';

  @override
  String get enter_transaction_name => 'Enter transaction name';

  @override
  String get suggested_category => 'Suggested Category';

  @override
  String get category => 'Category';

  @override
  String get categories => 'Categories';

  @override
  String get select_category => 'Select Category';

  @override
  String get edit_category => 'Edit Category';

  @override
  String are_you_sure_delete_category(String categoryName) {
    return 'Are you sure you want to delete $categoryName?';
  }

  @override
  String get system_category => 'System categories cannot be deleted.';

  @override
  String get system_category_description =>
      'You cannot edit or delete this default category.';

  @override
  String get category_food => 'Food';

  @override
  String get category_transport => 'Transport';

  @override
  String get category_salary => 'Salary';

  @override
  String get category_shopping => 'Shopping';

  @override
  String get category_game => 'Game';

  @override
  String get category_house => 'House';

  @override
  String get category_gift => 'Gift';

  @override
  String get category_health => 'Health';

  @override
  String get category_entertainment => 'Entertainment';

  @override
  String get category_bill => 'Bills';

  @override
  String get category_insurance => 'Insurance';

  @override
  String get category_education => 'Education';

  @override
  String get category_pet => 'Pet';

  @override
  String get category_travel => 'Travel';

  @override
  String get category_savings => 'Savings';

  @override
  String get category_phone => 'Phone';

  @override
  String get category_internet => 'Internet';

  @override
  String get category_water => 'Water';

  @override
  String get category_electricity => 'Electricity';

  @override
  String get category_gas => 'Gas';

  @override
  String get category_cleaning => 'Cleaning';

  @override
  String get category_beauty => 'Beauty';

  @override
  String get category_baby => 'Baby';

  @override
  String get category_sport => 'Sport';

  @override
  String get category_music => 'Music';

  @override
  String get category_repair => 'Repair';

  @override
  String get category_tax => 'Tax';

  @override
  String get note => 'Note (optional)';

  @override
  String get enter_note => 'Enter note';

  @override
  String get add_income => 'Add Income';

  @override
  String get add_expense => 'Add Expense';

  @override
  String get search_category => 'Search Category';

  @override
  String get no_category_found => 'No category found';

  @override
  String get most_used => 'Most Used';

  @override
  String get category_suggestions => 'Category Suggestions';

  @override
  String get all_categories => 'All Categories';

  @override
  String get new_category => 'New Category';

  @override
  String get category_name => 'Category Name';

  @override
  String get category_color => 'Category Color';

  @override
  String get category_icon => 'Category Icon';

  @override
  String get vs_last_month => 'vs Last Month';

  @override
  String get transaction => 'Transaction';

  @override
  String get delete_transaction => 'Delete Transaction';

  @override
  String get delete_transaction_confirmation =>
      'Are you sure you want to delete this transaction?';

  @override
  String get transaction_details => 'Transaction Details';

  @override
  String get spending_trend => 'Spending Trend';

  @override
  String get spending_last_7_days => 'Spending in the Last 7 Days';

  @override
  String get note_2 => 'Note';

  @override
  String get scan_receipt => 'Scan Receipt';

  @override
  String get add_via_voice => 'Add via Voice';

  @override
  String get add_manually => 'Add Manually';

  @override
  String get limit_reached => 'Limit Reached';

  @override
  String limit_reached_description(String featureName, String limit) {
    return 'You have used $featureName $limit times today.\nPlease come back tomorrow or upgrade to Premium.';
  }

  @override
  String get align_receipt => 'Align your receipt';

  @override
  String get listening => 'Listening...';

  @override
  String get voice_example => 'e.g., I spent 50 dollars on groceries';

  @override
  String get tap_to_stop => 'Tap to Stop';

  @override
  String get tap_to_listen => 'Tap to Listen';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get your_monthly_budget => 'Your Monthly Budget';

  @override
  String get spent => 'Spent ';

  @override
  String get out_of => ' out of ';

  @override
  String get left_to_spend => 'left to spend';

  @override
  String get add_budget => 'Add Budget';

  @override
  String get no_budgets_yet => 'No budgets yet';

  @override
  String get create_budget_description => 'Tap + to create a spending limit';

  @override
  String get edit_budget => 'Edit Budget';

  @override
  String are_you_sure_delete_budget(String budgetName) {
    return 'Are you sure you want to delete \n $budgetName?';
  }

  @override
  String get delete_budget => 'Delete Budget';

  @override
  String get settings => 'Settings';

  @override
  String get settings_description =>
      'Keep your finance data synced across all your devices';

  @override
  String get sign_in_now => 'Sign in now';

  @override
  String get get_started => 'Get Started';

  @override
  String get welcome => 'Welcome !';

  @override
  String get general => 'General';

  @override
  String get security => 'Security';

  @override
  String get privacy_and_security => 'Privacy & Security';

  @override
  String get support => 'Support';

  @override
  String get profile => 'Profile';

  @override
  String get language => 'Language';

  @override
  String get dark_mode => 'Dark Mode';

  @override
  String get notifications => 'Notifications';

  @override
  String get appearance => 'Appearance';

  @override
  String get currency => 'Currency';

  @override
  String get about => 'About';

  @override
  String get terms_of_service => 'Terms of Service';

  @override
  String get privacy_policy => 'Privacy Policy';

  @override
  String get version => 'Version';

  @override
  String get edit_profile => 'Edit Profile';

  @override
  String get full_name => 'Full Name';

  @override
  String get enter_full_name => 'Enter full name';

  @override
  String get email_address => 'Email Address';

  @override
  String get enter_email_address => 'Enter email address';

  @override
  String get phone_number => 'Phone Number';

  @override
  String get enter_phone_number => 'Enter phone number';

  @override
  String get day_of_birth => 'Date of Birth';

  @override
  String get select_day_of_birth => 'Select date of birth';

  @override
  String get save_changes => 'Save Changes';

  @override
  String get profile_updated_success => 'Profile updated successfully!';

  @override
  String get error_updating_profile => 'Error updating profile.';

  @override
  String get error_uploading_avatar => 'Error uploading avatar.';

  @override
  String get require_premium_to_edit_avatar =>
      'You need to upgrade to Premium or watch ads to edit your avatar.';

  @override
  String get edit_avatar => 'Edit Avatar';

  @override
  String get upgrade_premium => 'Upgrade to Premium!';

  @override
  String get upgrade_premium_description =>
      'Unlock exclusive features and enhance your experience.';

  @override
  String get upgrade_now => 'Upgrade Now';

  @override
  String get you_are_premium => 'You\'re All Set, Premium User!';

  @override
  String get you_are_premium_description => 'Enjoy your enhanced experience.';

  @override
  String get import_export_data => 'Import/Export Data';

  @override
  String get sync_data => 'Sync Data';

  @override
  String continue_with(String price) {
    return 'Continue with $price';
  }

  @override
  String get biometric_authentication => 'Biometric Authentication';

  @override
  String get password_security => 'Password Security';

  @override
  String get face_id_description =>
      'Unlock your app with a glance. Face ID offers convenient and secure access using your unique facial features.';

  @override
  String get touch_id_description =>
      'Unlock your app with a touch. Touch ID provides quick and secure access using your fingerprint.';

  @override
  String get pass_code_description =>
      'Add an extra layer of protection. A passcode ensures only you can access your financial data, even if your device is compromised.';

  @override
  String get passcode => 'Passcode';

  @override
  String get change_passcode => 'Change Passcode';

  @override
  String get old_passcode => 'Old Passcode';

  @override
  String get enter_old_passcode => 'Enter old passcode';

  @override
  String get new_passcode => 'New Passcode';

  @override
  String get enter_new_passcode => 'Enter new passcode';

  @override
  String get confirm_new_passcode => 'Confirm New Passcode';

  @override
  String get enter_confirm_new_passcode => 'Enter confirm new passcode';

  @override
  String get turnOffPasscode => 'Turn Off Passcode';

  @override
  String get createPasscode => 'Create Passcode';

  @override
  String get changePasscode => 'Change Passcode';

  @override
  String get removePasscode => 'Remove Passcode';

  @override
  String get updatePasscode => 'Update Passcode';

  @override
  String get description_create_passcode =>
      'Protect your account by regularly updating your 6-digit passcode.';

  @override
  String get description_remove_passcode =>
      'Enter your current passcode to disable security.';

  @override
  String get currentPasscode => 'Current Passcode';

  @override
  String get enterCurrentPin => 'Enter current PIN';

  @override
  String get passcode_turn_off_success => 'Passcode turned off successfully!';

  @override
  String get passcode_update_success => 'Passcode updated successfully!';

  @override
  String get passcode_create_success => 'Passcode created successfully!';

  @override
  String get currentPasscodeIncorrect => 'Current passcode is incorrect.';

  @override
  String get errorSavingData => 'Error saving data.';

  @override
  String get newPasscodeMustBe6Digits => 'New passcode must be 6 digits.';

  @override
  String get passcodesDoNotMatch => 'Passcodes do not match.';

  @override
  String get enter_passcode => 'Enter Passcode';

  @override
  String get incorrect_passcode => 'Incorrect passcode.';

  @override
  String get face => 'Face ID';

  @override
  String get fingerprint => 'Fingerprint';

  @override
  String get report_locked => ' Locked Content';

  @override
  String get unlock => 'Unlock';

  @override
  String get click_to_unlock => 'Click to Unlock';

  @override
  String get unlock_untilimited_access => 'Unlock Unlimited Access';

  @override
  String get unlock_untilimited_access_description =>
      'Upgrade to Premium to remove all limits and access advanced features.';

  @override
  String get daily_input_cap_reached => 'Daily Input Cap Reached';

  @override
  String get daily_input_cap_reached_description =>
      'You\'ve hit your daily limit for invoice scans and voice entries. Upgrade now to continue.';

  @override
  String get feature_comparison => 'Feature Comparison';

  @override
  String get feature => 'Feature';

  @override
  String get free => 'Free';

  @override
  String get premium => 'Premium';

  @override
  String get no_ads => 'No Ads';

  @override
  String get transaction_locking => 'Transaction Locking';

  @override
  String get unlimited_scans => 'Unlimited Invoice Scans';

  @override
  String get unlimited_voice_entries => 'Unlimited Voice Entries';

  @override
  String get day => 'day';

  @override
  String get year => 'Year';

  @override
  String get subscription_auto_renews => 'Subscription auto-renews.';

  @override
  String get accept_terms_conditions =>
      'Subscription auto-renews. By continuing, you agree to our Terms of Service and Privacy Policy.';

  @override
  String get restore => 'Restore';

  @override
  String used_up_daily_limit(String value) {
    return 'You\'ve used up your voice input limit for today. Watch an ad to get $value more uses or upgrade to Premium.';
  }

  @override
  String get monthly_plan => 'Monthly Plan';

  @override
  String get yearly_plan => 'Yearly Plan';

  @override
  String get lifetime_plan => 'Lifetime Plan';

  @override
  String get pay_once_enjoy_forever => 'Pay once, enjoy forever';

  @override
  String get yearly_discount => 'Save 20% with Yearly Plan';

  @override
  String get best_value => 'BEST VALUE';

  @override
  String get transaction_cancelled => 'Transaction cancelled.';

  @override
  String get purchase_successful => 'Purchase Successful!';

  @override
  String get purchase_successful_description =>
      'Thank you for upgrading to Premium! Enjoy your enhanced experience.';

  @override
  String get restore_successful => 'Restore Successful!';

  @override
  String get restore_successful_description =>
      'Your previous purchase has been restored. Enjoy your Premium features!';

  @override
  String get nothing_to_restore => 'Nothing to Restore';

  @override
  String get nothing_to_restore_description =>
      'No previous purchases were found to restore.';

  @override
  String get restore_failed => 'Restore Failed';

  @override
  String get restore_failed_description =>
      'An error occurred while restoring your purchase. Please try again.';

  @override
  String get purchase_failed => 'Purchase Failed';

  @override
  String get purchase_failed_description =>
      'An error occurred during the transaction. Please try again.';

  @override
  String get purchase_canceled => 'Purchase Canceled';

  @override
  String get purchase_canceled_description =>
      'The transaction was canceled. No changes were made to your account.';

  @override
  String get premium_sync_account =>
      'Your Premium account will be synced with the account you sign in to. Please ensure you sign in with the same account on all your devices for a seamless Premium experience.';

  @override
  String get premium_sync_warning =>
      'Note: If you purchased a Premium package on a different account, please sign in to that account to restore your Premium access. If you are using the same account, try restoring your purchase to sync your Premium access.';

  @override
  String get select_language => 'Select Language';

  @override
  String get suggested => 'Suggested';

  @override
  String get all_languages => 'All Languages';

  @override
  String get apply_changes => 'Apply Changes';

  @override
  String get select_currency => 'Select Currency';

  @override
  String get search_currency => 'Search currency or country...';

  @override
  String get popular => 'Popular';

  @override
  String get all_currencies => 'All Currencies';

  @override
  String get currency_change_warning =>
      'Changing currency will only update the display symbol. Past transaction rates will not be recalculated.';

  @override
  String see_ads(String additionalUses) {
    return 'See Ads (+$additionalUses uses)';
  }

  @override
  String get ads_loading => 'Ads Loading...';

  @override
  String get data_management => 'Data Management';

  @override
  String get select_format => 'Select Format';

  @override
  String get export_data => 'Export Data';

  @override
  String get export_data_description =>
      'Export your financial data for backup or analysis.';

  @override
  String get confirm_export => 'Confirm Export';

  @override
  String get import_data => 'Import Data';

  @override
  String get import_data_title => 'Let\'s get your ';

  @override
  String get data => 'data';

  @override
  String get import_data_title_2 => ' in.';

  @override
  String get import_data_description =>
      'Import financial data from external sources to synchronize with the application.';

  @override
  String get confirm_import => 'Confirm Import';

  @override
  String get csv_format => 'CSV Format';

  @override
  String get csv_description =>
      'Export data in CSV format, compatible with most spreadsheet applications.';

  @override
  String get json_format => 'JSON Format';

  @override
  String get json_description =>
      'Export data in JSON format, suitable for developers and advanced users.';

  @override
  String get excel_format => 'Excel Format';

  @override
  String get excel_description =>
      'Export data in Excel format, ideal for detailed financial analysis.';

  @override
  String get select_file => 'Select File';

  @override
  String get no_file_selected => 'No file selected.';

  @override
  String get import_successful => 'Import Successful';

  @override
  String get error_importing_data =>
      'Error importing data. Please ensure the file format is correct.';

  @override
  String get sync_data_now => 'Sync Now';

  @override
  String last_synced(String time) {
    return 'Last Synced: \n$time';
  }

  @override
  String get syncing => 'Syncing...';

  @override
  String get never_synced => 'Never Synced';

  @override
  String get unauthenticated =>
      'Please log in to sync your data across devices.';

  @override
  String sync_error(String error) {
    return 'Sync error: $error';
  }

  @override
  String get premium_required_to_sync =>
      'You need to upgrade to Premium or watch ads to sync data.';

  @override
  String get sync_in_progress => 'Sync in progress, please wait.';

  @override
  String cooldown(String seconds) {
    return 'You\'re acting too quickly. Please wait $seconds seconds before syncing again.';
  }

  @override
  String get accepted_formats => 'Accepted Formats';

  @override
  String get select_file_to_import => 'Select a file to import';

  @override
  String get tap_to_browse =>
      'Tap to browse your device or cloud\nstorage for files.';

  @override
  String get protected => 'Protected';

  @override
  String get protected_description =>
      'Your data never leaves your device and is processed locally.';

  @override
  String get recent_imports => 'Recent Imports';

  @override
  String get no_recent_imports => 'No recent data imports';

  @override
  String get invalid_format => 'Invalid file format.';

  @override
  String get import_success => 'Imported successfully!';

  @override
  String import_success_description(String count) {
    return 'Imported successfully $count transactions from the file.';
  }

  @override
  String get file_format_template => 'File Format Template';

  @override
  String download_sample_file(String format) {
    return 'Download Sample File $format';
  }

  @override
  String get card => 'Card';

  @override
  String get font_selection => 'Font Selection';

  @override
  String get select_font => 'Select font';

  @override
  String get font => 'Font';

  @override
  String get font_description =>
      'A transaction a day keeps the \'Broke Month\' away.';

  @override
  String get reminder_title => 'Daily Expense Reminder';

  @override
  String get reminder_body => 'Have you logged your expenses for today? 💸';

  @override
  String get defaultTransactionTitle => 'New Transaction';

  @override
  String get invoice_analysis => 'Analyzing invoices...';

  @override
  String get mapbox_error =>
      'Map loading error. Please check your Mapbox token configuration.';

  @override
  String get location => 'Location';

  @override
  String get current_location => 'Current Location';

  @override
  String get select_location => 'Select Location';

  @override
  String get no_location_selected => 'No location selected';

  @override
  String get search_location => 'Search location...';

  @override
  String get tap_to_change_location => 'Tap to change location';

  @override
  String get search_results => 'Search Results';

  @override
  String get no_location_found => 'No location found';

  @override
  String get recent_locations => 'Recent Locations';

  @override
  String get location_access_error => 'Location access error';

  @override
  String get location_permission_denied => 'Location permission denied.';

  @override
  String get location_permission_denied_description =>
      'Please enable location access in settings.';

  @override
  String get notification_permission_denied =>
      'Notification permission denied.';

  @override
  String get notification_permission_denied_description =>
      'Please enable notification access in settings to receive reminders.';

  @override
  String get permission_required_camera => 'Camera access denied';

  @override
  String get permission_required_camera_description =>
      'Please enable camera access in settings to use receipt scanning feature.';

  @override
  String get voice_input_error => 'Voice input error. Please try again.';

  @override
  String get voice_input_not_recognized =>
      'Voice input not recognized. Please try again.';

  @override
  String get voice_input_permission_denied =>
      'Voice input permission denied. Please enable microphone access in settings.';

  @override
  String get error_ai_request =>
      'The AI ​​cannot recognize this request. Please try to be more specific.';

  @override
  String get voice_analysis => 'Analyzing voice input...';

  @override
  String get scan_receipt_error => 'Receipt scanning error. Please try again.';

  @override
  String get requires_premium =>
      'This feature requires watching ads to use or upgrading to Premium.';

  @override
  String get watch_ad_continue => 'Watch Ad to Continue';

  @override
  String get permission_required_voice_input => 'Microphone access denied';

  @override
  String get permission_required_voice_input_description =>
      'Please enable microphone access in settings to use voice input.';

  @override
  String get permission_required_location => 'Location access denied';

  @override
  String get permission_required_location_description =>
      'Please enable location access in settings to use location features.';

  @override
  String get congratulations => 'Congratulations!';

  @override
  String get successfully_purchased =>
      'You have successfully purchased Premium. Enjoy your enhanced experience!';

  @override
  String get cancel_purchase => 'Cancel Purchase';

  @override
  String get restore_no_purchase_description =>
      'No previous purchases were found to restore.';

  @override
  String get ai_powered => 'AI Powered';

  @override
  String get entries_pending => 'Entries Pending';

  @override
  String get confirm_selected_entries => 'Add selected entries';

  @override
  String get preview_results => 'Preview results';

  @override
  String get clear_all => 'Clear all';

  @override
  String get select_all => 'Select all';

  @override
  String get fail_to_save_transactions =>
      'Failed to save transactions. Please try again.';

  @override
  String get tap_to_check_in => 'Tap to check in';

  @override
  String get keep_your_streak => 'Keep your streak!';

  @override
  String keep_your_streak_day(String streak) {
    return 'Keep your $streak-day streak!';
  }

  @override
  String get streak => 'Streak';

  @override
  String streak_days(String days) {
    return '$days days';
  }

  @override
  String get not_logined => 'Not Logged In';

  @override
  String get please_login_to_sync_data =>
      'Please log in to sync your data across devices.';

  @override
  String get require_premium_to_sync =>
      'You need to upgrade to Premium or watch ads to sync data.';

  @override
  String get information_and_support => 'Information & Support';

  @override
  String get contact_support => 'Contact Support';

  @override
  String get send_email => 'Send Email';

  @override
  String get describe_issue =>
      'Describe your issue or question in detail. Our support team will get back to you as soon as possible.';

  @override
  String get feedback => 'Feedback';

  @override
  String get feedback_description =>
      'We\'d love to hear your thoughts and suggestions to help us improve SpendFlow. Please share your feedback with us!';

  @override
  String get thank_you_feedback => 'Thank you for your feedback!';

  @override
  String get submit_feedback => 'Submit Feedback';

  @override
  String get report_issue => 'Report Issue';

  @override
  String get submit_issue => 'Submit Issue';

  @override
  String get report_issue_description =>
      'If you encounter any bugs or issues, please report them here. Your input helps us improve the app for everyone.';

  @override
  String get thank_you_issue =>
      'Thank you for reporting the issue! We will look into it as soon as possible.';

  @override
  String get request_delete_account => 'Request Account Deletion';

  @override
  String get delete_account_description =>
      'If you wish to delete your account, please let us know why you want to delete it. We will process your request as soon as possible.';

  @override
  String get submit_delete_request => 'Submit Request';

  @override
  String get select_subject => 'Select Subject';

  @override
  String get please_enter_content => 'Please enter content';

  @override
  String get subject => 'Subject';

  @override
  String get content => 'Content';

  @override
  String get send_contact_success =>
      'Your message has been sent successfully! We will get back to you as soon as possible.';

  @override
  String get send_contact_error =>
      'An error occurred while sending your message. Please try again.';

  @override
  String get contact_info => 'Contact Information';

  @override
  String get email_placeholder => 'Enter your email';

  @override
  String get name_placeholder => 'Enter your name';

  @override
  String get invalid_name => 'Please enter a valid name.';

  @override
  String get mrs => 'Mrs.';

  @override
  String get mr => 'Mr.';

  @override
  String get ms => 'Ms.';

  @override
  String get salutation => 'Salutation';

  @override
  String get delete_account => 'Delete Account';

  @override
  String get delete_account_confirmation =>
      'Are you sure you want to delete your account? This action cannot be undone and will delete all your data.';

  @override
  String get failed_to_send_deletion_request =>
      'Failed to send account deletion request. Please try again.';

  @override
  String get requires_recent_login_description =>
      'For security reasons, please sign out and sign back in before attempting to delete your account.';

  @override
  String get delete_account_failed =>
      'An error occurred while deleting your account. Please try again.';
}
