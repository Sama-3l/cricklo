import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String? title;
  final String hintText;
  final bool readOnly;
  final Function()? onTap;
  final FocusNode? focusNode;
  final Function(String currency)? onCurrencyChange;
  final String? selectedCurrency;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final Function(String value)? onChanged;
  final Widget? prefixIcon;
  final EdgeInsets padding;
  final TextInputType textInputType;
  final List<TextInputFormatter>? formatters;
  final TextEditingController controller;
  final int? maxLength;
  final double? fontSize;
  final Color? fontColor;
  final bool scrollPadding;
  final String? errorText;
  final bool autofocus;
  final bool showBuilder;
  final Function(String)? onSubmitted;

  const InputField({
    super.key,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.title,
    this.errorText,
    this.hintText = "Samael",
    this.focusNode,
    this.autofocus = false,
    this.suffixIcon,
    this.maxLength,
    this.textCapitalization = TextCapitalization.sentences,
    this.prefixIcon,
    this.onCurrencyChange,
    this.formatters,
    this.scrollPadding = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.selectedCurrency,
    this.textInputType = TextInputType.text,
    required this.controller,
    this.fontSize = 16,
    this.fontColor,
    this.showBuilder = false,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    // final Color defaultWhite = ColorsConstants.defaultWhite;
    final Color onSurfaceGrey = ColorsConstants.onSurfaceGrey;
    final Color accentOrange = ColorsConstants.accentOrange;

    return Padding(
      padding: padding.copyWith(
        bottom: scrollPadding ? MediaQuery.of(context).viewInsets.bottom : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 12,
                letterSpacing: -0.5,
                color: fontColor,
              ),
            ),
            const SizedBox(height: 8),
          ],
          Row(
            children: [
              Expanded(
                child: TextField(
                  autofocus: autofocus,
                  readOnly: readOnly,
                  onTap: onTap,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  focusNode: focusNode,
                  textCapitalization: textCapitalization,
                  keyboardType: textInputType,
                  controller: controller,
                  inputFormatters: formatters,
                  maxLength: maxLength,
                  cursorColor: accentOrange,

                  buildCounter:
                      (
                        BuildContext context, {
                        required int currentLength,
                        required bool isFocused,
                        required int? maxLength,
                      }) {
                        // Hide completely
                        if (maxLength == null || !showBuilder) {
                          return null;
                        }

                        // Or fully customise
                        return Text(
                          '$currentLength/$maxLength',
                          style: TextStyles.poppinsRegular.copyWith(
                            color: ColorsConstants.defaultWhite.withValues(
                              alpha: 0.5,
                            ),
                            fontSize: 10,
                            letterSpacing: -0.5,
                          ),
                        );
                      },
                  style: TextStyles.poppinsRegular.copyWith(
                    fontSize: fontSize,
                    color: fontColor ?? ColorsConstants.defaultBlack,
                    letterSpacing: -0.5,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: hintText,
                    suffixIcon: suffixIcon,
                    prefixIcon: prefixIcon,
                    suffixIconConstraints: BoxConstraints(maxWidth: 32),
                    prefixIconConstraints: BoxConstraints(maxWidth: 32),

                    hintStyle: TextStyles.poppinsRegular.copyWith(
                      fontSize: fontSize,
                      color: (fontColor ?? ColorsConstants.textBlack)
                          .withValues(alpha: 0.5),
                      letterSpacing: -0.5,
                    ),
                    filled: true,
                    fillColor: onSurfaceGrey,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    errorText: errorText,
                    errorStyle: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 8,
                      color: ColorsConstants.warningRed,
                      letterSpacing: -0.2,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorsConstants.accentOrange,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
