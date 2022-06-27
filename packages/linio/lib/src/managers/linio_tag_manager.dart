part of linio;

class LinioTagManager {
  final List<String> allowList = ['all'];
  final List<String> blockList = [];

  void allow(String tag) {
    blockList.remove(tag);
    if (tag == 'all') {
      allowList.clear();
      blockList.clear();
      allowList.add(tag);
    } else if (!allowList.contains(tag)) {
      allowList.add(tag);
    }
  }

  void block(String tag) {
    allowList.remove(tag);
    if (tag == 'all') {
      allowList.clear();
      blockList.clear();
      blockList.add(tag);
    } else if (!blockList.contains(tag)) {
      blockList.add(tag);
    }
  }

  bool shouldLog(LinioOptions options) {
    if (options.tag.isEmpty) {
      return true;
    }
    if (blockList.contains('all')) {
      return allowList.contains(options.tag);
    } else {
      return !blockList.contains(options.tag);
    }
  }
}
