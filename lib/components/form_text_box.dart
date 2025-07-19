import 'package:flutter/material.dart';
import '../theme/colors.dart';

//  ______                 _____         _  ______
//  |  ___|               |_   _|       | | | ___ \
//  | |_ ___  _ __ _ __ ___ | | _____  _| |_| |_/ / _____  __
//  |  _/ _ \| '__| '_ ` _ \| |/ _ \ \/ / __| ___ \/ _ \ \/ /
//  | || (_) | |  | | | | | | |  __/>  <| |_| |_/ / (_) >  <
//  \_| \___/|_|  |_| |_| |_\_/\___/_/\_\\__\____/ \___/_/\_\

class FormTextBox extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;
  final bool readOnly;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final TextInputType keyboardType;

  const FormTextBox({
    Key? key,
    this.label,
    this.hintText,
    this.validator,
    this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.readOnly = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.onTap,
    this.keyboardType = TextInputType.text
  }): super(key: key);

  @override
  FormTextBoxState createState() => FormTextBoxState();
}

class FormTextBoxState extends State<FormTextBox> {
  late TextEditingController _internalController;
  late FocusNode _internalFocusNode;
  late IconData? _currentIcon;
  bool? hasText;
  bool isObscure = true;
  bool _hasInternalFocusNode = false;

  @override
  void initState() {
    super.initState();
    _currentIcon = widget.suffixIcon;
    _internalController = widget.controller ?? TextEditingController();
    hasText = _internalController.text.isNotEmpty;

    _internalController.addListener(() {
      if (mounted) {
        setState(() {
          hasText = _internalController.text.isNotEmpty;
        });
      }
    });
    if(widget.focusNode == null) {
      _internalFocusNode = FocusNode();
      _hasInternalFocusNode = true;
    } else {
      _internalFocusNode = widget.focusNode!;
    }
    _internalFocusNode.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    if (_hasInternalFocusNode) {
      _internalFocusNode.dispose();
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
    Color labelColor = _internalFocusNode.hasFocus
        ? AppColors.secondaryColor
        : AppColors.primaryText;
    FontWeight labelWeight = _internalFocusNode.hasFocus
        ? FontWeight.normal
        : FontWeight.w300;
    return TextStyle(
      fontWeight: labelWeight,
      fontSize: 14.0,
      color: labelColor
    );
  }

  Widget? _buildPrefixIcon() {
    Color iconColor = _internalFocusNode.hasFocus || hasText!
        ? AppColors.primaryText
        : AppColors.secondaryText;
    if (widget.prefixIcon != null) {
      return Icon(
        widget.prefixIcon,
        color: iconColor,
      );
    }
    return null;
  }

  Widget? _buildSuffixIcon() {
    Color iconColor = _internalFocusNode.hasFocus
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

  Color _buildFillColor() {
    Color fillColor = _internalFocusNode.hasFocus
        ? AppColors.secondaryDark
        : AppColors.primaryDark;
    return fillColor;
  }

  BorderSide _buildBorderSide() {
    Color borderSideColor = hasText!
        ? AppColors.secondaryColor
        : AppColors.secondaryDark;
    return BorderSide(
      color: borderSideColor,
      width: 2
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        if (widget.label != null)
        Text(
          widget.label!,
          style: _buildLabelStyle()
        ),
        TextFormField(
          controller: _internalController,
          focusNode: _internalFocusNode,
          obscureText: widget.isPassword ? isObscure : false,
          readOnly: widget.readOnly,
          textCapitalization: widget.textCapitalization,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          onTap: widget.onTap,
          textInputAction: widget.textInputAction,
          cursorRadius: const Radius.circular(2),
          decoration: InputDecoration(
            prefixIcon: _buildPrefixIcon(),
            suffixIcon: _buildSuffixIcon(),
            hintText: widget.hintText,
            fillColor: _buildFillColor(),
            enabledBorder: OutlineInputBorder(
              borderSide: _buildBorderSide(),
              borderRadius: BorderRadius.circular(16)
            )
          ),
        )
      ]
    );
  }
}