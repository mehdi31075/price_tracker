import 'package:flutter/material.dart';

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
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                style: const TextStyle(
                  color: Colors.grey,
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
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.grey,
                size: 8,
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: Text(
              errorText!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          )
      ],
    );
  }
}
