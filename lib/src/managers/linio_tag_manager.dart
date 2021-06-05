part of linio;

class LinioTagManager {
  final List<String> allowList = ['all'];
  final List<String> blockList = [];

  void allow(String tag) {
    blockList.remove(tag);
    if (!allowList.contains(tag)) {
      allowList.add(tag);
    }
  }

  void block(String tag) {
    allowList.remove(tag);
    if (!blockList.contains(tag)) {
      blockList.add(tag);
    }
  }

  bool shouldLog(String tag) {
    if (blockList.contains('all')) {
      return allowList.contains(tag);
    } else {
      return !blockList.contains(tag);
    }
  }
}