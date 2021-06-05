part of linio;

abstract class LinioFormatter {
  List<String> format(dynamic log);

  bool handleLog(dynamic log);
}