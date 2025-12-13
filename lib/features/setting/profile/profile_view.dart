import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/utils/date_helper.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  DateTime _selectedDob = DateTime(1990, 1, 1);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "John Doe");
    _emailController = TextEditingController(text: "john.doe@email.com");
    _phoneController = TextEditingController(text: "+1 (555) 123-4567");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: null,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoTheme.of(context).primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          l10n.edit_profile,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              _buildAvatar(),

              SizedBox(height: 30.h),

              _buildInfoItem(
                label: l10n.full_name,
                controller: _nameController,
                cardColor: CupertinoTheme.of(context).barBackgroundColor,
              ),
              SizedBox(height: 20.h),

              _buildInfoItem(
                label: l10n.email_address,
                controller: _emailController,
                isReadOnly: true,
                cardColor: CupertinoTheme.of(context).barBackgroundColor,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.h),

              _buildInfoItem(
                label: l10n.phone_number,
                controller: _phoneController,
                cardColor: CupertinoTheme.of(context).barBackgroundColor,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20.h),

              _buildInfoItem(
                label: l10n.day_of_birth,
                textValue: DateFormat('dd/MM/yyyy').format(_selectedDob),
                cardColor: CupertinoTheme.of(context).barBackgroundColor,
                icon: CupertinoIcons.calendar,
                onTap: () {
                  DateHelper.showDatePicker(
                    context,
                    initialDate: _selectedDob,
                    onDateChanged: (newDate) {
                      setState(() {
                        _selectedDob = newDate;
                      });
                    },
                  );
                },
              ),

              SizedBox(height: 40.h),
              CupertinoButton(
                onPressed: () {
                  // Handle save action
                },
                minimumSize: Size(double.infinity, 50.h),
                borderRadius: BorderRadius.circular(30.r),
                color: AppColors.primaryColor,
                child: Text(
                  l10n.save_changes,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: 140.w,
          height: 140.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFD4BBA3), Color(0xFFF0E4D7)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Icon(
            CupertinoIcons.person_fill,
            size: 80.w,
            color: CupertinoColors.white,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(6.w),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.pencil,
              size: 24.w,
              color: CupertinoColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required String label,
    required Color cardColor,
    TextEditingController? controller, 
    String? textValue, 
    TextInputType? keyboardType,
    bool isReadOnly = false,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 14.sp,
            color: CupertinoColors.systemGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.boxShadow,
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: controller != null
                    ? CupertinoTextField(
                        controller: controller,
                        readOnly: isReadOnly,
                        onTap: onTap,
                        keyboardType: keyboardType,
                        decoration: null,
                        padding: EdgeInsets.zero,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: isReadOnly
                              ? CupertinoColors.systemGrey
                              : CupertinoTheme.of(
                                  context,
                                ).textTheme.textStyle.color,
                        ),
                        cursorColor: CupertinoColors.activeBlue,
                      )
                    : GestureDetector(
                        onTap: onTap,
                        behavior: HitTestBehavior
                            .opaque, 
                        child: Text(
                          textValue ?? '',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color,
                          ),
                        ),
                      ),
              ),
              if (icon != null) ...[
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: controller == null ? onTap : null,
                  child: Icon(
                    icon,
                    color: CupertinoColors.systemGrey,
                    size: 20.w,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
