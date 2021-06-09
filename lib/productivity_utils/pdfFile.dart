import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart';

class PdfFile {
  static Future<File> generate(List<List> data) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
        build: (context) => [
          pdfTitle(),
          productivityTable(data)
        ]),
    );

    return saveDocument(
        name: 'hh_productivity_data.pdf',
        pdf: pdf
    );
  }

    static Future<File> saveDocument({
      required String name,
      required Document pdf,
    }) async {
      final bytes = await pdf.save();

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$name');

      await file.writeAsBytes(bytes);

      return file;
    }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static Widget productivityTable(List<List> pdfData) {
    return Table.fromTextArray(
      headerStyle: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.white),
        headerDecoration: BoxDecoration(color: PdfColors.blueGrey),
        border: null,
        cellHeight: 30,
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.center,
          2: Alignment.center,
        },
        headers: [
          '',
          'Work Amount',
          'Work Finished'
        ],
      data: pdfData

    );
  }

  static Widget pdfTitle() {
    return Column(
        children: [
          Text(
              'Productivity Data for ${DateFormat('MMMM').format(DateTime.now())}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: PdfColor.fromHex('#616161'),
              )
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm)
        ]
    );
  }


}
