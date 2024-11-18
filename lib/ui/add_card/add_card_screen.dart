import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';

import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';
import '../../utils/custum_radiobutton.dart';
import '../base_components/animated_column.dart';
import '../base_components/base_scaffold_background.dart';
import '../base_components/base_text.dart';
import '../base_components/base_textfield.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  int _selectedCard =1;
  String? dropdownValue;
  List<String> options = ['Demo'];

  @override
  Widget build(BuildContext context) {
    return  BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: AnimatedColumn(
              milliseconds: 200,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSizeHeight(26),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    BaseAssets.backArrow,
                    width: 19,
                    height: 20,
                  ),
                ),
                buildSizeHeight(24),
                const BaseText(
                  value: 'Add Card',
                  color: BaseColors.secondaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                buildSizeHeight(13),
                const BaseText(
                  value: 'Please fill in your details to payment.',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                buildSizeHeight(25),
                //Apartment / Flat / Block Number
                Row(
                  children: [
                    CustomRadio(
                      value: 1,
                      groupValue:  _selectedCard,
                      onChanged: (value) {
                        setState(() {
                          _selectedCard = value;
                        });
                      },
                    ),
                    buildSizeWidth(10),
                    const BaseText(
                        textAlign: TextAlign.center,
                        value: 'Credit Card',
                        color: BaseColors.grey),
                    buildSizeWidth(35),
                    CustomRadio(
                      value: 2,
                      groupValue: _selectedCard,
                      onChanged: (value) {
                        setState(() {
                          _selectedCard = value;
                        });
                      },
                    ),
                    buildSizeWidth(10),
                    const BaseText(
                        textAlign: TextAlign.center,
                        value: 'Debit Card',
                        color: BaseColors.grey),
                  ],
                ),
                buildSizeHeight(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseText(
                      value: 'Bank Name',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    buildSizeHeight(6.5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        border:
                        Border.all(width: 1.0, color: BaseColors.lightSky),
                      ),
                      child: DropdownButton<String>(
                        hint: const BaseText(
                          value: 'Select Bank',
                          color: BaseColors.black,
                        ),
                        value: dropdownValue,
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        underline: const SizedBox(),
                        isExpanded: true,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        dropdownColor: Colors.white,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                        selectedItemBuilder: (BuildContext context) {
                          return options.map((String value) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dropdownValue ?? '',
                              ),
                            );
                          }).toList();
                        },
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(fontSize: 15)),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                buildSizeHeight(15),
                //street number / name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseText(
                      value: 'Account Holder\'s Name',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    buildSizeHeight(6.5),
                    const BaseTextField(
                      labelText: '',
                      hintText: 'Enter Account Holder\'s Name',
                      hintTextColor: BaseColors.grey,
                      borderColor: BaseColors.lightSky,
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                  ],
                ),
                buildSizeHeight(15),
                // business / building name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseText(
                      value: 'Card Number',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    buildSizeHeight(6.5),
                    const BaseTextField(
                      labelText: '',
                      hintText: 'Enter Card Number',
                      hintTextColor: BaseColors.grey,
                      borderColor: BaseColors.lightSky,
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                  ],
                ),
                buildSizeHeight(15),
                //Instruction for delivery person
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseText(
                      value: 'Exp. Date',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    buildSizeHeight(6.5),
                    const BaseTextField(
                      labelText: '',
                      hintText: 'MM YYYY',
                      hintTextColor: BaseColors.grey,
                      borderColor: BaseColors.lightSky,
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                  ],
                ),
                buildSizeHeight(15),
                //Instruction for delivery person
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseText(
                      value: 'CVV',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    buildSizeHeight(6.5),
                    const BaseTextField(
                      labelText: '',
                      hintText: 'Enter CVV',
                      hintTextColor: BaseColors.grey,
                      borderColor: BaseColors.lightSky,
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                  ],
                ),
                buildSizeHeight(25),
                BaseButton(
                  borderRadius: 0.0,
                  title: 'Save',
                  onPressed: () {
                   Get.back();
                  },
                ),
                buildSizeHeight(25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
