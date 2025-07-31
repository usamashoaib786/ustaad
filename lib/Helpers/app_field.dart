import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_theme.dart';

class CustomAppTextField extends StatefulWidget {
  final String texthint;
  final TextEditingController? controller;
  final bool isPasswordField;
  final bool obscureText;
  final double? width;
  final double? height;
  final int? maxLines;
  final TextInputType? txtType;
  final bool? border;
  final Color? bgcolor;
  final Color? cursorColor;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;

  const CustomAppTextField({
    super.key,
    required this.texthint,
    required this.controller,
    this.isPasswordField = false,
    this.obscureText = false,
    this.txtType,
    this.border,
    this.bgcolor,
    this.cursorColor,
    this.hintStyle,
    this.prefixIcon,
    this.onChanged,
    this.suffix,
    this.width,
    this.height,
    this.maxLines,
  });

  @override
  State<CustomAppTextField> createState() => _CustomAppTextFieldState();
}

class _CustomAppTextFieldState extends State<CustomAppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPasswordField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 40,
      width: widget.width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: widget.border == false
            ? null
            : Border.all(color: const Color(0xffD4D8E2)),
        color: widget.bgcolor ?? const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        maxLines: widget.maxLines ?? 1,
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.txtType ?? TextInputType.name,
        cursorColor: widget.cursorColor ?? AppTheme.appColor,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          contentPadding: widget.height != null
              ? const EdgeInsets.all(15)
              : const EdgeInsets.all(10),
          hintText: widget.texthint,
          hintStyle: widget.hintStyle ??
              TextStyle(
                color: AppTheme.hintColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffix ??
              (widget.isPasswordField
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppTheme.appColor,
                      ),
                    )
                  : null),
        ),
      ),
    );
  }
}

Widget parentHomeSearchField(context, controller) {
  return Container(
    height: 44,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xffD4D8E2)),
      color: const Color(0xffFFFFFF),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      maxLines: 1,
      controller: controller,
      keyboardType: TextInputType.name,
      cursorColor: AppTheme.appColor,
      // onChanged: widget.onChanged,
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(8),
        hintText: "Explore Tutors",
        hintStyle: TextStyle(
          color: AppTheme.hintColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            "assets/images/search.png",
            color: Color(0xffA6ADBF),
          ),
        ),
      ),
    ),
  );
}
