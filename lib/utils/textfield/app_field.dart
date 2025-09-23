import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/utils/others/app_color.dart';
import 'package:portfolio/utils/dropdown/app_dropdown.dart';

class AppField extends StatelessWidget {
  final TextEditingController? controller; // Make controller optional
  final String? label; // Constant label
  final String? hint; // Hint text
  final String? value; // Current value for the dropdown or text field
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor; // No longer optional
  final bool isFilled; // No longer optional
  final int? maxLines;
  final bool isReadOnly;
  final bool showBorder;
  final bool shouldClearData;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsets contentPadding;
  final EdgeInsets padding;
  final double dropDownSheetHeight;
  final double height;
  final TextStyle? labelStyle;
  final TextInputType textInputType; // No longer optional
  final bool isPrimary; // Flag to determine primary or secondary
  final VoidCallback? onTap; // Callback for onTap functionality
  final List<DropdownItem<dynamic>>? dropdownItems; // Items for the dropdown
  final ValueChanged<String?>?
      onChanged; // Callback for dropdown item selection
  final Function(dynamic, int)? onChangeDropDown;
  final ValueChanged<String?>? onSaved;
  final bool isDropdown; // Flag to determine if it's a dropdown
  final List<TextInputFormatter>?
      inputFormatters; // Optional text input formatters

  // A ValueNotifier to manage the focus state
  final ValueNotifier<bool> _isFocused = ValueNotifier<bool>(false);
  final DropdownStyle? dropdownStyle; // Customization for dropdown appearance
  final DropdownButtonStyle? dropdownButtonStyle; // Customization for button
  final Icon? icon; // Optional icon for dropdown button
  final bool? hideIcon; // Whether to hide the icon
  final bool? leadingIcon; // Whether the icon should be on the leading side
  final MainAxisSize?
      mainAxisSizeDropDown; // Whether the icon should be on the leading side

  // Primary constructor
  AppField.primary({
    Key? key,
    this.controller, // Make controller optional
    this.label,
    this.hint,
    this.value, // New parameter for current value
    this.suffixIcon,
    this.labelStyle,
    this.height = 55,
    this.prefixIcon,
    this.shouldClearData = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.onSaved,
    this.showBorder = false,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 4.5, vertical: 5),
    this.padding = const EdgeInsets.all(0),
    this.fillColor, // Default value
    this.isFilled = false, // Default value
    this.maxLines,
    this.isReadOnly = false, // Default value
    this.textInputType = TextInputType.text, // Default value
    this.onTap, // Include onTap in primary constructor
    this.dropdownItems, // Include dropdown items
    this.onChanged, // Include onChanged for dropdown
    this.isDropdown = false, // Flag to determine if it's a dropdown
    this.inputFormatters, // Optional input formatters
  })  : isPrimary = true, // Set isPrimary to true for primary constructor
        onChangeDropDown = null,
        icon = null,
        hideIcon = null,
        leadingIcon = null,
        dropdownStyle = null,
        dropDownSheetHeight = 0.0,
        dropdownButtonStyle = null,
        mainAxisSizeDropDown = null,
        super(key: key);

  // Secondary constructor
  AppField.borderless({
    Key? key,
    this.controller, // Make controller optional
    this.label,
    this.hint,
    this.value, // New parameter for current value
    this.suffixIcon,
    this.shouldClearData = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.height = 55,
    this.labelStyle,
    this.prefixIcon,
    this.fillColor,
    this.contentPadding = const EdgeInsets.all(2.5),
    this.padding = const EdgeInsets.all(0),
    this.isFilled = false, // Default value
    this.maxLines,
    this.onSaved,
    this.isReadOnly = false, // Default value
    this.showBorder = false,
    this.textInputType = TextInputType.text, // Default value

    this.onTap, // Include onTap in secondary constructor
    this.dropdownItems, // Include dropdown items
    this.onChanged, // Include onChanged for dropdown
    this.isDropdown = false, // Flag to determine if it's a dropdown
    this.inputFormatters, // Optional input formatters
  })  : isPrimary = false,
        onChangeDropDown = null,
        icon = null,
        hideIcon = null,
        leadingIcon = null,
        dropdownStyle = null,
        dropDownSheetHeight = 0.0,
        dropdownButtonStyle = null,
        mainAxisSizeDropDown = null,
        super(key: key);

  // Named constructor for dropdown
  AppField.dropdown({
    Key? key,
    this.label, // Label is required for dropdown
    required this.hint, // Hint is required for dropdown
    required this.dropdownItems, // Dropdown items are required
    required this.onChangeDropDown,
    this.value, // Current value for the dropdown
    this.suffixIcon,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.prefixIcon,
    this.fillColor,
    this.height = 55,
    this.shouldClearData = false,
    this.labelStyle,
    this.contentPadding = const EdgeInsets.only(top: 8),
    this.showBorder = false,
    this.padding = const EdgeInsets.all(0),
    this.icon,
    this.hideIcon,
    this.leadingIcon,
    this.dropdownStyle,
    this.mainAxisSizeDropDown,
    this.dropDownSheetHeight = 200,
    this.dropdownButtonStyle,
    this.isFilled = false, // Default value
    this.maxLines,
    this.isReadOnly = false, // Default value
    this.textInputType = TextInputType.text, // Default value
    this.onTap, // Callback for dropdown item selection
  })  : controller = null, // No controller for dropdown
        isPrimary = false, // Can be set to true if needed
        isDropdown = true,
        onSaved = null,
        onChanged = null,
        inputFormatters = null; // No input formatters for dropdown

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isFocused,
      builder: (context, isFocused, child) {
        return Container(
          margin: EdgeInsets.all(2).r,
          height: (label != null || label?.isEmpty == true)
              ? (height.h + 10)
              : height.h,
          decoration: BoxDecoration(
            color: fillColor ?? AppColors.primaryBg,
            border: Border.all(
              color: showBorder
                  ? (isFocused)
                      ? Colors.grey
                      : Colors.grey.shade900
                  : Colors.transparent, // Default border color
            ),
            borderRadius: BorderRadius.circular(16.0).r, // Border radius
          ),
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 0.0)
              .r, // Reduced padding
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align label to the center
            mainAxisAlignment: mainAxisAlignment,
            children: [
              if (label != null) // Display label if not null
                Text(
                  label!,
                  style: labelStyle ??
                      TextStyle(
                        fontSize: 12.0.sp, // Reduced font size for label
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                ),
              if (label != null) // Display label if not null
                SizedBox(
                  height: 5.h,
                ),
              if (isDropdown &&
                  dropdownItems != null &&
                  dropdownItems!.isNotEmpty)
                CustomDropdown(
                  items: dropdownItems,
                  onChange: onChangeDropDown!,
                  mainAxisSize: mainAxisSizeDropDown ?? MainAxisSize.max,
                  hint: hint,
                  suffixIcon: suffixIcon ??
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                  prefixIcon: prefixIcon,
                  hideIcon: hideIcon,
                  height: 20,
                  dropdownStyle: dropdownStyle ??
                      DropdownStyle(
                          color: const Color.fromARGB(255, 43, 33, 73),
                          borderRadius: BorderRadius.circular(12).r,
                          padding: EdgeInsets.all(20).r,
                          constraints: BoxConstraints(
                              maxHeight: dropDownSheetHeight,
                              minWidth: double.infinity)),
                  dropdownButtonStyle: dropdownButtonStyle ??
                      DropdownButtonStyle(
                          backgroundColor: Colors.amber,
                          height: 40.h,
                          primaryColor: Colors.amber),
                ),
              if (!isDropdown) // Show text field if it's not a dropdown
                TextFormField(
                  controller: controller, // Use the provided controller
                  keyboardType: textInputType,
                  maxLines: maxLines ?? 1,
                  initialValue: value,
                  onFieldSubmitted: (value) {
                    if (onSaved != null) {
                      onSaved!(value);
                    }
                    if (shouldClearData == true) {
                      controller?.clear();
                    }

                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onChanged: onChanged,
                  minLines: 1,
                  onTap: onTap,
                  readOnly: isReadOnly,
                  inputFormatters: inputFormatters, // Apply input formatters
                  style: TextStyle(
                      fontSize: 12.0.sp,
                      //fontFamily: 'Gilroy-Regular',
                      fontFamily: 'Gilroy',
                      color: Colors.white),
                  scrollPadding: EdgeInsets.all(0),
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                      hintText: hint, // Set hint text for text field
                      suffixIconConstraints:
                          BoxConstraints(minHeight: 18.sp, minWidth: 18.sp),
                      prefixIconConstraints:
                          BoxConstraints(minHeight: 18.sp, minWidth: 18.sp),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.transparent,
                      hintStyle: TextStyle(
                        fontSize: 13.0.sp, // Reduced font size for hint text
                        //fontFamily: 'Gilroy-Regular',
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.25,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                      border: InputBorder.none, // Remove default border
                      suffixIcon: suffixIcon != null
                          ? Padding(
                              padding: EdgeInsets.only(left: 8.0).r,
                              child: suffixIcon,
                            )
                          : null,
                      prefixIcon: prefixIcon,
                      contentPadding: contentPadding.r),
                ),
            ],
          ),
        );
      },
    );
  }
}
