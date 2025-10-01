import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final bool disabled;
  final VoidCallback onPress;
  final Widget child;
  final Color? color;
  final Color? disabledColor;
  final double radius;
  final EdgeInsets padding;
  final bool noShadow;

  const PrimaryButton({
    super.key,
    required this.disabled,
    required this.onPress,
    required this.child,
    this.color,
    this.radius = 8,
    this.disabledColor,
    this.noShadow = false,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    final enabledColor = color ?? ColorsConstants.accentOrange;
    final offColor = disabledColor ?? ColorsConstants.onSurfaceGrey;

    // pick target color only
    final targetColor = disabled ? offColor : enabledColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: targetColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: noShadow
            ? []
            : [
                if (!disabled)
                  BoxShadow(
                    color: targetColor.withValues(alpha: 0.4),
                    blurRadius: 48,
                    offset: const Offset(0, 0),
                  ),
              ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0, // remove default elevation, we use our own shadow
          backgroundColor: Colors.transparent, // already set in container
          shadowColor: Colors.transparent,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: padding,
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: disabled ? null : onPress,
        child: child,
      ),
    );
  }
}
