import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/model/location_model.dart';
import 'package:spend_flow/core/services/general_service/language_service.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';

class SearchLocationModal extends StatefulWidget {
  final Function(double lat, double lng, String name) onLocationSelected;

  const SearchLocationModal({super.key, required this.onLocationSelected});

  @override
  State<SearchLocationModal> createState() => _SearchLocationModalState();
}

class _SearchLocationModalState extends State<SearchLocationModal> {
  List<Map<String, dynamic>> _recentLocations = [];
  List<dynamic> _searchResults = [];
  bool _isSearching = false;
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();

  final LocalStorageService _storageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    _loadRecentLocations();
  }

  Future<void> _loadRecentLocations() async {
    final recents = await _storageService.getRecentLocations();

    setState(() {
      _recentLocations = recents
          .map(
            (e) => {
              'name': e.name,
              'address': e.address,
              'lat': e.lat,
              'lng': e.lng,
            },
          )
          .toList();
    });
  }

  Future<void> _saveToRecent(
    String name,
    String address,
    double lat,
    double lng,
  ) async {
    final newLocation = RecentLocationModel(
      name: name,
      address: address,
      lat: lat,
      lng: lng,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    await _storageService.saveRecentLocation(newLocation);
  }

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    final langCode = LanguageService().currentLanguageCode;

    final token = dotenv.env['MAPBOX_PUBLIC_TOKEN'] ?? '';
    final url = Uri.parse(
      "https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=$token&limit=5&language=$langCode",
    );

    setState(() => _isSearching = true);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() => _searchResults = data['features']);
      }
    } catch (e) {
      debugPrint("Lỗi tìm kiếm: $e");
    } finally {
      setState(() => _isSearching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 0.9.sh,
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),

      child: Column(
        children: [
          Container(
            color: CupertinoTheme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.only(bottom: 10.h),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: CupertinoNavigationBar(
                    backgroundColor: Colors.transparent,
                    border: null,
                    padding: EdgeInsetsDirectional.only(end: 10.w),
                    leading: CupertinoNavigationBarBackButton(
                      color: CupertinoTheme.of(context).primaryColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                    middle: Text(
                      l10n.select_location,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).barBackgroundColor,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.search,
                        size: 20.sp,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color?.withValues(alpha: .7),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CupertinoTextField(
                          decoration: BoxDecoration(color: Colors.transparent),
                          controller: _searchController,
                          placeholder: l10n.search_location,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color,
                          ),
                          onChanged: (value) {
                            if (_debounce?.isActive ?? false) {
                              _debounce!.cancel();
                            }
                            _debounce = Timer(
                              const Duration(milliseconds: 500),
                              () {
                                _searchLocation(value);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_searchController.text.isNotEmpty) ...[
                    if (_isSearching)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: CupertinoTheme.of(context).primaryColor,
                            size: 30,
                          ),
                        ),
                      )
                    else if (_searchResults.isNotEmpty)
                      _buildSection(
                        context,
                        title: l10n.search_results,
                        children: _searchResults.map((feature) {
                          final center = feature['center'];
                          return _buildLocationItem(
                            context,
                            icon: CupertinoIcons.location_solid,
                            title: feature['text'] ?? '',
                            subtitle: feature['place_name'] ?? '',
                            isLast: feature == _searchResults.last,
                            onTap: () {
                              final lng = (center[0] as num).toDouble();
                              final lat = (center[1] as num).toDouble();
                              final name = feature['text'] ?? '';
                              final address = feature['place_name'] ?? '';

                              _saveToRecent(name, address, lat, lng);
                              widget.onLocationSelected(lng, lat, name);
                              Navigator.pop(context);
                            },
                          );
                        }).toList(),
                      ),
                  ] else if (_recentLocations.isNotEmpty) ...[
                    _buildSection(
                      context,
                      title: l10n.recent_locations,
                      children: _recentLocations.map((loc) {
                        return _buildLocationItem(
                          context,
                          icon: CupertinoIcons.time,
                          title: loc['name'],
                          subtitle: loc['address'],
                          isLast: loc == _recentLocations.last,
                          onTap: () {
                            widget.onLocationSelected(
                              loc['lng'],
                              loc['lat'],
                              loc['name'],
                            );
                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.w, bottom: 8.h, top: 10.h),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).barBackgroundColor,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildLocationItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isLast,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(
                      context,
                    ).primaryColor.withValues(alpha: .15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 20.sp,
                    color: CupertinoTheme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color?.withValues(alpha: .7),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isLast)
            Container(
              height: 0.5,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .2),
            ),
        ],
      ),
    );
  }
}
