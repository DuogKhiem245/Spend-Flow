import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/services/auth_service.dart';
import 'package:spend_flow/core/widgets/password_strength/password_strength.dart';
import 'package:spend_flow/features/auth/view/register/check_mail_view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  String password = '';
  String confirmPassword = '';

  void _showErrorDialog(String message) {
    final l10n = AppLocalizations.of(context)!;

    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(l10n.error),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(l10n.ok),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRegister() async {
    FocusScope.of(context).unfocus();

    final l10n = AppLocalizations.of(context)!;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPass = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPass.isEmpty) {
      _showErrorDialog(l10n.please_fill_all_fields);
      return;
    }

    if (password != confirmPass) {
      _showErrorDialog(l10n.passwords_mismatch);
      return;
    }

    if (!PasswordStrength.isValid(password)) {
      _showErrorDialog(l10n.weak_pass);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final credential = await _authService.signUpWithEmail(
        email: email,
        password: password,
      );

      if (credential != null && credential.user != null) {
        await credential.user!.sendEmailVerification();

        await _authService.signOut();

        if (mounted) {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => CheckMailPage(email: email),
            ),
          );
        }
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: SafeArea(
        top: true,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.translucent,
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: SizedBox(
                      width: 100.w,
                      height: 100.w,
                      child: Image.asset(
                        CupertinoTheme.of(context).brightness == Brightness.dark
                            ? 'lib/assets/images/logoDark.png'
                            : 'lib/assets/images/logoLight.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    l10n.create_account,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(fontSize: 28.sp, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 30.h),

                  Container(
                    padding: EdgeInsets.all(15.w),
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: CupertinoTheme.of(context).barBackgroundColor,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 0.5.w,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildLabel(l10n.email, context),
                        SizedBox(height: 8.h),
                        _buildTextField(
                          context: context,
                          controller: _emailController,
                          placeholder: l10n.enter_email,
                          icon: CupertinoIcons.mail_solid,
                          inputType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 16.h),

                        _buildLabel(l10n.password, context),
                        SizedBox(height: 8.h),
                        _buildPasswordField(
                          context: context,
                          controller: _passwordController,
                          placeholder: l10n.password,
                          obscureText: _obscurePassword,
                          onToggle: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),

                        SizedBox(height: 16.h),

                        Container(
                          padding: EdgeInsets.only(left: 8.w),
                          child: PasswordStrength(password: password),
                        ),

                        SizedBox(height: 16.h),

                        _buildLabel(l10n.confirm_password, context),
                        SizedBox(height: 8.h),
                        _buildPasswordField(
                          context: context,
                          controller: _confirmPasswordController,
                          placeholder: l10n.confirm_password,
                          obscureText: _obscureConfirmPassword,
                          onToggle: () => setState(
                            () => _obscureConfirmPassword =
                                !_obscureConfirmPassword,
                          ),
                          onChanged: (value) {
                            setState(() {
                              confirmPassword = value;
                            });
                          },
                        ),

                        SizedBox(height: 24.h),

                        CupertinoButton.filled(
                          onPressed: _isLoading ? null : _handleRegister,
                          borderRadius: BorderRadius.circular(30.r),
                          child: _isLoading
                              ? CupertinoActivityIndicator(
                                  color: CupertinoTheme.of(
                                    context,
                                  ).textTheme.textStyle.color,
                                )
                              : Text(
                                  l10n.register,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),

                        SizedBox(height: 10.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.have_account,
                              style: CupertinoTheme.of(
                                context,
                              ).textTheme.textStyle.copyWith(fontSize: 14.sp),
                            ),
                            SizedBox(width: 4.w),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Text(
                                l10n.login,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, BuildContext context) {
    return Text(
      text,
      style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String placeholder,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: AppColors.borderColor, width: 0.5.w),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Icon(icon, size: 20.w, color: CupertinoColors.systemGrey),
          ),
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              keyboardType: inputType,
              padding: EdgeInsets.all(16.w),
              decoration: null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required BuildContext context,
    required TextEditingController controller,
    required String placeholder,
    required bool obscureText,
    required VoidCallback onToggle,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: AppColors.borderColor, width: 0.5.w),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Icon(
              CupertinoIcons.lock_fill,
              size: 20.w,
              color: CupertinoColors.systemGrey,
            ),
          ),
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              obscureText: obscureText,
              padding: EdgeInsets.all(16.w),
              decoration: null,
              onChanged: (value) {
                setState(() {
                  onChanged(value);
                });
              },
            ),
          ),
          GestureDetector(
            onTap: onToggle,
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Icon(
                obscureText
                    ? CupertinoIcons.eye_slash_fill
                    : CupertinoIcons.eye_fill,
                size: 20.w,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
