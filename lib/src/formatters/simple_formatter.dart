part of linio;

class SimpleLinioFormatter implements LinioFormatter {
  const SimpleLinioFormatter();

  @override
  List<String> format(dynamic log) => log != null ? [log.toString()] : [];

  @override
  bool handleLog(dynamic log) => true;
}