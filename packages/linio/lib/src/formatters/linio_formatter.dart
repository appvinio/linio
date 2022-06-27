part of linio;

abstract class LinioFormatter<T> {
  List<String> format(T log);

  bool handleLog(T log);
}
