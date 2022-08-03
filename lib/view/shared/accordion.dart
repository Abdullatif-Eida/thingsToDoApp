import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  final Widget title;
  final Widget content;

  const Accordion({Key? key, required this.title, required this.content})
      : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        child: _showContent ? Container() : widget.title,
        onTap: () {
          setState(() {
            _showContent = !_showContent;
          });
        },
      ),
      _showContent
          ? GestureDetector(
              child: widget.content,
              onTap: () {
                setState(() {
                  _showContent = !_showContent;
                });
              },
            )
          : Container()
    ]);
  }
}
