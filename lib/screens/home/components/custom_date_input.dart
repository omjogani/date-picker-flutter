import 'package:datepicker/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDateTextField extends StatelessWidget {
  const CustomDateTextField({
    Key? key,
    required this.hintText,
    required this.onSaved,
    required this.controller,
    required this.onChanged,
    required this.keyboardType,
    required this.validator,
    required this.focusNode,
    required this.onEditingComplete,
    required this.onSuffixIconClick,
  }) : super(key: key);
  final String hintText;
  final FormFieldSetter<String>? onSaved;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final FocusNode focusNode;
  final Function onEditingComplete;
  final Function onSuffixIconClick;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: kShadowColor,
            offset: Offset(0, 12),
            blurRadius: 16.0,
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        onChanged: onChanged,
        focusNode: focusNode,
        onEditingComplete: () => onEditingComplete(),
        onSaved: onSaved,
        textInputAction: TextInputAction.next,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        cursorRadius: const Radius.circular(10.0),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
        ],
        maxLength: 10,
        decoration: InputDecoration(
          counterText: "",
          suffixIcon: IconButton(
            icon: const Icon(Icons.date_range_outlined),
            color: Colors.black87,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onPressed: () => onSuffixIconClick(),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black38,
          ),
          errorStyle: const TextStyle(
            color: Colors.black45,
          ),
          fillColor: Colors.black,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
