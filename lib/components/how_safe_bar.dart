import 'package:flutter/material.dart';
import '../theme/colors.dart';

//   _   _               _____        __    ______
//  | | | |             /  ___|      / _|   | ___ \
//  | |_| | _____      _\ `--.  __ _| |_ ___| |_/ / __ _ _ __
//  |  _  |/ _ \ \ /\ / /`--. \/ _` |  _/ _ \ ___ \/ _` | '__|
//  | | | | (_) \ V  V //\__/ / (_| | ||  __/ |_/ / (_| | |
//  \_| |_/\___/ \_/\_/ \____/ \__,_|_| \___\____/ \__,_|_|

class PasswordSafeBar extends StatefulWidget {
  final String password;

  const PasswordSafeBar({
    super.key,
    required this.password
  });

  @override
  SafeBarState createState() => SafeBarState();
}

enum _PasswordStrength { useless, weak, medium, strong }

class SafeBarState extends State<PasswordSafeBar> {
  _PasswordStrength _evalPasswordStrength() {
    String password = widget.password;
    if ((_hasCaps(password) || _hasNoCaps(password))
      && (_hasSpecialChars(password) || _hasNumbers(password)
      || password.length >= 6))
    {
      if ( password.length >= 8 &&
        ((_hasCaps(password) && _hasNoCaps(password) && _hasNumbers(password))
        || (_hasCaps(password) && _hasNoCaps(password) && _hasSpecialChars(password))
        || (_hasCaps(password) && _hasNumbers(password)) && _hasSpecialChars(password))
        || (_hasNoCaps(password) && _hasNumbers(password) && _hasSpecialChars(password)))
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
        SizedBox(
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