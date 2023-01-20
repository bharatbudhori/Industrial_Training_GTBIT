import 'package:easy_stepper/easy_stepper.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfApp extends StatelessWidget {
  const PdfApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SfPdfViewer.asset('assets/mappp.pdf'));
  }
}
