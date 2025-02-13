import 'package:flutter/material.dart';
import 'package:qr_control/theme/colors.dart';

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
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

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
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
  }): super(key: key);

  @override
  _FormTextBoxState createState() => _FormTextBoxState();
}

class _FormTextBoxState extends State<FormTextBox> {
  late TextEditingController _internalController;
  late FocusNode _internalFocusNode;
  late IconData? _currentIcon;
  bool hasText = false;
  bool isObscure = true;
  bool _hasInternalFocusNode = false;

  @override
  void initState() {
    super.initState();
    _currentIcon = widget.suffixIcon;
    _internalController = widget.controller ?? TextEditingController();
    _internalController.addListener(() {
      setState(() {
        hasText = _internalController.text.isNotEmpty;
      });
    });
    if(widget.focusNode == null) {
      _internalFocusNode = FocusNode();
      _hasInternalFocusNode = true;
    } else {
      _internalFocusNode = widget.focusNode!;
    }
    _internalFocusNode.addListener(() {
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
      fontFamily: 'Poppins',
      fontWeight: labelWeight,
      fontSize: 14.0,
      color: labelColor
    );
  }

  Widget? _buildPrefixIcon() {
    Color iconColor = _internalFocusNode.hasFocus || hasText
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
    Color borderSideColor = hasText
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
        Text(
          widget.label!,
          style: _buildLabelStyle()
        ),
        TextFormField(
          controller: _internalController,
          focusNode: _internalFocusNode,
          obscureText: widget.isPassword ? isObscure : false,
          textCapitalization: widget.textCapitalization,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
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

//  ______       _   _
//  | ___ \     | | | |
//  | |_/ /_   _| |_| |_ ___  _ __
//  | ___ \ | | | __| __/ _ \| '_ \
//  | |_/ / |_| | |_| || (_) | | | |
//  \____/ \__,_|\__|\__\___/|_| |_|

class MiButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const MiButton({
    super.key,
    required this.text,
    this.onPressed
  });

  @override
  _MiButtonState createState() => _MiButtonState();
}

class _MiButtonState extends State<MiButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            widget.text,
            style: const TextStyle(
              color: AppColors.primaryText,
              fontSize: 20,
            ),
          )
        )
      )
    );
  }
}

//   _   _               _____        __    ______
//  | | | |             /  ___|      / _|   | ___ \
//  | |_| | _____      _\ `--.  __ _| |_ ___| |_/ / __ _ _ __
//  |  _  |/ _ \ \ /\ / /`--. \/ _` |  _/ _ \ ___ \/ _` | '__|
//  | | | | (_) \ V  V //\__/ / (_| | ||  __/ |_/ / (_| | |
//  \_| |_/\___/ \_/\_/ \____/ \__,_|_| \___\____/ \__,_|_|

class PasswordSafeBar extends StatefulWidget {
  final String password;

  PasswordSafeBar({
    super.key,
    required this.password
  });

  @override
  _SafeBarState createState() => _SafeBarState();
}

enum _PasswordStrength { useless, weak, medium, strong }

class _SafeBarState extends State<PasswordSafeBar> {
  _PasswordStrength _evalPasswordStrength() {
    String password = widget.password;
    if ((_hasCaps(password) || _hasNoCaps(password))
        && (_hasSpecialChars(password) || _hasNumbers(password)
            || password.length >= 6))
    {
      if ((_hasCaps(password) && _hasNoCaps(password))
          && (_hasSpecialChars(password) || _hasNumbers(password)
              && password.length >= 8))
      {
        if ((_hasCaps(password) && _hasNoCaps(password))
            && (_hasSpecialChars(password) && _hasNumbers(password)
                && password.length >= 10))
        {
          return _PasswordStrength.strong;
        }
        return _PasswordStrength.medium;
      }
      return _PasswordStrength.weak;
    }
    return _PasswordStrength.useless;
  }
  bool _hasNumbers(String text) {
    return text.contains(RegExp(r'\d'));
  }
  bool _hasSpecialChars(String text) {
    return text.contains(RegExp(r'[¡!@#$%^&*(),._¿?":{}|<>]'));
  }
  bool _hasCaps(String text) {
    return text.contains(RegExp(r'[A-Z]'));
  }
  bool _hasNoCaps(String text) {
    return text.contains(RegExp(r'[a-z]'));
  }

  @override
  Widget build(BuildContext context) {
    final _PasswordStrength strength = _evalPasswordStrength();
    final Map<_PasswordStrength, Color> colors = {
      _PasswordStrength.useless: AppColors.errorColor,
      _PasswordStrength.weak: AppColors.warningColor,
      _PasswordStrength.medium: AppColors.ambarColor,
      _PasswordStrength.strong: AppColors.successColor
    };
    final Map<_PasswordStrength, String> texts = {
      _PasswordStrength.useless: "insegura",
      _PasswordStrength.weak: "poco segura",
      _PasswordStrength.medium: "puede mejorar",
      _PasswordStrength.strong: "segura"
    };
    final Map<_PasswordStrength, double> widths = {
      _PasswordStrength.useless: 0.1,
      _PasswordStrength.weak: 0.4,
      _PasswordStrength.medium: 0.7,
      _PasswordStrength.strong: 1.0
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: widths[strength],
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                color: colors[strength],
                borderRadius: BorderRadius.circular(2)
              ),
            ),
          ),
        ),
        Text(
          texts[strength]!,
          style: TextStyle(
            color: colors[strength],
            fontSize: 12
          ),
        )
      ],
    );
  }
}

//   _____                _  ______
//  |  ___|              | | | ___ \
//  | |____   _____ _ __ | |_| |_/ / _____  __
//  |  __\ \ / / _ \ '_ \| __| ___ \/ _ \ \/ /
//  | |___\ V /  __/ | | | |_| |_/ / (_) >  <
//  \____/ \_/ \___|_| |_|\__\____/ \___/_/\_\

class EventBox extends StatefulWidget {
  final String artist;
  final DateTime date;
  final String place;

  EventBox ({
    super.key,
    required this.artist,
    required this.date,
    required this.place
  });

  @override
  _EventBoxState createState() => _EventBoxState();
}
class _EventBoxState extends State<EventBox> {
  int _getWeekDay() {
    return widget.date.weekday - 1;
  }
  int _getDate() {
    return widget.date.day;
  }
  int _getMonth() {
    return widget.date.month - 1;
  }

  final List<String> weekDays = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];
  final List<String> months = [
    'enero',
    'febrero',
    'marzo',
    'abril',
    'mayo',
    'junio',
    'julio',
    'agosto',
    'setiembre',
    'octubre',
    'noviembre',
    'diciembre'
  ];

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryDark,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${weekDays[_getWeekDay()]} ${_getDate()} de ${months[_getMonth()]}",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w100,
                      color: AppColors.primaryText
                    ),
                  ),
                  Text(
                    widget.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryText,
                    ),
                  ),
                  Text(
                    widget.place,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppColors.secondaryText
                    ),
                  ),
                ]
              )
            )
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red
                    ),
                  ),
                  child: const Text(
                    "[Imagen]",
                    style: TextStyle(
                      color: AppColors.secondaryText
                    ),
                  ),
                )
              ]
            )
          )
        ],
      )
    );
  }
}