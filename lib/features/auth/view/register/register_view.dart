import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/services/auth_service.dart';
import 'package:spend_flow/core/widgets/check_valid/check_valid_widget.dart';
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

  Future<void> _handleRegister() async {
    FocusScope.of(context).unfocus();

    final l10n = AppLocalizations.of(context)!;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPass = _confirmPasswordController.text.trim();

    List<String> missingFields = [];
    String title = l10n.incomplete_details;
    String description = l10n.please_fill_required_fields;

    if (email.isEmpty) missingFields.add(l10n.email);
    if (password.isEmpty) missingFields.add(l10n.password);
    if (confirmPass.isEmpty) missingFields.add(l10n.confirm_password);

    if (missingFields.isEmpty) {
      if (password != confirmPass) {
        title = l10n.passwords_mismatch;
        description = l10n.please_edit_fields;
        missingFields.addAll([l10n.password, l10n.confirm_password]);
      } else if (!PasswordStrength.isValid(password)) {
        title = l10n.password_weak_password;
        description = l10n.please_edit_fields;
        missingFields.add(l10n.password);
      }
    }

    if (missingFields.isNotEmpty) {
      CheckValidWidget.showIncompleteDetailsSheet(
        context: context,
        title: title,
        description: description,
        missingFields: missingFields,
        buttonText: "OK",
      );
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
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getFirebaseErrorMessage(e, l10n);
      if (mounted) {
        CheckValidWidget.showIncompleteDetailsSheet(
          context: context,
          title: l10n.error,
          description: errorMessage,
          buttonText: "OK",
        );
      }
      return;
    } catch (e) {
      if (mounted) {
        CheckValidWidget.showIncompleteDetailsSheet(
          context: context,
          title: l10n.error,
          description: l10n.something_went_wrong,
          buttonText: "OK",
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _getFirebaseErrorMessage(
    FirebaseAuthException e,
    AppLocalizations l10n,
  ) {
    switch (e.code) {
      case 'email-already-in-use':
        return l10n.email_already_in_use;
      case 'invalid-email':
        return l10n.invalid_email;
      case 'operation-not-allowed':
        return l10n.operation_not_allowed;
      case 'weak-password':
        return l10n.password_weak_password;
      case 'network-request-failed':
        return l10n.network_error;
      default:
        return e.message ?? l10n.something_went_wrong;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsetsDirectional.only(end: 10.w),
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoTheme.of(context).primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                        .copyWith(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 30.h),

                  Container(
                    padding: EdgeInsets.all(15.w),
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: CupertinoTheme.of(context).barBackgroundColor,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(
                        color: AppColors.borderColor.withValues(alpha: .5),
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
                                  style: CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle
                                      .copyWith(
                                        fontSize: 16.sp,
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
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(
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
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
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
        border: Border.all(
          color: AppColors.borderColor.withValues(alpha: .5),
          width: 0.5.w,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Icon(icon, size: 16.w, color: CupertinoColors.systemGrey),
          ),
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              keyboardType: inputType,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
              decoration: null,
              style: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.copyWith(fontSize: 14.sp),
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
        border: Border.all(
          color: AppColors.borderColor.withValues(alpha: .5),
          width: 0.5.w,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Icon(
              CupertinoIcons.lock_fill,
              size: 16.w,
              color: CupertinoColors.systemGrey,
            ),
          ),
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              obscureText: obscureText,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
              decoration: null,
              style: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.copyWith(fontSize: 14.sp),
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
                size: 18.w,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
