import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';

enum ContactSubject { feedback, bugReport, accountDeletion }

enum ContactSalutation { mr, mrs, ms, other }

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  ContactSubject _selectedSubject = ContactSubject.feedback;
  ContactSalutation _selectedSalutation = ContactSalutation.mr;

  bool _isLoading = false;
  bool _isLoggedIn = false;
  bool _hasInitialName = false;

  final LayerLink _subjectLayerLink = LayerLink();
  final LayerLink _salutationLayerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isSubjectDropdownOpen = false;
  bool _isSalutationDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (mounted) {
        setState(() {
          _isLoggedIn = true;
          if (user.email != null) {
            _emailController.text = user.email!;
          }
          if (user.displayName != null && user.displayName!.isNotEmpty) {
            _nameController.text = user.displayName!;
            _hasInitialName = true;
          }
        });
      }
    }
  }

  String _getSubjectText(ContactSubject subject, AppLocalizations l10n) {
    switch (subject) {
      case ContactSubject.feedback:
        return l10n.feedback;
      case ContactSubject.bugReport:
        return l10n.report_issue;
      case ContactSubject.accountDeletion:
        return l10n.request_delete_account;
    }
  }

  String _getSubmitText(ContactSubject subject, AppLocalizations l10n) {
    switch (subject) {
      case ContactSubject.feedback:
        return l10n.submit_feedback;
      case ContactSubject.bugReport:
        return l10n.submit_issue;
      case ContactSubject.accountDeletion:
        return l10n.submit_delete_request;
    }
  }

  String _getSalutationText(
    ContactSalutation salutation,
    AppLocalizations l10n,
  ) {
    switch (salutation) {
      case ContactSalutation.mr:
        return l10n.mr;
      case ContactSalutation.mrs:
        return l10n.mrs;
      case ContactSalutation.ms:
        return l10n.ms;
      case ContactSalutation.other:
        return l10n.other;
    }
  }

  void _closeDropdown() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      if (mounted) {
        setState(() {
          _isSubjectDropdownOpen = false;
          _isSalutationDropdownOpen = false;
        });
      }
    }
  }

  void _showSubjectDropdown(BuildContext context, AppLocalizations l10n) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeDropdown,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          CompositedTransformFollower(
            link: _subjectLayerLink,
            showWhenUnlinked: false,
            offset: Offset(0, 56.h + 8.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width - 40.w,
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).barBackgroundColor,
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    border: Border.all(
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color!.withValues(alpha: .2),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: ContactSubject.values.map((subject) {
                      final isSelected = _selectedSubject == subject;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSubject = subject;
                          });
                          _closeDropdown();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _getSubjectText(subject, l10n),
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(
                                      fontSize: 16.sp,
                                      color: isSelected
                                          ? CupertinoColors.activeBlue
                                          : CupertinoTheme.of(
                                              context,
                                            ).textTheme.textStyle.color,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                              ),
                              if (isSelected)
                                Icon(
                                  CupertinoIcons.checkmark_alt,
                                  color: CupertinoColors.activeBlue,
                                  size: 18.sp,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isSubjectDropdownOpen = true;
    });
  }

  void _showSalutationDropdown(BuildContext context, AppLocalizations l10n) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeDropdown,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          CompositedTransformFollower(
            link: _salutationLayerLink,
            showWhenUnlinked: false,
            offset: Offset(0, 56.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width - 40.w,
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).barBackgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    border: Border.all(
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color!.withValues(alpha: .2),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: ContactSalutation.values.map((salutation) {
                      final isSelected = _selectedSalutation == salutation;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSalutation = salutation;
                          });
                          _closeDropdown();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _getSalutationText(salutation, l10n),
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(
                                      fontSize: 16.sp,
                                      color: isSelected
                                          ? CupertinoColors.activeBlue
                                          : CupertinoTheme.of(
                                              context,
                                            ).textTheme.textStyle.color,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                              ),
                              if (isSelected)
                                Icon(
                                  CupertinoIcons.checkmark_alt,
                                  color: CupertinoColors.activeBlue,
                                  size: 18.sp,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isSalutationDropdownOpen = true;
    });
  }

  Future<void> _submitContactForm(AppLocalizations l10n) async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final content = _contentController.text.trim();

    FocusScope.of(context).unfocus();

    if (name.isEmpty) {
      AdaptiveAlertDialog.show(
        context: context,
        title: l10n.error,
        message: l10n.invalid_name,
        actions: [
          AlertAction(
            title: l10n.close,
            style: AlertActionStyle.primary,
            onPressed: () {},
          ),
        ],
      );
      return;
    }

    if (email.isEmpty || !email.contains('@')) {
      AdaptiveAlertDialog.show(
        context: context,
        title: l10n.error,
        message: l10n.invalid_email,
        actions: [
          AlertAction(
            title: l10n.close,
            style: AlertActionStyle.primary,
            onPressed: () {},
          ),
        ],
      );
      return;
    }

    if (content.isEmpty) {
      AdaptiveAlertDialog.show(
        context: context,
        title: l10n.error,
        message: l10n.please_enter_content,
        actions: [
          AlertAction(
            title: l10n.close,
            style: AlertActionStyle.primary,
            onPressed: () {},
          ),
        ],
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final baseUrl = dotenv.env['CONTACT_URL_API'] ?? '';
      final url = Uri.parse(baseUrl);

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'salutation': _getSalutationText(_selectedSalutation, l10n),
          'name': name,
          'email': email,
          'subject': _getSubjectText(_selectedSubject, l10n),
          'content': content,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (!mounted) return;

        _contentController.clear();
        if (!_isLoggedIn) {
          _emailController.clear();
          _nameController.clear();
        } else if (!_hasInitialName) {
          _nameController.clear();
        }

        AdaptiveAlertDialog.show(
          context: context,
          title: l10n.success,
          message: l10n.send_contact_success,
          actions: [
            AlertAction(
              title: l10n.close,
              style: AlertActionStyle.primary,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      } else {
        throw Exception('Server returned ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error submitting contact form: $e');
      if (!mounted) return;
      AdaptiveAlertDialog.show(
        context: context,
        title: l10n.error,
        message: l10n.send_contact_error,
        actions: [
          AlertAction(
            title: l10n.close,
            style: AlertActionStyle.primary,
            onPressed: () {},
          ),
        ],
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _closeDropdown();
    _nameController.dispose();
    _emailController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            if (_isSubjectDropdownOpen || _isSalutationDropdownOpen) {
              _closeDropdown();
            }
          },
          child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: CupertinoTheme.of(
                context,
              ).scaffoldBackgroundColor,
              border: null,
              leading: CupertinoNavigationBarBackButton(
                color: CupertinoTheme.of(context).primaryColor,
                onPressed: () => Navigator.pop(context),
              ),
              middle: Text(
                l10n.contact_support,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  children: [
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollUpdateNotification) {
                            if (_isSubjectDropdownOpen ||
                                _isSalutationDropdownOpen) {
                              _closeDropdown();
                            }
                          }
                          return false;
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.contact_info,
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                decoration: BoxDecoration(
                                  color: CupertinoTheme.of(
                                    context,
                                  ).barBackgroundColor,
                                  borderRadius: BorderRadius.circular(30.r),
                                  border: Border.all(
                                    color: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .color!
                                        .withValues(alpha: .2),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    CompositedTransformTarget(
                                      link: _salutationLayerLink,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (_isSalutationDropdownOpen) {
                                            _closeDropdown();
                                          } else {
                                            _closeDropdown();
                                            _showSalutationDropdown(
                                              context,
                                              l10n,
                                            );
                                          }
                                        },
                                        child: Container(
                                          height: 56.h,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                          ),
                                          color: Colors.transparent,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                l10n.salutation,
                                                style:
                                                    CupertinoTheme.of(context)
                                                        .textTheme
                                                        .textStyle
                                                        .copyWith(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    _getSalutationText(
                                                      _selectedSalutation,
                                                      l10n,
                                                    ),
                                                    style:
                                                        CupertinoTheme.of(
                                                              context,
                                                            )
                                                            .textTheme
                                                            .textStyle
                                                            .copyWith(
                                                              fontSize: 16.sp,
                                                            ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Icon(
                                                    _isSalutationDropdownOpen
                                                        ? CupertinoIcons
                                                              .chevron_up
                                                        : CupertinoIcons
                                                              .chevron_down,
                                                    size: 18.sp,
                                                    color: CupertinoTheme.of(
                                                      context,
                                                    ).textTheme.textStyle.color,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: CupertinoTheme.of(context)
                                          .textTheme
                                          .textStyle
                                          .color!
                                          .withValues(alpha: .1),
                                    ),
                                    Container(
                                      height: 56.h,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      color: (_isLoggedIn && _hasInitialName)
                                          ? CupertinoTheme.of(context)
                                                .scaffoldBackgroundColor
                                                .withValues(alpha: 0.5)
                                          : Colors.transparent,
                                      child: CupertinoTextField(
                                        controller: _nameController,
                                        placeholder: l10n.name_placeholder,
                                        readOnly:
                                            _isLoggedIn && _hasInitialName,
                                        decoration: null,
                                        style: CupertinoTheme.of(context)
                                            .textTheme
                                            .textStyle
                                            .copyWith(
                                              fontSize: 16.sp,
                                              color:
                                                  (_isLoggedIn &&
                                                      _hasInitialName)
                                                  ? CupertinoColors.systemGrey
                                                  : null,
                                            ),
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: CupertinoTheme.of(context)
                                          .textTheme
                                          .textStyle
                                          .color!
                                          .withValues(alpha: .1),
                                    ),
                                    Container(
                                      height: 56.h,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _isLoggedIn
                                            ? CupertinoTheme.of(context)
                                                  .scaffoldBackgroundColor
                                                  .withValues(alpha: 0.5)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30.r),
                                          bottomRight: Radius.circular(30.r),
                                        ),
                                      ),
                                      child: CupertinoTextField(
                                        controller: _emailController,
                                        placeholder: l10n.email_placeholder,
                                        readOnly: _isLoggedIn,
                                        decoration: null,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: CupertinoTheme.of(context)
                                            .textTheme
                                            .textStyle
                                            .copyWith(
                                              fontSize: 16.sp,
                                              color: _isLoggedIn
                                                  ? CupertinoColors.systemGrey
                                                  : null,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                l10n.subject,
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              SizedBox(height: 10.h),
                              CompositedTransformTarget(
                                link: _subjectLayerLink,
                                child: GestureDetector(
                                  onTap: () {
                                    if (_isSubjectDropdownOpen) {
                                      _closeDropdown();
                                    } else {
                                      _closeDropdown();
                                      _showSubjectDropdown(context, l10n);
                                    }
                                  },
                                  child: Container(
                                    height: 56.h,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: CupertinoTheme.of(
                                        context,
                                      ).barBackgroundColor,
                                      borderRadius: BorderRadius.circular(30.r),
                                      border: Border.all(
                                        color: _isSubjectDropdownOpen
                                            ? CupertinoColors.activeBlue
                                            : CupertinoTheme.of(context)
                                                  .textTheme
                                                  .textStyle
                                                  .color!
                                                  .withValues(alpha: .2),
                                        width: _isSubjectDropdownOpen ? 1.5 : 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _getSubjectText(
                                            _selectedSubject,
                                            l10n,
                                          ),
                                          style: CupertinoTheme.of(context)
                                              .textTheme
                                              .textStyle
                                              .copyWith(fontSize: 16.sp),
                                        ),
                                        Icon(
                                          _isSubjectDropdownOpen
                                              ? CupertinoIcons.chevron_up
                                              : CupertinoIcons.chevron_down,
                                          size: 18.sp,
                                          color: _isSubjectDropdownOpen
                                              ? CupertinoColors.activeBlue
                                              : CupertinoTheme.of(
                                                  context,
                                                ).textTheme.textStyle.color,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                l10n.content,
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: CupertinoTheme.of(
                                        context,
                                      ).textTheme.textStyle.color,
                                    ),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                height: 280.h,
                                decoration: BoxDecoration(
                                  color: CupertinoTheme.of(
                                    context,
                                  ).barBackgroundColor,
                                  borderRadius: BorderRadius.circular(30.r),
                                  border: Border.all(
                                    color: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .color!
                                        .withValues(alpha: .2),
                                  ),
                                ),
                                child: CupertinoTextField(
                                  controller: _contentController,
                                  maxLines: null,
                                  expands: true,
                                  placeholder: l10n.describe_issue,
                                  padding: EdgeInsets.all(16.w),
                                  textAlignVertical: TextAlignVertical.top,
                                  decoration: null,
                                  style: CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle
                                      .copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                l10n.feedback_description,
                                textAlign: TextAlign.justify,
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: CupertinoTheme.of(context)
                                          .textTheme
                                          .textStyle
                                          .color!
                                          .withValues(alpha: .7),
                                    ),
                              ),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton(
                        color: CupertinoColors.activeBlue,
                        borderRadius: BorderRadius.circular(14.r),
                        onPressed: () => _submitContactForm(l10n),
                        child: Text(
                          _getSubmitText(_selectedSubject, l10n),
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 16.sp,
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
          ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: CupertinoColors.black.withValues(alpha: 0.4),
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: CupertinoTheme.of(context).primaryColor,
                  size: 30.w,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
