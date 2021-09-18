part of linio;

class TagLinioHeader extends LinioHeaderFooter {
  @override
  String prepareHeader(ArgResults command, String log, LinioOptions options) {
    return "${options.tag.isNotEmpty ? '${options.tag} ' : ''}$log";
  }
}
