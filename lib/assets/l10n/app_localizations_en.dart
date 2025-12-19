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
  String get onboard_step1_title => 'Simplify Your Finances';

  @override
  String get onboard_step1_message =>
      'All your accounts in one place. See where your money goes and achieve your financial goals effortlessly.';

  @override
  String get onboard_step2_title => 'Take Control of Your Spending';

  @override
  String get onboard_step2_message =>
      'Set spending limits, track categories, and stay on top of your financial goals with personal budgeting.';

  @override
  String get onboard_step3_title => 'Watch Your Savings Grow';

  @override
  String get onboard_step3_message =>
      'Set automated saving goals, round up transactions, and discover smart ways to save money with ease.';

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
  String are_you_sure_delete_category(Object categoryName) {
    return 'Are you sure you want to delete $categoryName? \n This action cannot be undone.';
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
  String get scan_receipt => 'Scan Receipt';

  @override
  String get add_via_voice => 'Add via Voice';

  @override
  String get add_manually => 'Add Manually';

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
  String are_you_sure_delete_budget(Object budgetName) {
    return 'Are you sure you want to delete $budgetName? \n This action cannot be undone.';
  }

  @override
  String get settings => 'Settings';

  @override
  String get settings_description =>
      'Keep your finance data synced across all your devices';

  @override
  String get sign_in_now => 'Sign in now.';

  @override
  String get get_started => 'Get Started';

  @override
  String get welcome => 'Welcome !';

  @override
  String get general => 'General';

  @override
  String get security => 'Security';

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
  String get terms => 'Terms & Conditions';

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
  String get accept_terms_conditions =>
      'Subscription auto-renews. By continuing, you agree to our Terms of Service and Privacy Policy.';

  @override
  String get restore => 'Restore';

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
}
