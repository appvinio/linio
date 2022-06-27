part of linio;

class LinioLevelManager {
  final List<LinioLogLevel> allowList = [...LinioLogLevel.values];
  final List<LinioLogLevel> blockList = [];

  void allow(LinioLogLevel tag) {
    blockList.remove(tag);
    if (!allowList.contains(tag)) {
      allowList.add(tag);
    }
  }

  void block(LinioLogLevel tag) {
    allowList.remove(tag);
    if (!blockList.contains(tag)) {
      blockList.add(tag);
    }
  }

  bool shouldLog(LinioLogLevel tag) {
    if (blockList.contains(tag)) {
      return allowList.contains(tag);
    } else {
      return !blockList.contains(tag);
    }
  }
}
