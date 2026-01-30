import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/screen/setting/security/passcode/create_or_update_viewmodel.dart';

class CreateOrUpdateView extends StatefulWidget {
  final bool isChangeMode;
  final bool isRemoveMode;

  const CreateOrUpdateView({
    super.key,
    this.isChangeMode = false,
    this.isRemoveMode = false,
  });

  @override
  State<CreateOrUpdateView> createState() => _CreateOrUpdateViewState();
}

class _CreateOrUpdateViewState extends State<CreateOrUpdateView> {
  late final CreateOrUpdateViewModel _viewModel;

  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  final FocusNode _currentFocus = FocusNode();
  final FocusNode _newFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _viewModel = CreateOrUpdateViewModel(
      isChangeMode: widget.isChangeMode,
      isRemoveMode: widget.isRemoveMode,
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    _currentFocus.dispose();
    _newFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  void _onSubmit() async {
    FocusScope.of(context).unfocus();

    final error = await _viewModel.submit(
      currentCode: _currentController.text,
      newCode: _newController.text,
      confirmCode: _confirmController.text,
      context: context,
    );

    if (!mounted) return;

    if (error != null) {
      _showError(error);
    } else {
      Navigator.pop(context, true);
    }
  }

  void _showError(String message) {
    final l10n = AppLocalizations.of(context)!;

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.error,
      message: message,
      icon: 'exclamationmark.circle.fill',
      actions: [
        AlertAction(
          title: l10n.ok,
          style: AlertActionStyle.primary,
          onPressed: () {},
        ),
      ],
    );
  }

  String _getTitle(AppLocalizations l10n) {
    if (widget.isRemoveMode) return l10n.turnOffPasscode;
    if (widget.isChangeMode) return l10n.changePasscode;
    return l10n.createPasscode;
  }

  String _getButtonLabel(AppLocalizations l10n) {
    if (widget.isRemoveMode) return l10n.turnOffPasscode;
    if (widget.isChangeMode) return l10n.updatePasscode;
    return l10n.createPasscode;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: null,
          padding: EdgeInsetsDirectional.only(start: 10.w),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoTheme.of(context).primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
          middle: Text(
            _getTitle(l10n),
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          ),
          backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.isRemoveMode
                            ? l10n.description_remove_passcode
                            : l10n.description_create_passcode,
                        textAlign: TextAlign.center,
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
                              color: CupertinoColors.systemGrey,
                              fontSize: 13.sp,
                            ),
                      ),

                      SizedBox(height: 20.h),

                      if (widget.isChangeMode || widget.isRemoveMode) ...[
                        _buildSectionTitle(l10n.currentPasscode),
                        SizedBox(height: 12.h),
                        _buildPinCodeInput(
                          controller: _currentController,
                          focusNode: _currentFocus,
                          isAutoFocus: true,
                          nextFocus: _newFocus,
                        ),
                        SizedBox(height: 30.h),
                      ],

                      if (!widget.isRemoveMode) ...[
                        _buildSectionTitle(l10n.new_passcode),
                        SizedBox(height: 12.h),
                        _buildPinCodeInput(
                          controller: _newController,
                          focusNode: _newFocus,
                          isAutoFocus: !widget.isChangeMode,
                          prevFocus:
                              (widget.isChangeMode || widget.isRemoveMode)
                              ? _currentFocus
                              : null,
                          nextFocus: _confirmFocus,
                        ),

                        SizedBox(height: 24.h),

                        _buildSectionTitle(l10n.confirm_new_passcode),
                        SizedBox(height: 12.h),
                        _buildPinCodeInput(
                          controller: _confirmController,
                          focusNode: _confirmFocus,
                          isAutoFocus: false,
                          prevFocus: _newFocus,
                        ),
                      ],

                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: CupertinoButton(
                  color: CupertinoTheme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30.r),
                  onPressed: _onSubmit,
                  child: Text(
                    _getButtonLabel(l10n),
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: CupertinoTheme.of(context).textTheme.textStyle.color,
        ),
      ),
    );
  }

  Widget _buildPinCodeInput({
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool isAutoFocus,
    FocusNode? prevFocus,
    FocusNode? nextFocus,
  }) {
    return AnimatedBuilder(
      animation: Listenable.merge([controller, focusNode]),
      builder: (context, child) {
        return SizedBox(
          height: 60.h,
          child: Stack(
            children: [
              Positioned.fill(
                child: CupertinoTextField(
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: isAutoFocus,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: const TextStyle(color: Colors.transparent),
                  cursorColor: Colors.transparent,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    HapticFeedback.lightImpact();
                    if (value.length == 6 && nextFocus != null) {
                      nextFocus.requestFocus();
                    }
                    if (value.isEmpty && prevFocus != null) {
                      prevFocus.requestFocus();
                    }
                  },
                ),
              ),

              IgnorePointer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    final isFilled = index < controller.text.length;
                    final isFocused =
                        focusNode.hasFocus && index == controller.text.length;

                    return _buildSingleDigitBox(
                      isFilled: isFilled,
                      isFocused: isFocused && FocusScope.of(context).hasFocus,
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSingleDigitBox({
    required bool isFilled,
    required bool isFocused,
  }) {
    final theme = CupertinoTheme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: 48.w,
      height: 56.h,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2C2C2E) : CupertinoColors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: isFocused
              ? theme.primaryColor
              : (isDarkMode ? Colors.white12 : Colors.black12),
          width: isFocused ? 2 : 1,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: isFilled
            ? Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: theme.textTheme.textStyle.color,
                  shape: BoxShape.circle,
                ),
              )
            : null,
      ),
    );
  }
}
