import 'package:bloc_structure/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPTextFormField extends StatelessWidget {
  const OTPTextFormField(
      {Key? key,
      this.otpLength,
      this.isObSecure,
      this.textInputType,
      this.filledColor,
      this.borderRadius,
      required this.onChanged,
      required this.onSubmitted,
      this.mainAxisAlignment,
      this.boxWidth,
      this.onValidate,
      required this.textEditController,
      required this.focusNode,
      this.obSecureCharacter})
      : super(key: key);
  final TextEditingController textEditController;
  final FocusNode focusNode;
  final int? otpLength;
  final bool? isObSecure;
  final TextInputType? textInputType;
  final Color? filledColor;
  final double? borderRadius;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final FormFieldValidator<String>? onValidate;
  final MainAxisAlignment? mainAxisAlignment;
  final double? boxWidth;
  final String? obSecureCharacter;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: textEditController,
      focusNode: focusNode,
      hintCharacter: '0',
      autovalidateMode: AutovalidateMode.disabled,
      obscuringCharacter: obSecureCharacter ?? '•',
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      length: otpLength ?? otpMaxLength,
      pinTheme: PinTheme(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
        shape: PinCodeFieldShape.box,
        activeColor: Theme.of(context).primaryColor,
        activeFillColor: filledColor ?? Theme.of(context).canvasColor,
        borderWidth: 1,
        fieldOuterPadding: const EdgeInsets.only(right: 12),
        disabledColor: Theme.of(context).disabledColor,
        errorBorderColor: Theme.of(context).colorScheme.error,
        fieldWidth: boxWidth ?? 50,
        inactiveColor: Theme.of(context).splashColor,
        inactiveFillColor: filledColor ?? Theme.of(context).canvasColor,
        selectedColor: Theme.of(context).primaryColor,
        selectedFillColor: filledColor ?? Theme.of(context).canvasColor,
        fieldHeight: boxWidth ?? 55,
      ),
      keyboardType: textInputType ?? TextInputType.number,
      obscureText: isObSecure ?? false,
      appContext: context,
      validator: onValidate,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}

//TODO:Change text field design as per your ui requirement
class AppTextField extends StatefulWidget {
  final TextEditingController textEditController;
  final FocusNode focusNode;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final String labelText;
  final Color? filledColor;
  final bool? isFilled;
  final bool? isBorderEnabled;
  final bool? isRequired;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? onValidate;
  final bool isPassword;

  const AppTextField(
      {Key? key,
      required this.textEditController,
      required this.focusNode,
      this.textInputAction,
      required this.textInputType,
      required this.labelText,
      this.isFilled,
      this.filledColor,
      this.onChanged,
      this.isRequired,
      this.onSubmitted,
      required this.onValidate,
      this.isBorderEnabled})
      : isPassword = false,
        super(key: key);

  const AppTextField.password(
      {Key? key,
      required this.textEditController,
      required this.focusNode,
      this.textInputAction,
      required this.textInputType,
      required this.labelText,
      this.isFilled,
      this.filledColor,
      this.onChanged,
      this.isRequired,
      this.onSubmitted,
      required this.onValidate,
      this.isBorderEnabled})
      : isPassword = true,
        super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool passwordHide = true;

  late ThemeData _themeData;

  void _toggleVisibility() => setState(() => passwordHide = !passwordHide);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.textEditController,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        keyboardType: widget.textInputType,
        autocorrect: true,
        obscureText: widget.isPassword ? passwordHide : false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            labelText: widget.labelText,
            filled: widget.isFilled ?? true,
            fillColor: widget.filledColor ?? _themeData.inputDecorationTheme.fillColor,
            suffixIcon: widget.isPassword
                ? Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: IconButton(
                      icon: Icon(passwordHide ? Icons.visibility_off : Icons.visibility),
                      onPressed: _toggleVisibility,
                    ),
                  )
                : null),
        onFieldSubmitted: widget.onSubmitted,
        onChanged: widget.onChanged,
        validator: widget.onValidate);
  }
}
