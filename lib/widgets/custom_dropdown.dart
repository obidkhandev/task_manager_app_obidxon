import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({
    super.key,
    required this.items,
    required this.onChanged,
    this.hintText = 'select',
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.hintStyle,
    this.width,
    this.iconColor,
    this.initValue,
    this.validator,
    this.label,
    this.leadingIcon,
    this.visibleClose = true,
    this.height,
  });

  final List<String> items;
  final String hintText;
  final String? initValue;
  final List<Widget>? leadingIcon;
  final TextStyle? hintStyle, textStyle;
  final Color? backgroundColor, borderColor, iconColor;
  final double? width;
  final ValueChanged<String?> onChanged;
  final String? label;
  final String? validator;
  final bool visibleClose;
  final double? height;

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.label;
    final bg = widget.backgroundColor ?? AppColors.white;
    final border = widget.borderColor ?? const Color(0xFF808080);
    final iconColor = widget.iconColor ?? const Color(0xFF808080);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: (widget.textStyle ?? Theme.of(context).textTheme.bodyMedium)?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                if (widget.validator != null)
                  TextSpan(
                    text: ' *',
                    style: (widget.textStyle ?? Theme.of(context).textTheme.bodySmall)?.copyWith(
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
        ],
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            buttonStyleData: ButtonStyleData(
              height: widget.height ?? 40,
              decoration: BoxDecoration(
                color: bg,
                border: Border.all(color: border),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(8),
              ),
              width: widget.width ?? MediaQuery.of(context).size.width - 32,
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            iconStyleData: IconStyleData(
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (selectedValue != null && widget.visibleClose)
                    GestureDetector(
                      onTap: () {
                        selectedValue = null;
                        setState(() {});
                        widget.onChanged(selectedValue);
                      },
                      child: Icon(Icons.close, size: 16, color: iconColor),
                    ),
                  if (widget.items.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Icon(Icons.keyboard_arrow_down, size: 18, color: iconColor),
                  ],
                ],
              ),
            ),
            value: selectedValue,
            hint: Text(
              widget.hintText,
              style: widget.hintStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFB9BDC7),
                      ),
            ),
            style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
            items: widget.items
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Row(
                        children: [
                          if (widget.leadingIcon != null) ...widget.leadingIcon!,
                          if (widget.leadingIcon != null) const SizedBox(width: 10),
                          Text(item, style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ))
                .toList(),
            onChanged: (String? newValue) {
              setState(() => selectedValue = newValue);
              widget.onChanged(newValue);
            },
          ),
        ),
      ],
    );
  }
}
