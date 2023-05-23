import 'dart:io';
class ResponsePDF{
  ResponsePDF(this.estado, this.pdf);
  final bool estado;
  final File pdf;
}