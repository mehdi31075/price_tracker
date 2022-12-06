import 'package:flutter/material.dart';
import 'package:price_tracker/app/ui/theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  final double? height;

  const LoadingWidget({
    Key? key,
    this.color,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: height,
        child: CircularProgressIndicator(
          color: color ?? AppColors.primaryColor,
        ),
      ),
    );
  }
}
