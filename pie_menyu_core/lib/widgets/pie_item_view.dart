import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';

enum PieItemOffset { toRight, toLeft, center }

class PieItemView extends StatefulWidget {
  final PieItemOffset horizontalOffset;
  final PieMenuIcon icon;
  final PieMenuFont font;
  final PieMenuColors colors;
  final PieMenuShape shape;
  final PieItemDelegate instance;
  final bool active;

  const PieItemView({
    super.key,
    this.horizontalOffset = PieItemOffset.toRight,
    required this.icon,
    required this.font,
    required this.colors,
    required this.shape,
    required this.instance,
    required this.active,
  });

  @override
  State<PieItemView> createState() => _PieItemViewState();
}

class _PieItemViewState extends State<PieItemView> {
  Image? imageIcon;
  String imageIconBase64 = "";

  @override
  Widget build(BuildContext context) {
    final pieItem = widget.instance.pieItem;

    if (pieItem == null) throw Exception("PieItem is null");

    if (imageIconBase64 != pieItem.iconBase64) {
      imageIconBase64 = pieItem.iconBase64;
      imageIcon = null;
    }

    imageIcon ??= Image.memory(
      base64Decode(pieItem.iconBase64),
      width: widget.icon.size + 5,
      alignment: Alignment.centerLeft,
      height: widget.icon.size,
      fit: BoxFit.fitHeight,
      isAntiAlias: true,
      errorBuilder: (context, object, error) {
        return const SizedBox(width: 0, height: 0);
      },
    );

    return Container(
      height: widget.icon.size,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius:
            BorderRadius.circular(widget.shape.pieItemRoundness),
        color: Color(widget.active
            ? widget.colors.primary
            : widget.colors.secondary),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          imageIcon!,
          Text(
            pieItem.name,
            style: GoogleFonts.getFont(widget.font.fontFamily,
                color: Color(widget.font.color),
                fontSize: widget.font.size),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                widget.instance.keyCode == "" ? 0 : 6, 0, 0, 0),
            child: Text(
              widget.instance.keyCode,
              style: GoogleFonts.getFont(widget.font.fontFamily,
                  color: Color(widget.font.color),
                  fontSize: widget.font.size),
            ),
          ),
        ],
      ),
    );
  }
}
