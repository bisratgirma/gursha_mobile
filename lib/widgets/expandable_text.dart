import 'package:flutter/material.dart';
import 'package:gursha/util/colors.dart';
import 'package:gursha/util/dimensions.dart';
import 'package:gursha/widgets/small_heading.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstPart;
  late String secondPart;
  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.61;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstPart = widget.text.substring(0, textHeight.toInt());
      secondPart =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstPart = widget.text;
      secondPart = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: secondPart.isEmpty
            ? SmallHeadingText(
                text: firstPart,
              )
            : Column(
                children: [
                  SmallHeadingText(
                      text: hiddenText
                          ? (firstPart + '...')
                          : (firstPart + secondPart)),
                  InkWell(
                    onTap: () => setState(() {
                      hiddenText = !hiddenText;
                    }),
                    child: Row(children: [
                      SmallHeadingText(
                        text: 'show ${hiddenText ? 'more' : 'less'}',
                        color: AppColors.mainColor,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      )
                    ]),
                  )
                ],
              ),
      ),
    );
  }
}