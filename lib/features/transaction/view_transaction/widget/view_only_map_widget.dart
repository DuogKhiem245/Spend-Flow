import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class ViewOnlyMapWidget extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String address;

  const ViewOnlyMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  @override
  State<ViewOnlyMapWidget> createState() => _ViewOnlyMapWidgetState();
}

class _ViewOnlyMapWidgetState extends State<ViewOnlyMapWidget> {

  static const String _darkStyle =
      "mapbox://styles/khiemduong2405/cmkcmk34300dl01sc6bfuajnx";
  static const String _lightStyle =
      "mapbox://styles/khiemduong2405/cmkcm6ara002l01sb7yqa9f90";

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final position = Position(widget.longitude, widget.latitude);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 0.w,
          ), 
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).barBackgroundColor,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: Column(
              children: [
                SizedBox(
                  height: 220.h, 
                  child: Stack(
                    children: [
                      MapWidget(
                        key: ValueKey(
                          "ViewMap_${widget.longitude}_${widget.latitude}",
                        ),
                        cameraOptions: CameraOptions(
                          center: Point(coordinates: position),
                          zoom: 15.0,
                        ),
                        styleUri: isDark ? _darkStyle : _lightStyle,
                      ),

                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: 30.h,
                          ), 
                          child: Icon(
                            CupertinoIcons.location_solid,
                            size: 36.sp,
                            color: CupertinoTheme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 4.h),
                          width: 6.w,
                          height: 3.h,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(10.w),
                  width: double.infinity,
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: CupertinoTheme.of(
                            context,
                          ).primaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          CupertinoIcons.placemark_fill,
                          color: CupertinoTheme.of(context).primaryColor,
                          size: 25.w,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          widget.address,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
