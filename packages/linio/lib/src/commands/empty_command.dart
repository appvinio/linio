part of linio;

class EmptyCommand extends LinioCommand {
  @override
  String get description => 'Empty';

  @override
  String get name => '';

  run() => [];
}
