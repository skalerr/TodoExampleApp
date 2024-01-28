import 'package:flutter/material.dart';

class MyCustomCheckBox extends StatelessWidget {
  const MyCustomCheckBox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  final bool isChecked;

  final void Function(bool?) onChanged;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked,
            onChanged: (value) => onChanged(value))
      ],
    );
  }
}
