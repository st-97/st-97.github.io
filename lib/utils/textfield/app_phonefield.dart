import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/utils/others/app_color.dart';
import 'package:portfolio/utils/textfield/app_field.dart';
import 'package:portfolio/utils/texts/app_text.dart';

class AppPhoneField extends StatefulWidget {
  const AppPhoneField({
    Key? key,
    required this.hintLabel,
    this.floatingBehavior = false,
    this.textFieldFocusNode,
    this.myController,
    this.onValidator,
    this.onChangedOccured,
    this.onCountryChanged,
    this.labelStyle,
    this.onChanged,
    this.countryCode,
  }) : super(key: key);

  final String hintLabel;
  final String? countryCode;
  final FocusNode? textFieldFocusNode;
  final bool floatingBehavior;
  final TextEditingController? myController;
  final void Function(String)? onChangedOccured;
  final String? Function(String?)? onValidator;
  final void Function(String)? onCountryChanged;
  final TextStyle? labelStyle;
  final Function(String)? onChanged;

  @override
  AppPhoneFieldState createState() => AppPhoneFieldState();
}

class AppPhoneFieldState extends State<AppPhoneField> {
  var countryPhoneCode = "1";
  var countryCode = "US";
  var flagEmoji = "";
  String countryCodeToFlagEmoji(String? countryCode) {
    if (countryCode == '' || countryCode == null) {
      return "";
    }
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flagEmoji = countryCodeToFlagEmoji(widget.countryCode ?? countryCode);
    widget.onCountryChanged!("+$countryPhoneCode");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.2.sh,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.lightGrey,
        ),
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showCountryPicker(
                context: context,
                showPhoneCode: true,
                onSelect: (Country country) {
                  widget.onCountryChanged!("+${country.phoneCode}");
                  setState(() {
                    flagEmoji = country.flagEmoji;
                    countryPhoneCode = country.phoneCode;
                  });
                },
                countryListTheme: const CountryListThemeData(
                  searchTextStyle: TextStyle(
                    color: AppColors.black,
                  ),
                  textStyle: TextStyle(
                    color: AppColors.black,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 14, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText.subHeader(
                    text: flagEmoji,
                    fontSize: 18.sp,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Icon(Icons.expand),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          AppText.subHeader(
            text: widget.countryCode ?? '+$countryPhoneCode ',
            fontSize: 15.sp,
          ),
          Container(
            margin: const EdgeInsets.only(top: 4, bottom: 4, left: 5, right: 0),
            color: AppColors.grey,
            height: 0.05.sh,
            width: 1,
          ),
          SizedBox(
            width: 8.w,
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(top: 3),
              child: AppField.borderless(
                controller: widget.myController!,
                hint: widget.hintLabel,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
