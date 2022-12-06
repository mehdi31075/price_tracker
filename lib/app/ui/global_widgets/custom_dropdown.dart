import 'package:flutter/material.dart';
import 'package:price_tracker/app/ui/theme/app_colors.dart';
import 'package:price_tracker/app/ui/theme/app_sizes.dart';

class CustomDropDown<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final String? errorText;
  final List<DropdownMenuItem<T>> items;
  final Function? onChanged;
  final String? Function(T?)? validator;
  final Color? backgroundColor;

  const CustomDropDown({
    Key? key,
    this.value,
    required this.hint,
    required this.items,
    this.onChanged,
    this.errorText,
    this.validator,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular( AppSizes.defaultRadius),
            color: backgroundColor,
            border: Border.all(
              width: 1,
              color: AppColors.txtHeaderColor,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
            ),
            child: DropdownButtonFormField<T>(
              value: value,
              validator: validator,
              hint: Text(
                hint,
                style: TextStyle(
                  color: AppColors.txtBodyColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              items: items,
              onChanged: onChanged != null
                  ? (T? value) {
                      onChanged!(value);
                    }
                  : null,
              isExpanded: true,
              icon: Icon(
                Icons.chevron_right,
                color: AppColors.txtBodyColor,
                size: 24,
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: Text(
              errorText!,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.dangerColor,
              ),
            ),
          )
      ],
    );
  }
}
