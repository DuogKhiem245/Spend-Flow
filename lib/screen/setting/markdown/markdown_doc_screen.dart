import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarkdownDocScreen extends StatelessWidget {
  final String title;
  final String filename;

  const MarkdownDocScreen({
    super.key,
    required this.title,
    required this.filename,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: null,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoTheme.of(context).primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          title,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
      ),
      child: FutureBuilder<String>(
        future: rootBundle.loadString('lib/assets/docs/$filename'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Lỗi tải tài liệu: ${snapshot.error}',
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(color: CupertinoColors.systemRed),
              ),
            );
          }

          final mdContent = snapshot.data ?? 'Không có nội dung.';

          return Markdown(
            data: mdContent,
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
            styleSheet: MarkdownStyleSheet(
              h1: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
              h2: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 20.sp,
                color: CupertinoTheme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
              p: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 16.sp,
                height: 1.5.h,
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
            ),
            onTapLink: (text, href, title) {
              if (href != null) {
                debugPrint('User tapped link: $href');
              }
            },
          );
        },
      ),
    );
  }
}
