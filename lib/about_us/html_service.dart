import 'package:html/parser.dart';

class HtmlService {
  static String parseHtml({String? content}) {
    final document = parse(content); //to remove html tags from strings
    final String parsedContent =
        parse(document.body!.text).documentElement!.text;
    return parsedContent;
  }
}
