import 'package:flutter/material.dart';

class PieItemTaskCard extends StatefulWidget {
  final List<Widget> _children;
  final String _label;
  final Function()? onDelete;

  const PieItemTaskCard(
      {super.key,
      this.onDelete,
      required List<Widget> children,
      required String label})
      : _children = children,
        _label = label;

  @override
  State<PieItemTaskCard> createState() => _PieItemTaskCardState();
}

class _PieItemTaskCardState extends State<PieItemTaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(widget._label),
            trailing: TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size(0, 0),
                padding: const EdgeInsets.all(12),
              ),

              onPressed: widget.onDelete,
              child: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 20,
              ),
            ),
            contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
          ),
          ...widget._children
        ],
      ),
    );
  }
}
