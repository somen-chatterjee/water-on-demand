import 'package:flutter/material.dart';
import 'package:water_on_demand/utils/base_colors.dart';

class CustomRadio extends StatefulWidget {
  final int value;
  final int groupValue;
  final void Function(int) onChanged;
  const CustomRadio(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged});

  @override
  // ignore: library_private_types_in_public_api
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);

    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: BaseColors.grey,width: 0.5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0.5,
                blurRadius: 5)
          ],
        ),
        child: Icon(
          Icons.circle,
          size: 12,
          color: selected ? BaseColors.secondaryColor : Colors.white,
        ),
      ),
    );
  }
}
