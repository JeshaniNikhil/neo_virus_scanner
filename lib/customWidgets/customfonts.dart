import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customfonts extends StatefulWidget {
  const Customfonts(
      {super.key,
      required this.title,
      required this.color,
      required this.fontsize,
      required this.fontWeight});
  final double fontsize;
  final String title;
  final FontWeight fontWeight;
  final Color color;
  @override
  State<Customfonts> createState() => _CustomfontsState();
}

class _CustomfontsState extends State<Customfonts> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: GoogleFonts.inter(
          color: widget.color,
          fontWeight: widget.fontWeight,
          fontSize: widget.fontsize),
    );
  }
}

