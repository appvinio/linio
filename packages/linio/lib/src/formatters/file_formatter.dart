part of linio;

class FileLinioFormatter implements LinioFormatter {
  @override
  List<String> format(dynamic log) {
    final File file = log;
    return [
      'File name: ${file.absolute.path}',
      'File exists: ${file.existsSync()}',
      'File size: ${file.lengthSync()}',
      'File last accessed: ${file.lastAccessedSync().toIso8601String()}',
      'File last modified: ${file.lastModifiedSync().toIso8601String()}',
    ];
  }

  @override
  bool handleLog(dynamic log) => log is File;
}
