import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomBottomSheet({
  required BuildContext context,
  required Widget child,

}) {

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp)),
    ),
    builder: (ctx) {
      return _BottomSheetWrapper(child: child);
    },
  );
}

class _BottomSheetWrapper extends StatelessWidget {
  const _BottomSheetWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius:  BorderRadius.vertical(top: Radius.circular(20.sp)),
  
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DragHandle(),
           SizedBox(height: 12.h),
            child,
          ],
        ),
      ),
    );
  }
}

class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 5.h,
        width: 64.w,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(10.sp),
          ),
        ),
      ),
    );
  }
}
