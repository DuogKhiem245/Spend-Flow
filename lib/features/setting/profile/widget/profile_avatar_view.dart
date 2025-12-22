import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/config/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  final File? imageFile; 
  final String? photoUrl;
  final VoidCallback onEditTap;

  const ProfileAvatar({
    super.key,
    this.imageFile,
    required this.photoUrl,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 140.w,
          height: 140.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.borderColor,
            gradient: (imageFile == null && photoUrl == null)
                ? const LinearGradient(
                    colors: [Color(0xFFD4BBA3), Color(0xFFF0E4D7)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  )
                : null,
          ),
          child: ClipOval(
            child: _buildImage(), 
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onEditTap,
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
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (imageFile != null) {
      return Image.file(imageFile!, fit: BoxFit.cover);
    }

    if (photoUrl != null) {
      return Image.network(
        photoUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _defaultIcon(),
        loadingBuilder: (_, child, p) => p == null
            ? child
            : const Center(child: CupertinoActivityIndicator()),
      );
    }

    return _defaultIcon();
  }

  Widget _defaultIcon() {
    return Icon(
      CupertinoIcons.person_fill,
      size: 80.w,
      color: CupertinoColors.white,
    );
  }
}
