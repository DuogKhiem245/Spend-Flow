import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/general_service/language_service.dart';
import 'package:spend_flow/screen/transaction/add_transaction/add_transaction_viewmodel.dart';
import 'package:spend_flow/screen/transaction/add_transaction/widgets/modal/search_location_modal.dart';

class MyMapWidget extends StatefulWidget {
  final AddTransactionViewmodel viewModel;

  const MyMapWidget({super.key, required this.viewModel});

  @override
  State<MyMapWidget> createState() => _MyMapWidgetState();
}

class _MyMapWidgetState extends State<MyMapWidget> {
  MapboxMap? _mapboxMap;

  Brightness? _currentBrightness;

  static const String _darkStyle =
      "mapbox://styles/khiemduong2405/cmkcmk34300dl01sc6bfuajnx";
  static const String _lightStyle =
      "mapbox://styles/khiemduong2405/cmkcm6ara002l01sb7yqa9f90";

  void _onMapCreated(MapboxMap mapboxMap) {
    _mapboxMap = mapboxMap;
  }

  Timer? _cameraDebounce;
  bool _isMapMoving = false;

  Future<void> _reverseGeocode(double lat, double lng) async {
    final token = dotenv.env['MAPBOX_PUBLIC_TOKEN'] ?? '';

    final langCode = LanguageService().currentLanguageCode;

    final url = Uri.parse(
      "https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?access_token=$token&limit=1&language=$langCode",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final features = data['features'] as List;

        if (features.isNotEmpty) {
          final address = features[0]['place_name'] ?? '';
          widget.viewModel.updateLocation(Position(lng, lat), address);
        }
      }
    } catch (e) {
      debugPrint("Lỗi Reverse Geocoding: $e");
    }
  }

  void _onCameraChangeListener(CameraChangedEventData event) {
    if (_cameraDebounce?.isActive ?? false) _cameraDebounce!.cancel();

    if (!_isMapMoving) {
      setState(() => _isMapMoving = true);
    }

    _cameraDebounce = Timer(const Duration(milliseconds: 800), () async {
      setState(() => _isMapMoving = false);

      if (_mapboxMap != null) {
        final cameraState = await _mapboxMap!.getCameraState();
        final center = cameraState.center;

        _reverseGeocode(
          center.coordinates.lat.toDouble(),
          center.coordinates.lng.toDouble(),
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newBrightness = CupertinoTheme.of(context).brightness;

    if (_currentBrightness != newBrightness) {
      _currentBrightness = newBrightness;

      _updateMapStyle();
    }
  }

  void _updateMapStyle() {
    if (_mapboxMap == null) return;

    final isDark = _currentBrightness == Brightness.dark;
    final styleUri = isDark ? _darkStyle : _lightStyle;

    _mapboxMap?.loadStyleURI(styleUri);
  }

  void _flyToLocation(double lng, double lat, String name) {
    _mapboxMap?.flyTo(
      CameraOptions(
        center: Point(coordinates: Position(lng, lat)),
        zoom: 15.0,
        padding: MbxEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
      ),
      MapAnimationOptions(),
    );

    widget.viewModel.updateLocation(Position(lng, lat), name);
  }

  void _showSearchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      builder: (context) => ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        child: SearchLocationModal(
          onLocationSelected: (lng, lat, name) {
            _flyToLocation(lng, lat, name);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = CupertinoTheme.of(context).brightness == Brightness.dark;

    return FutureBuilder(
      future: widget.viewModel.getCurrentLocation(),
      builder: (context, snapshot) {
        return ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            final currentPos = widget.viewModel.currentPosition;
            final displayAddress =
                widget.viewModel.selectedAddress ?? l10n.no_location_selected;
            final locationEnabled = widget.viewModel.isLocationEnabled;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Text(
                    l10n.location,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color?.withValues(alpha: .7),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(30.r),
                    border: (currentPos == null || locationEnabled == false)
                        ? Border.all(
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color!.withValues(alpha: 0.2),
                            width: 0.3.w,
                          )
                        : null,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 260.h,
                          child: locationEnabled == false
                              ? Center(
                                  child: Text(
                                    l10n.location_permission_denied,
                                    textAlign: TextAlign.center,
                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .copyWith(
                                          color: CupertinoTheme.of(
                                            context,
                                          ).textTheme.textStyle.color,
                                          fontSize: 14.sp,
                                        ),
                                  ),
                                )
                              : currentPos == null
                              ? Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                        color: CupertinoTheme.of(
                                          context,
                                        ).primaryColor,
                                        size: 30.sp,
                                      ),
                                )
                              : Stack(
                                  children: [
                                    MapWidget(
                                      key: const ValueKey("MainMapBox"),
                                      gestureRecognizers:
                                          <
                                            Factory<
                                              OneSequenceGestureRecognizer
                                            >
                                          >{
                                            Factory<
                                              OneSequenceGestureRecognizer
                                            >(() => EagerGestureRecognizer()),
                                          },
                                      cameraOptions: CameraOptions(
                                        center: Point(coordinates: currentPos),
                                        zoom: 15.0,
                                      ),
                                      styleUri: isDarkMode
                                          ? _darkStyle
                                          : _lightStyle,
                                      onMapCreated: _onMapCreated,
                                      onCameraChangeListener:
                                          _onCameraChangeListener,
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 30.h),
                                        child: Icon(
                                          CupertinoIcons.location_solid,
                                          size: 36.sp,
                                          color: CupertinoTheme.of(
                                            context,
                                          ).primaryColor,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 4.h),
                                        width: 6.w,
                                        height: 3.h,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(
                                            alpha: 0.2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                      ),
                                    ),

                                    locationEnabled == true
                                        ? Positioned(
                                            bottom: 5.h,
                                            right: 10.w,
                                            child: GestureDetector(
                                              onTap: () async {
                                                await widget.viewModel
                                                    .getCurrentLocation();

                                                final pos = widget
                                                    .viewModel
                                                    .currentPosition;

                                                if (pos != null &&
                                                    _mapboxMap != null) {
                                                  _mapboxMap?.flyTo(
                                                    CameraOptions(
                                                      center: Point(
                                                        coordinates: pos,
                                                      ),
                                                      zoom: 15.0,
                                                      padding: MbxEdgeInsets(
                                                        top: 0,
                                                        left: 0,
                                                        bottom: 0,
                                                        right: 0,
                                                      ),
                                                    ),
                                                    MapAnimationOptions(),
                                                  );

                                                  widget.viewModel
                                                      .updateLocation(
                                                        pos,
                                                        l10n.current_location,
                                                      );
                                                }
                                              },
                                              child: Container(
                                                width: 40.w,
                                                height: 40.w,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: CupertinoTheme.of(
                                                    context,
                                                  ).scaffoldBackgroundColor,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withValues(
                                                            alpha: 0.15,
                                                          ),
                                                      blurRadius: 8,
                                                      offset: const Offset(
                                                        0,
                                                        4,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: Icon(
                                                  CupertinoIcons.scope,
                                                  color: CupertinoTheme.of(
                                                    context,
                                                  ).primaryColor,
                                                  size: 22.sp,
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                        ),

                        GestureDetector(
                          onTap: () => _showSearchModal(context),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            color: CupertinoTheme.of(
                              context,
                            ).barBackgroundColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
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
                                    color: CupertinoTheme.of(
                                      context,
                                    ).primaryColor,
                                    size: 25.w,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        displayAddress,
                                        style: CupertinoTheme.of(context)
                                            .textTheme
                                            .textStyle
                                            .copyWith(
                                              color: CupertinoTheme.of(
                                                context,
                                              ).textTheme.textStyle.color,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      SizedBox(height: 4.h),
                                      Text(
                                        l10n.tap_to_change_location,
                                        style: CupertinoTheme.of(context)
                                            .textTheme
                                            .textStyle
                                            .copyWith(
                                              color: CupertinoTheme.of(context)
                                                  .textTheme
                                                  .textStyle
                                                  .color!
                                                  .withValues(alpha: 0.5),
                                              fontSize: 12.sp,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  CupertinoIcons.chevron_right,
                                  size: 16.sp,
                                  color: CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle
                                      .color!
                                      .withValues(alpha: 0.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
