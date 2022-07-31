import 'package:flutter/material.dart';

class TextFieldContainer extends StatefulWidget {
  final Decoration? containerDecoration;
  final Widget? child;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String hintText;
  final String? asssetPath;
  final GlobalKey<FormState>? formkey;
  final bool? obscureText;
  final String errorMsg;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? presuffixIcon;
  final Color? fillcolor;
  final double? width;
  final double? height;
  final int? maxLines;
  final int? minLines;
  final bool? focusedBorder;
  final bool? border;
  final bool enabledBorder;
  final bool autofocus;
  final TextEditingController? controller;
  final Color? hintTextColor;
  final double? hintTextSize;
  final String? initialValue;
  final double? texthintbottomPadding;
  final double? texthintleftPadding;
  final Color? cursorColor;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final bool? enabled;
  final bool? readOnly;
  final InputDecoration? decoration;
  final AutovalidateMode? validateMode;

  const TextFieldContainer(
      {Key? key,
      this.child,
      this.height,
      this.width,
      this.onChanged,
      this.keyboardType,
      this.initialValue,
      required this.hintText,
      this.asssetPath,
      this.minLines,
      this.maxLines,
      this.formkey,
      this.presuffixIcon,
      required this.errorMsg,
      this.obscureText,
      this.validateMode,
      this.validator,
      this.controller,
      this.fillcolor,
      this.suffixIcon,
      this.focusedBorder = true,
      this.border = true,
      this.enabledBorder = true,
      this.enabled = true,
      this.readOnly = false,
      this.onTap,
      this.texthintbottomPadding,
      this.hintTextColor,
      this.hintTextSize,
      this.onEditingComplete,
      this.texthintleftPadding,
      this.cursorColor,
      this.decoration,
      this.autofocus = false,
      this.containerDecoration})
      : super(key: key);
  @override
  _TextFieldContainerState createState() =>
      _TextFieldContainerState(this.child);
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  final Widget? child;

  _TextFieldContainerState(this.child);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: widget.containerDecoration,
      width: widget.width == null ? screenWidth : screenWidth * widget.width!,
      height: widget.height == null ? null : screenHeight * widget.height!,
      child: TextFormField(
        autovalidateMode: widget.validateMode,
        autofocus: widget.autofocus,
        cursorColor:
            widget.cursorColor == null ? Colors.black : widget.cursorColor,
        maxLines: widget.maxLines == null ? null : widget.maxLines,
        minLines: widget.minLines == null ? null : widget.minLines,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        enabled: widget.enabled,
        initialValue: widget.initialValue == null ? null : widget.initialValue,
        controller: widget.controller,
        readOnly: widget.readOnly!,
        style: TextStyle(
            fontSize: widget.hintTextSize, color: widget.hintTextColor),
        obscureText: widget.obscureText == null ? false : widget.obscureText!,
        decoration: buildInputDecoration(
            hinttext: widget.hintText,
            suffixIcon: widget.suffixIcon,
            assetPath: widget.asssetPath,
            presuffixIcon: widget.presuffixIcon,
            fillcolor: widget.fillcolor,
            color: widget.hintTextColor == null
                ? Colors.black
                : widget.hintTextColor!,
            bottom: widget.texthintbottomPadding == null
                ? 0.0
                : widget.texthintbottomPadding!,
            left: widget.texthintleftPadding == null
                ? 0.0
                : widget.texthintleftPadding!,
            border: widget.border,
            enabledBorder: widget.enabledBorder,
            focusedBorder: widget.focusedBorder,
            fontsize: widget.hintTextSize == null ? 14 : widget.hintTextSize!,
            imageColor: Theme.of(context).primaryColor),
        validator: widget.validator,
        onTap: widget.onTap,
        // onEditingComplete: widget.onEditingComplete ??
        //     () {
        //       FocusScope.of(context).requestFocus(FocusNode());
        //       if (widget.formkey!.currentState!.validate()) {
        //         return;
        //       } else {
        //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //           content: Text(widget.errorMsg,
        //               style: const TextStyle(fontFamily: "Almarai")),
        //         ));
        //       }
        //     }
      ),
    );
  }
}

InputDecoration buildInputDecoration({
  required String hinttext,
  String? assetPath,
  required Color color,
  required double fontsize,
  required Color imageColor,
  Color? fillcolor,
  Widget? suffixIcon,
  Widget? presuffixIcon,
  bool? focusedBorder = true,
  bool? border = true,
  bool enabledBorder = true,
  double bottom = 0.0,
  double left = 0.0,
}) {
  return InputDecoration(
      hintText: hinttext,
      isDense: true,
      errorMaxLines: 1,
      errorStyle: const TextStyle(
        color: Colors.transparent,
        fontSize: 0,
      ),
      prefixIcon: assetPath == null
          ? presuffixIcon
          : Image.asset(
              assetPath,
              height: 17,
              width: 17,
              color: imageColor,
            ),
      suffixIcon: suffixIcon,
      hintStyle: TextStyle(fontSize: fontsize, color: color),
      contentPadding: const EdgeInsets.all(13),
      fillColor: fillcolor == null ? const Color(0xFFEEEEEE) : fillcolor,
      filled: true,
      focusedBorder: focusedBorder == true
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Color(0xFFEEEEEE),
              ),
            )
          : InputBorder.none,
      border: border == true
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Color(0xFFEEEEEE),
              ),
            )
          : InputBorder.none,
      enabledBorder: enabledBorder == true
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(color: Color(0xFFEEEEEE), width: 1.0),
            )
          : InputBorder.none);
}
//,