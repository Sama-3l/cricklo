import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
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
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // final Color defaultWhite = ColorsConstants.defaultWhite;
    final Color onSurfaceGrey = ColorsConstants.onSurfaceGrey;
    final Color accentOrange = ColorsConstants.accentOrange;

    return Padding(
      padding: widget.padding.copyWith(
        bottom: widget.scrollPadding
            ? MediaQuery.of(context).viewInsets.bottom
            : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            Text(
              widget.title!,
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 12,
                letterSpacing: -0.5,
                color: widget.fontColor,
              ),
            ),
            const SizedBox(height: 8),
          ],
          Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: widget.readOnly,
                  onTap: widget.onTap,
                  onChanged: widget.onChanged,
                  onSubmitted: widget.onSubmitted,
                  focusNode: widget.focusNode,
                  textCapitalization: widget.textCapitalization,
                  keyboardType: widget.textInputType,
                  controller: widget.controller,
                  inputFormatters: widget.formatters,
                  maxLength: widget.maxLength,
                  cursorColor: accentOrange,

                  buildCounter:
                      (
                        BuildContext context, {
                        required int currentLength,
                        required bool isFocused,
                        required int? maxLength,
                      }) {
                        // Hide completely
                        if (maxLength == null || !widget.showBuilder) {
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
                    fontSize: widget.fontSize,
                    color: widget.fontColor ?? ColorsConstants.defaultBlack,
                    letterSpacing: -0.5,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: widget.hintText,
                    suffixIcon: widget.suffixIcon,
                    prefixIcon: widget.prefixIcon,
                    suffixIconConstraints: BoxConstraints(maxWidth: 32),
                    prefixIconConstraints: BoxConstraints(maxWidth: 32),

                    hintStyle: TextStyles.poppinsRegular.copyWith(
                      fontSize: widget.fontSize,
                      color: (widget.fontColor ?? ColorsConstants.textBlack)
                          .withValues(alpha: 0.5),
                      letterSpacing: -0.5,
                    ),
                    filled: true,
                    fillColor: onSurfaceGrey.withValues(alpha: 0.2),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    errorText: widget.errorText,
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
