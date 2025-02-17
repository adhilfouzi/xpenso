import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ActionButtons(
      {super.key, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _buildButton(
              onTap: onDelete,
              icon: Icons.delete_outline,
              text: "Delete",
              colors: [Colors.red.shade700, Colors.red.shade400],
            ),
          ),
          Expanded(
            child: _buildButton(
              onTap: onEdit,
              icon: Icons.edit,
              text: "Edit",
              colors: [Colors.blue.shade700, Colors.blue.shade400],
            ),
          ),
        ],
      ),
    );
  }

  // Gradient Button Widget
  Widget _buildButton({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
    required List<Color> colors,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: colors.first.withAlpha((0.4 * 255).toInt()),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
