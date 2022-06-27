part of linio;

class LinioCommandRunner extends CommandRunner<List<String>> {
  LinioCommandRunner(String executableName, String description) : super(executableName, description);

  @override
  void printUsage() {}
}
