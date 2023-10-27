import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Function() onPressed;

  const DefaultButton({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height = AppSize.s45,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: ColorManager.black,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s5,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
