import 'dart:async';

import 'package:flutter/material.dart';

class CustomLabelList extends StatelessWidget {
  // [{name, iconID, iconFamily},{...},...]
  final List<dynamic> labelList;
  final Color? labelColor;
  final bool hasBorder;

  final bool hasText;
  final TextStyle? labelTextStyle;

  final bool hasIcon;
  final double iconSize;
  final bool leadingIcon;

  final bool hasTooltip;
  late final List<GlobalKey<TooltipState>>? tooltipKeys;

  final double listSpacing;
  final double listRunSpacing;
  final VoidCallback? onLabelTap;

  CustomLabelList(
      {super.key,
      required this.labelList,
      this.labelColor,
      this.hasBorder = false,
      this.hasText = true,
      this.hasIcon = false,
      this.iconSize = 25,
      this.leadingIcon = true,
      this.hasTooltip = false,
      this.labelTextStyle,
      this.tooltipKeys,
      this.listSpacing = 30,
      this.listRunSpacing = 20,
      this.onLabelTap});

  @override
  Widget build(BuildContext context) {
    final generalProps = {
      'labelList': labelList,
      'leadingIcon': leadingIcon,
      'hasIcon': hasIcon,
      'iconSize': iconSize,
      'hasText': hasText,
      'labelTextStyle': labelTextStyle,
      'labelColor': labelColor,
      'hasBorder': hasBorder,
      'onLabelTap': onLabelTap
    };
    return SizedBox(
        width: double.infinity,
        child: Wrap(
            alignment: WrapAlignment.center,
            spacing: listSpacing,
            runSpacing: listRunSpacing,
            children: hasTooltip
                ? _addTooltip(tooltipKeys, generalProps)
                : _addContent(generalProps)));
  }
}

void _onTapDown(GlobalKey<TooltipState> tooltipkey) async {
  tooltipkey.currentState?.activate();
  tooltipkey.currentState?.ensureTooltipVisible();
}

void _onTapUpAndCancel(GlobalKey<TooltipState> tooltipkey) {
  tooltipkey.currentState?.ensureTooltipVisible();
  Timer(Duration(seconds: 1), () {
    tooltipkey.currentState?.deactivate();
  });
}

_addTooltip(tooltipKeys, Map generalProps) {
  if (tooltipKeys == null ||
      tooltipKeys?.length != generalProps['labelList'].length) {
    tooltipKeys = List.generate(
        generalProps['labelList'].length, (index) => GlobalKey<TooltipState>());
  }
  return <Widget>[
    for (var i = 0; i < generalProps['labelList'].length; i++)
      Container(
        child: Tooltip(
          key: tooltipKeys![i],
          message: generalProps['labelList'][i]['name'] ?? '',
          triggerMode: TooltipTriggerMode.manual,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (_) => _onTapDown(tooltipKeys![i]), // add this
            onTapUp: (_) => _onTapUpAndCancel(tooltipKeys![i]), // add this
            onTapCancel: () => _onTapUpAndCancel(tooltipKeys![i]), // add this
            child: _content(i, generalProps),
          ),
        ),
      )
  ];
}

_addContent(Map generalProps) {
  return <Widget>[
    for (var i = 0; i < generalProps['labelList'].length; i++)
      _content(i, generalProps)
  ];
}

_content(int i, Map generalProps) {
  return Container(
    padding: generalProps['hasText']
        ? EdgeInsets.fromLTRB(generalProps['hasIcon'] ? 5 : 15, 5, 15, 5)
        : null,
    margin: EdgeInsets.all(0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: generalProps['labelColor'],
      border: generalProps['hasBorder'] ? Border.all() : null,
    ),
    child: GestureDetector(
      onTap: () {
        if (generalProps['onLabelTap'] != null) {
          generalProps['onLabelTap']();
        }
      },
      child: Text.rich(
        TextSpan(
          style: generalProps['labelTextStyle'],
          children: [
            generalProps['hasText']
                ? (generalProps['leadingIcon']
                    ? TextSpan(text: '')
                    : TextSpan(
                        text: generalProps['hasIcon']
                            ? generalProps['labelList'][i]['name']
                            : generalProps['labelList'][i],
                      ))
                : TextSpan(text: ''),
            generalProps['hasIcon']
                ? WidgetSpan(
                    child: Container(
                      padding: generalProps['hasText']
                          ? EdgeInsets.fromLTRB(10, 0, 10, 0)
                          : null,
                      child: Icon(
                        IconData(
                          generalProps['labelList'][i]['iconID'],
                          fontFamily: generalProps['labelList'][i][
                              'iconFamily'], //'FontAwesomeSolid' or ''MaterialIcons'',
                          fontPackage: generalProps['labelList'][i]
                                      ['iconFamily'] ==
                                  'FontAwesomeSolid'
                              ? 'font_awesome_flutter'
                              : null,
                        ),
                        size: generalProps['iconSize'],
                      ),
                    ),
                  )
                : TextSpan(text: ''),
            generalProps['hasText']
                ? (generalProps['leadingIcon']
                    ? TextSpan(
                        text: generalProps['hasIcon']
                            ? generalProps['labelList'][i]['name']
                            : generalProps['labelList'][i],
                      )
                    : TextSpan(text: ''))
                : TextSpan(text: ''),
          ],
        ),
      ),
    ),
  );
}
