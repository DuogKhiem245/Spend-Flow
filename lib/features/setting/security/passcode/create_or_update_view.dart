import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/features/setting/security/passcode/create_or_update_viewmodel.dart';

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
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(l10n.error),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.ok),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
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
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          ),
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
                        style: TextStyle(
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
                          isAutoFocus: true,
                        ),
                        SizedBox(height: 30.h),
                      ],

                      if (!widget.isRemoveMode) ...[
                        _buildSectionTitle(l10n.new_passcode),
                        SizedBox(height: 12.h),
                        _buildPinCodeInput(
                          controller: _newController,
                          isAutoFocus: !widget.isChangeMode,
                        ),

                        SizedBox(height: 24.h),

                        _buildSectionTitle(l10n.confirm_new_passcode),
                        SizedBox(height: 12.h),
                        _buildPinCodeInput(
                          controller: _confirmController,
                          isAutoFocus: false,
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
                    style: TextStyle(
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
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: CupertinoTheme.of(context).textTheme.textStyle.color,
        ),
      ),
    );
  }

  Widget _buildPinCodeInput({
    required TextEditingController controller,
    required bool isAutoFocus,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return SizedBox(
          height: 60.h, 
          child: Stack(
            children: [
              Positioned.fill(
                child: CupertinoTextField(
                  controller: controller,
                  autofocus: isAutoFocus,
                  keyboardType: TextInputType.number,
                  maxLength: 6, 
                  style: const TextStyle(color: Colors.transparent),
                  cursorColor: Colors.transparent,
                  decoration: const BoxDecoration(color: Colors.transparent),

                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),

              IgnorePointer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    final isFilled = index < controller.text.length;
                    final isFocused = index == controller.text.length;

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
        color: isDarkMode
            ? const Color(0xFF2C2C2E) 
            : CupertinoColors.white,

        borderRadius: BorderRadius.circular(12.r),

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
