import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';

class DateHelper extends StatefulWidget {
  final AppLocalizations l10n;
  final Color? baseColor;
  final ValueChanged<DateTime> onDateChanged; 

  const DateHelper({
    super.key,
    required this.l10n,
    this.baseColor,
    required this.onDateChanged,
  });

  @override
  State<DateHelper> createState() => _DateHelperState();
}

class _DateHelperState extends State<DateHelper> {
  DateTime _selectedDate = DateTime.now();

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  String _getDateText() {
    if (_isToday(_selectedDate)) {
      return widget.l10n.today;
    }
    return "${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}";
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300.h,
        color: CupertinoTheme.of(context).barBackgroundColor,
        child: Column(
          children: [
            Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Text(
                  "Done",
                  style: TextStyle(
                    color: CupertinoTheme.of(context).primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 250.h,
              child: CupertinoDatePicker(
                initialDateTime: _selectedDate,
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                maximumDate: DateTime.now(),
                onDateTimeChanged: (val) {
                  setState(() {
                    _selectedDate = val;
                  });
                  widget.onDateChanged(val);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              margin: EdgeInsets.only(left: 16.w, right: 12.w),
              decoration: BoxDecoration(
                color: CupertinoTheme.of(
                  context,
                ).primaryColor.withValues(alpha: .15),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Icon(
                CupertinoIcons.calendar,
                size: 25.w,
                color: CupertinoTheme.of(context).primaryColor,
              ),
            ),
            Text(
              widget.l10n.date,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: widget.baseColor,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(right: 16.w),
          child: GestureDetector(
            onTap: _showDatePicker,
            child: Row(
              children: [
                Text(
                  _getDateText(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: widget.baseColor,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  CupertinoIcons.chevron_right,
                  size: 20.w,
                  color: widget.baseColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
