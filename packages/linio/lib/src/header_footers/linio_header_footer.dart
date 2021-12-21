part of linio;

abstract class LinioHeaderFooter {
  const LinioHeaderFooter();

  String prepareHeader(ArgResults command, String log, LinioOptions options);
}