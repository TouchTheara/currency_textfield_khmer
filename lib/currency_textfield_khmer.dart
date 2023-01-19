library currency_textfield_khmer;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pattern_formatter/pattern_formatter.dart';

/// A Calculator.
class CurrencyTextFieldKhmer extends StatelessWidget {
  const CurrencyTextFieldKhmer(
      {super.key,
      required this.controller,
      this.hintext = "Input",
      this.onchange,
      this.padding = const EdgeInsets.only(left: 5),
      this.raduis = 10,
      this.color = Colors.white,
      this.height,
      this.width,
      this.style,
      this.inputFormatters,
      this.keyboardType,
      this.margin,
      this.maxLength = 10,
      this.contentPadding,
      this.prefix,
      this.prefixIcon,
      this.prefixStyle,
      this.prefixIconColor,
      this.prefixIconConstraints,
      this.suffix,
      this.suffixIcon,
      this.suffixStyle,
      this.suffixIconColor,
      this.suffixIconConstraints,
      this.suffixText,
      this.prefixText,
      required this.isCurrencyFormat});
  final TextEditingController controller;

  final String? hintext;
  final double? raduis;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final EdgeInsets? contentPadding;
  final Function(String)? onchange;
  final Color? color;
  final double? width;
  final double? height;
  final int? style;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int maxLength;
  final bool isCurrencyFormat;
  final Widget? prefix;
  final Widget? prefixIcon;
  final TextStyle? prefixStyle;
  final Color? prefixIconColor;
  final BoxConstraints? prefixIconConstraints;
  final String? prefixText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final TextStyle? suffixStyle;
  final Color? suffixIconColor;
  final BoxConstraints? suffixIconConstraints;
  final String? suffixText;
  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;
    String tempString = "";
    bool noCollape = false;
    bool isPlusOne = false;
    bool isPlusOnDel = false;
    int plusValue = 0;
    bool isBackSpace = false;
    String formNum(String s) {
      return NumberFormat.decimalPattern().format(
        int.parse(s),
      );
    }

    void inputValue(String string) {
      noCollape = false;
      isPlusOne = false;
      isPlusOnDel = false;
      plusValue = 0;
      // });

      if (tempString.length > string.length) {
        try {
          debugPrint('Backspace${tempString.length}=$string=${string.length}');

          if (string.isNotEmpty) {
            // debugPrint('HHH==${numFormat.format(55555)}');
            if (string.contains(".")) {
              var temp = string;
              var strList = string.split(".");
              strList[0] = formNum(
                strList[0].replaceAll(',', ''),
              );
              string = "${strList[0]}.${strList[1]}";
              if (temp.length > string.length) {
                isPlusOnDel = true;
                plusValue = string.length - temp.length;
              }
              debugPrint(
                  'plusValue$isPlusOnDel==${string.length}==${temp.length}');
              debugPrint(
                  '$string==baseOffset${controller.selection.baseOffset}==${string.length}');
              try {
                controller.value = TextEditingValue(
                    text: string,
                    selection: TextSelection.fromPosition(TextPosition(
                        offset: isPlusOnDel
                            ? controller.selection.baseOffset - 1
                            : controller.selection.baseOffset)));
              } catch (e) {
                debugPrint('$e');
              }
            } else {
              if (string.length > maxLength) {
                var startLength = string.length - (maxLength + 1);
                string = string.replaceRange(
                    (string.length - 1) - startLength, string.length, "");
              }
              string = formNum(
                string.replaceAll(',', ''),
              );
              controller.value = TextEditingValue(
                  text: string,
                  selection: TextSelection.collapsed(offset: string.length));
            }
          }

          tempString = string;
          return;
        } catch (e) {
          debugPrint('Ex==$e');
          return;
        }
      } else if (string.isNotEmpty) {
        debugPrint('Local${Platform.localeName}');

        if (Platform.localeName.contains("KH")) {
          if (string[string.length - 1].contains(",")) {
            string = string.replaceRange(string.length - 1, string.length, ".");
            debugPrint('String$string');
          }
        }

        try {
          if (!string.contains(".")) {
            if (string.length > maxLength && !string.contains(".")) {
              debugPrint('v0===${string.length}');

              string =
                  string.replaceRange(string.length - 1, string.length, "");
              debugPrint('v===${string.length}');
            }
            string = formNum(
              string.replaceAll(',', ''),
            );
          } else {
            debugPrint('IsContain$string==${string[string.length - 1] != "."}');
            if (string[string.length - 1] != ".") {
              debugPrint('Hello');
              var temp = string;
              var strList = string.split(".");
              debugPrint('Hello1$strList');
              strList[0] = formNum(
                strList[0].replaceAll(',', ''),
              );

              debugPrint('Hello2${strList[0]}');

              string = "${strList[0]}.${strList[1]}";
              debugPrint('temp==${temp.length}string==${string.length}');
              if (string.length > temp.length) {
                isPlusOne = true;
                plusValue = string.length - temp.length;
              }
              debugPrint(
                  "strList=${temp.length}==after${string.length},plus=$plusValue==$isPlusOne");

              // setState(() {
              noCollape = true;
              // });
            }
          }
          // } else {
          //   string = formNum(
          //     string.replaceAll(',', ''),
          //   );
          // }
        } catch (e) {
          debugPrint('EX$e');
        }
        if (string.contains("..")) {
          debugPrint('v0===$string');

          string = string.replaceRange(string.length - 1, string.length, "");
          debugPrint('v===$string');
        }

        if (string.contains(".,")) {
          debugPrint('v0===$string');

          string = string.replaceRange(string.length - 1, string.length, "");
          debugPrint('v===$string');
        }
        if (string.contains(".") && string[string.length - 1].contains(".")) {
          debugPrint('a0===$string');

          string = string.replaceRange(string.length - 1, string.length, ".");
          debugPrint('a===$string');
        }
        tempString = string;
        if (noCollape == false) {
          debugPrint('WORK');
          controller.value = TextEditingValue(
            text: string,
            selection: TextSelection.collapsed(
              offset: string.length,
            ),
          );
        } else {
          debugPrint(
              'controller!=${controller.selection.baseOffset}==${isPlusOne ? 1 + controller.selection.baseOffset : controller.selection.baseOffset}');
          controller.value = TextEditingValue(
              text: string,
              selection: isPlusOne
                  ? TextSelection.fromPosition(
                      TextPosition(offset: controller.selection.baseOffset + 1))
                  : controller.selection);
        }
      } else {
        debugPrint('Empty');
      }
    }

    return Container(
      width: width ?? sizeWidth,
      height: height ?? sizeHeight * 0.1,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(raduis!)),
      ),
      child: TextField(
        maxLengthEnforcement: MaxLengthEnforcement.none,
        onChanged: (value) {
          if (!kIsWeb) {
            if (isCurrencyFormat) {
              inputValue(value);
              onchange?.call(value);
            } else {
              onchange?.call(value);
            }
          } else {
            onchange?.call(value);
          }
        },
        controller: controller,
        style: Theme.of(context).textTheme.headline4,
        decoration: InputDecoration(
          prefix: prefix,
          prefixIcon: prefixIcon,
          prefixStyle: prefixStyle,
          prefixIconColor: prefixIconColor,
          prefixIconConstraints: prefixIconConstraints,
          prefixText: prefixText,
          suffix: suffix,
          suffixIcon: suffixIcon,
          suffixStyle: suffixStyle,
          suffixIconColor: suffixIconColor,
          suffixIconConstraints: suffixIconConstraints,
          suffixText: suffixText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: Theme.of(context).textTheme.headline4,
          hintText: (hintext),
          contentPadding: contentPadding,
        ),
        keyboardType: keyboardType,
        inputFormatters: [
          if (kIsWeb) ThousandsFormatter(allowFraction: true),
          if (isCurrencyFormat) DecimalTextInputFormatter(decimalRange: 2),
          LengthLimitingTextInputFormatter(maxLength),
          ...inputFormatters ?? []
        ],
      ),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int? decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange!) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
