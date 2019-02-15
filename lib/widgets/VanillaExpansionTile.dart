import 'package:flutter/material.dart';

class VanillaExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final initiallyExpand;

  const VanillaExpansionTile({
    Key key,
    this.title,
    this.children,
    this.initiallyExpand,
  }) : super(key: key);

  @override
  _VanillaExpansionTileState createState() => _VanillaExpansionTileState();
}

class _VanillaExpansionTileState extends State<VanillaExpansionTile> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpand;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: _handleTap,
          child: widget.title,
        )
      ]..addAll(_isExpanded ? widget.children : []),
    );
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}
