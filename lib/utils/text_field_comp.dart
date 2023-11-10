import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/utils/constants.dart';

class TextInputNoIcon extends StatelessWidget {
  const TextInputNoIcon(
      {this.icon,
      this.onSaved,
      this.onChanged,
      this.inputType,
      this.controller,
      this.inputFormatters,
      this.prefixIcon,
      this.read = false,
      this.filled = false,
      this.validator,
      this.suffixIcon,
      this.textCapitalize,
      this.maxLine,
      this.obscure = false,
      this.addSpace = false,
      this.labelText,
      this.focusNode,
      this.onTap,
      this.fillColor,
      this.helperText,
      this.outlinedBorder = false,
      this.roundBorders = false,
      this.extraText = false,
      this.hintText,
      this.extraTextString,
      required this.text});

  final String? labelText, extraTextString, helperText;
  final Widget? icon, suffixIcon, prefixIcon;
  final bool obscure,
      read,
      outlinedBorder,
      extraText,
      addSpace,
      filled,
      roundBorders;
  final int? maxLine;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalize;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final Color? fillColor;
  final String text;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text.isEmpty
            ? const SizedBox()
            : Text(
                text,
                style: textTheme.headlineMedium!.copyWith(
                  color: kPurple50,
                  fontWeight: FontWeight.w500
                ),
              ),
        YBox(kPadding),
        TextFormField(
          keyboardType: inputType,
          readOnly: read,
          style: textTheme.headlineMedium!.copyWith(
            color:kDarkColor400

          ),
          obscuringCharacter: ".",
          cursorColor: kPrimaryColor,
          focusNode: focusNode,
          textCapitalization: textCapitalize == null
              ? TextCapitalization.none
              : textCapitalize!,
          obscureText: obscure,
          onSaved: onSaved,
          validator: validator,
          controller: controller,
          onChanged: onChanged,
          // autovalidateMode: AutovalidateMode.,
          inputFormatters: inputFormatters,
          maxLines: maxLine ?? 1,
          cursorWidth: 1,
          cursorHeight: kMediumPadding,
          decoration: InputDecoration(
            helperText: helperText,
            prefixIcon: prefixIcon,
            hintText: hintText,
            filled: true,
            fillColor: read ? kTextInputBorderColor.withOpacity(0.4) : kPrimaryWhite,
            hintStyle: textTheme.headlineMedium!.copyWith(color: kGrey200),
            helperStyle: textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelText: labelText,
            alignLabelWithHint: true,
            labelStyle: textTheme.titleMedium!.copyWith(
              color: Colors.black,
            ),
            prefix: suffixIcon,
            // isDense: true,
            suffixIcon: icon,
            border: const OutlineInputBorder(),
            errorMaxLines: 2,
            errorStyle: textTheme.titleMedium!
                .copyWith(color: kPrimaryColor, overflow: TextOverflow.visible),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: kTextInputBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(kSmallPadding))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: kTextInputBorderColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(kSmallPadding))),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
          ),
          onTap: onTap,
        ),
        addSpace ? const SizedBox() : YBox(kRegularPadding)
      ],
    );
  }
}

class SearchTextInputNoIcon extends StatelessWidget {
  const SearchTextInputNoIcon(
      {super.key, this.icon,
      this.onSaved,
      this.onChanged,
      this.inputType,
      this.controller,
      this.inputFormatters,
      this.prefixIcon,
      this.read = false,
      this.filled = false,
      this.validator,
      this.suffixIcon,
      this.textCapitalize,
      this.maxLine,
      this.obscure = false,
      this.addSpace = false,
      this.labelText,
      this.focusNode,
      this.onTap,
      this.fillColor,
      this.helperText,
      this.outlinedBorder = false,
      this.roundBorders = false,
      this.extraText = false,
      this.hintText,
      this.extraTextString,
      });

  final String? labelText, extraTextString, helperText;
  final Widget? icon, suffixIcon, prefixIcon;
  final bool obscure,
      read,
      outlinedBorder,
      extraText,
      addSpace,
      filled,
      roundBorders;
  final int? maxLine;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalize;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final Color? fillColor;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          keyboardType: inputType,
          readOnly: read,
          style: textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
          obscuringCharacter: ".",
          cursorColor: kPrimaryColor,
          focusNode: focusNode,
          textCapitalization: textCapitalize == null
              ? TextCapitalization.none
              : textCapitalize!,
          obscureText: obscure,
          onSaved: onSaved,
          validator: validator,
          controller: controller,
          onChanged: onChanged,
          // autovalidateMode: AutovalidateMode.,
          inputFormatters: inputFormatters,
          maxLines: maxLine ?? 1,
          cursorWidth: 1,
          cursorHeight: kMediumPadding,
          decoration: InputDecoration(
            helperText: helperText,
            prefixIcon: prefixIcon,
            hintText: hintText,
            filled: true,
            fillColor: kLight400,
            hintStyle: textTheme.displayMedium!.copyWith(color: kGrey200),
            helperStyle: textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelText: labelText,
            alignLabelWithHint: true,
            labelStyle: textTheme.titleMedium!.copyWith(
              color: Colors.black,
            ),
            prefix: suffixIcon,
            // isDense: true,
            suffixIcon: icon,
            border: const OutlineInputBorder(),
            errorMaxLines: 2,
            errorStyle: textTheme.titleMedium!
                .copyWith(color: kPrimaryColor, overflow: TextOverflow.visible),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: kLight300),
                borderRadius: BorderRadius.all(Radius.circular(500))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(500))),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
          ),
          onTap: onTap,
        ),
        addSpace ? const SizedBox() : YBox(18)
      ],
    );
  }
}
