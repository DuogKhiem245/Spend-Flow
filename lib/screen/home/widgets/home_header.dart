import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/screen/home/home_viewmodel.dart';
import 'package:spend_flow/screen/wallet/wallet_view.dart';

class HomeHeader extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeHeader({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = CupertinoTheme.of(context).brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        final greetingMessage = viewModel.getGreetingMessage(context);
        final User? user = viewModel.currentUser;
        final String? photoUrl = user?.photoURL;
        final String displayName =
            (user?.displayName != null && user!.displayName!.isNotEmpty)
            ? user.displayName!
            : '';

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 54.w,
                    height: 54.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.borderColor,
                    ),
                    child: ClipOval(
                      child: photoUrl != null
                          ? Image.network(
                              photoUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Image.asset(
                                'lib/assets/images/avatar.png',
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              'lib/assets/images/avatar.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greetingMessage,
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (displayName.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(
                          displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 16.sp,
                                color: CupertinoColors.systemGrey,
                              ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),

            PullDownButton(
              itemBuilder: (context) {
                List<PullDownMenuEntry> items = [];
                for (var wallet in viewModel.wallets) {
                  final isSelected = wallet.id == viewModel.currentWalletId;
                  items.add(
                    PullDownMenuItem(
                      title: wallet.name,
                      onTap: () => viewModel.switchWallet(wallet.id),
                      icon: isSelected
                          ? CupertinoIcons.checkmark_circle_fill
                          : CupertinoIcons.creditcard,
                      iconColor: isSelected ? AppColors.primaryColor : null,
                      itemTheme: PullDownMenuItemTheme(
                        textStyle: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle
                            .copyWith(
                              fontSize: 16.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: CupertinoTheme.of(
                                context,
                              ).textTheme.textStyle.color,
                            ),
                      ),
                    ),
                  );
                }
                if (items.isNotEmpty) {
                  items.add(const PullDownMenuDivider.large());
                }
                items.add(
                  PullDownMenuItem(
                    title: l10n.add_wallet,
                    icon: CupertinoIcons.add_circled,
                    itemTheme: PullDownMenuItemTheme(
                      textStyle: CupertinoTheme.of(context)
                          .textTheme
                          .textStyle
                          .copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color,
                          ),
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              const WalletView(firstWallet: false),
                        ),
                      );
                      await viewModel.refreshWallets();
                    },
                  ),
                );
                items.add(
                  PullDownMenuItem(
                    title: l10n.delete_wallet,
                    icon: CupertinoIcons.trash,
                    isDestructive: true,
                    onTap: () => _showManageWalletDialog(context, isDarkMode),
                    itemTheme: PullDownMenuItemTheme(
                      textStyle: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color,
                          ),
                    ),
                  ),
                );
                return items;
              },

              buttonBuilder: (context, showMenu) => CupertinoButton(
                onPressed: showMenu,
                padding: EdgeInsets.zero,
                child: Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? CupertinoColors.systemGrey6.resolveFrom(context)
                          : AppColors.primaryColor.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.white.withValues(alpha: .1)
                            : AppColors.primaryColor.withValues(alpha: .2),
                        width: 1,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.creditcard_fill,
                            size: 18.sp,
                            color: isDarkMode
                                ? CupertinoColors.white
                                : AppColors.primaryColor,
                          ),
                          SizedBox(width: 8.w),
                          Flexible(
                            child: Text(
                              viewModel.currentWalletName(l10n),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: CupertinoTheme.of(
                                      context,
                                    ).textTheme.textStyle.color,
                                  ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Icon(
                            CupertinoIcons.chevron_down,
                            size: 14.sp,
                            color: isDarkMode
                                ? CupertinoColors.systemGrey2
                                : AppColors.primaryColor.withValues(alpha: .6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showManageWalletDialog(BuildContext context, bool isDarkMode) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (ctx) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(ctx).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(ctx).barBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 12.h),
                width: 40.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey4.resolveFrom(ctx),
                  borderRadius: BorderRadius.circular(2.5.r),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Text(
                  l10n.delete_wallet,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.label.resolveFrom(ctx),
                      ),
                ),
              ),

              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: viewModel.wallets.length,
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final wallet = viewModel.wallets[index];
                      final isCurrent = wallet.id == viewModel.currentWalletId;

                      return Container(
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? AppColors.primaryColor.withValues(
                                  alpha: isDarkMode ? 0.15 : 0.08,
                                )
                              : CupertinoColors.secondarySystemBackground
                                    .resolveFrom(ctx),
                          borderRadius: BorderRadius.circular(16.r),
                          border: isCurrent
                              ? Border.all(
                                  color: AppColors.primaryColor.withValues(
                                    alpha: .3,
                                  ),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          leading: Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: isCurrent
                                  ? AppColors.primaryColor
                                  : CupertinoColors.systemGrey5.resolveFrom(
                                      ctx,
                                    ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              CupertinoIcons.creditcard_fill,
                              color: isCurrent
                                  ? Colors.white
                                  : CupertinoColors.systemGrey,
                              size: 20.sp,
                            ),
                          ),
                          title: Text(
                            wallet.name,
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                  color: CupertinoColors.label.resolveFrom(ctx),
                                ),
                          ),
                          subtitle: isCurrent
                              ? Padding(
                                  padding: EdgeInsets.only(top: 4.h),
                                  child: Text(
                                    l10n.in_use,
                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .copyWith(
                                          fontSize: 13.sp,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                )
                              : null,
                          trailing: IconButton(
                            icon: Icon(
                              CupertinoIcons.trash_circle_fill,
                              color: CupertinoColors.systemRed.withValues(
                                alpha: 0.8,
                              ),
                              size: 34.sp,
                            ),
                            onPressed: () =>
                                _confirmDelete(context, wallet.id, wallet.name),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    String walletId,
    String walletName,
  ) {
    final l10n = AppLocalizations.of(context)!;

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.delete_wallet,
      message: l10n.delete_wallet_confirmation(walletName),
      icon: 'creditcard.fill',
      actions: [
        AlertAction(
          title: l10n.cancel,
          style: AlertActionStyle.cancel, 
          onPressed: () => {},
        ),
        AlertAction(
          title: l10n.delete,
          style: AlertActionStyle.destructive, 
          onPressed: () async {
            final error = await viewModel.deleteWallet(walletId, context);
            if (context.mounted) {
              if (error != null) {
                _showErrorDialog(context, error);
              } else {
                Navigator.pop(
                  context,
                ); 
              }
            }
          },
        ),
      ],
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    final l10n = AppLocalizations.of(context)!;

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.error,
      message: message,
      icon: 'exclamationmark.triangle.fill', 
      actions: [
        AlertAction(
          title: "OK",
          style: AlertActionStyle.primary,
          onPressed: () {
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
