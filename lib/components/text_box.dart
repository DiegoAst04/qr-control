import 'package:flutter/material.dart';
import '../theme/colors.dart';

//   _____         _  ______
//  |_   _|       | | | ___ \
//    | | _____  _| |_| |_/ / _____  __
//    | |/ _ \ \/ / __| ___ \/ _ \ \/ /
//    | |  __/>  <| |_| |_/ / (_) >  <
//    \_/\___/_/\_\\__\____/ \___/_/\_\

class MiTextBox extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;
  final bool isError;

  const MiTextBox({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.isError = false,
  });

  @override
  _MiTextBoxState createState() => _MiTextBoxState();
}

class _MiTextBoxState extends State<MiTextBox> {
  late TextEditingController _internalController;
  late IconData? _currentIcon;
  bool isFocused = false;
  bool hasText = false;
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    _currentIcon = widget.suffixIcon;
    _internalController = widget.controller ?? TextEditingController();
    _internalController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      hasText = _internalController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  void _toggleIcon() {
    setState(() {
      if (_currentIcon == Icons.visibility) {
        _currentIcon = Icons.visibility_off;
        isObscure = !isObscure;
      } else {
        _currentIcon = Icons.visibility;
        isObscure = !isObscure;
      }
    });
  }

  TextStyle _buildLabelStyle() {
    Color labelColor = isFocused
        ? AppColors.secondaryColor
        : AppColors.primaryText;
    FontWeight labelWeight = isFocused
        ? FontWeight.normal
        : FontWeight.w300;
    return TextStyle(
        fontFamily: 'Poppins',
        fontWeight: labelWeight,
        fontSize: 14.0,
        color: labelColor
    );
  }

  Widget? _buildPrefixIcon() {
    Color iconColor = isFocused
        ? AppColors.primaryText
        : AppColors.secondaryText;
    if (hasText && !isFocused) {
      return Icon(
        widget.prefixIcon,
        color: AppColors.primaryText,
      );
    }
    if (widget.prefixIcon != null) {
      return Icon(
        widget.prefixIcon,
        color: iconColor,
      );
    }
    return null;
  }

  Widget? _buildSuffixIcon() {
    Color iconColor = isFocused
        ? AppColors.primaryText
        : AppColors.secondaryText;
    if (widget.isPassword) {
      return GestureDetector(
        onTap: _toggleIcon,
        child: Icon(
          _currentIcon,
          color: iconColor,
        ),
      );
    }
    return null;
  }

  BorderSide _buildBorderSide() {
    Color borderSideColor = hasText
        ? AppColors.secondaryColor
        :AppColors.secondaryDark;
    return BorderSide(
        color: borderSideColor,
        width: 2.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
        child: Focus(
            onFocusChange: (focus) {
              setState(() {
                isFocused = focus;
              });
            },
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  Text(
                      widget.label,
                      style: _buildLabelStyle()
                  ),
                  TextField(
                    controller: _internalController,
                    obscureText: widget.isPassword ? isObscure : false,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                    ),
                    decoration: InputDecoration(
                        prefixIcon: _buildPrefixIcon(),
                        suffixIcon: _buildSuffixIcon(),
                        hintText: widget.hintText,
                        fillColor: widget.isError
                            ? AppColors.errorColor
                            : isFocused
                            ? AppColors.secondaryDark
                            : AppColors.primaryDark,
                        enabledBorder: OutlineInputBorder(
                            borderSide: _buildBorderSide(),
                            borderRadius: BorderRadius.circular(16)
                        )
                    ),
                  ),
                ]
            )
        )
    );
  }
}