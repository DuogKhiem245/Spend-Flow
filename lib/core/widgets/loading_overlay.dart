import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: CupertinoTheme.of(context)
                .scaffoldBackgroundColor
                .withValues(alpha: .4), 
            child: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: CupertinoTheme.of(context).primaryColor,
                size: 30.w,
              )
            ),
          ),
      ],
    );
  }
}
