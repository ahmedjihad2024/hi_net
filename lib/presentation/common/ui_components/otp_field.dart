import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpField extends StatefulWidget {
  final int length;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;
  final MainAxisSize mainAxisSize;
  final double fieldWidth;
  final double fieldHeight;
  final Decoration unselectedFieldDecoration;
  final Decoration selectedFieldDecoration;
  final Function(String)? onComplete;
  final Function(String)? onCancelled;
  final bool autofocus;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final hintText;
  final Color? cursorColor;
  const OtpField({
    super.key,
    this.length = 5,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = 10,
    this.mainAxisSize = MainAxisSize.max,
    this.fieldWidth = 40,
    this.fieldHeight = 40,
    this.unselectedFieldDecoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.black,
    ),
    this.selectedFieldDecoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.blue,
    ),
    this.onComplete,
    this.onCancelled,
    this.autofocus = true,
    this.textStyle = const TextStyle(fontSize: 16, color: Colors.black),
    this.hintStyle = const TextStyle(fontSize: 16, color: Colors.black),
    this.hintText = '_',
    this.cursorColor,
  });

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  int selectedIndex = 0;
  late List<String?> otp;
  late List<FocusNode> focusNodes;
  late List<TextEditingController> textEditingControllers;

  @override
  void initState() {
    otp = List.generate(widget.length, (index) => null);
    focusNodes = List.generate(widget.length, (index) => FocusNode());
    textEditingControllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    super.initState();
  }

  @override
  void dispose() {
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    for (var textEditingController in textEditingControllers) {
      textEditingController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: widget.spacing,
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      mainAxisSize: widget.mainAxisSize,
      children: [
        for (int i = 0; i < widget.length; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            curve: Curves.fastEaseInToSlowEaseOut,
            width: widget.fieldWidth,
            height: widget.fieldHeight,
            decoration: selectedIndex == i
                ? widget.selectedFieldDecoration
                : widget.unselectedFieldDecoration,
            alignment: Alignment.center,
            child: TextFormField(
              controller: textEditingControllers[i],
              cursorColor: widget.cursorColor,
              enableInteractiveSelection: false,
              contextMenuBuilder: null,
              keyboardType: TextInputType.number,
              key: Key(i.toString()),
              autofocus: widget.autofocus && i == 0,
              textAlign: TextAlign.center,
              focusNode: focusNodes[i]
                ..onKeyEvent = (FocusNode node, KeyEvent event) {
                  if (event.logicalKey == LogicalKeyboardKey.backspace &&
                      event is KeyDownEvent) {
                    if (otp[i] == null) {
                      if (i != 0) FocusScope.of(context).previousFocus();
                      otp[i] = null;
                    }
                  }
                  return KeyEventResult.ignored;
                }
                ..addListener(() {
                  if (focusNodes[i].hasFocus) {
                    setState(() {
                      selectedIndex = i;
                    });
                    textEditingControllers[i].selection =
                        TextSelection.fromPosition(
                          TextPosition(
                            offset: textEditingControllers[i].text.length,
                          ),
                        );
                  } else if (!focusNodes[i].hasFocus && i == selectedIndex) {
                    setState(() {
                      selectedIndex = -1;
                    });
                  }
                }),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CustomizedLengthLimitingTextInputFormatter(
                  1,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                ),
              ],
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                  otp[i] = value;
                  if (i == widget.length - 1) {
                    String otpString = otp
                        .where((element) => element != null)
                        .join('');
                    if (otpString.length == widget.length &&
                        int.tryParse(otpString) != null) {
                      widget.onComplete?.call(otpString);
                    }
                  }
                } else {
                  otp[i] = null;
                }

                widget.onCancelled?.call(
                  otp.where((element) => element != null).join(''),
                );
              },
              style: widget.textStyle,
              decoration: InputDecoration.collapsed(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle,
              ),
            ),
          ),
      ],
    );
  }
}

class CustomizedLengthLimitingTextInputFormatter extends TextInputFormatter {
  CustomizedLengthLimitingTextInputFormatter(
    this.maxLength, {
    this.maxLengthEnforcement,
  }) : assert(maxLength == null || maxLength == -1 || maxLength > 0);
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  static MaxLengthEnforcement getDefaultMaxLengthEnforcement([
    TargetPlatform? platform,
  ]) {
    if (kIsWeb) {
      return MaxLengthEnforcement.truncateAfterCompositionEnds;
    } else {
      switch (platform ?? defaultTargetPlatform) {
        case TargetPlatform.android:
        case TargetPlatform.windows:
          return MaxLengthEnforcement.enforced;
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
        case TargetPlatform.linux:
        case TargetPlatform.fuchsia:
          return MaxLengthEnforcement.truncateAfterCompositionEnds;
      }
    }
  }

  @visibleForTesting
  static TextEditingValue truncate(TextEditingValue value, int maxLength) {
    final CharacterRange iterator = CharacterRange(value.text);
    if (value.text.characters.length > maxLength) {
      iterator.expandNext(maxLength);
    }
    for (int i = 0; i < maxLength; i++) {
      iterator.moveNext();
    }
    final String truncated = iterator.current;

    return TextEditingValue(
      text: truncated,
      selection: value.selection.copyWith(
        baseOffset: math.min(value.selection.start, truncated.length),
        extentOffset: math.min(value.selection.end, truncated.length),
      ),
      composing:
          !value.composing.isCollapsed &&
              truncated.length > value.composing.start
          ? TextRange(
              start: value.composing.start,
              end: math.min(value.composing.end, truncated.length),
            )
          : TextRange.empty,
    );
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int? maxLength = this.maxLength;

    if (maxLength == null ||
        maxLength == -1 ||
        newValue.text.characters.length <= maxLength) {
      return newValue;
    }

    assert(maxLength > 0);

    switch (maxLengthEnforcement ?? getDefaultMaxLengthEnforcement()) {
      case MaxLengthEnforcement.none:
        return newValue;
      case MaxLengthEnforcement.enforced:
        if (oldValue.text.characters.length == maxLength &&
            oldValue.selection.isCollapsed) {
          return truncate(newValue, maxLength);
        }
        return truncate(newValue, maxLength);
      case MaxLengthEnforcement.truncateAfterCompositionEnds:
        if (oldValue.text.characters.length == maxLength &&
            !oldValue.composing.isValid) {
          return truncate(newValue, maxLength);
        }
        if (newValue.composing.isValid) {
          return truncate(newValue, maxLength);
        }
        return truncate(newValue, maxLength);
    }
  }
}
