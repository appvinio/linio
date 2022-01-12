part of linio;

class StopwatchCommand extends LinioCommand {
  final name = "stopwatch";
  final description = "Stopwatch";

  Map<String, Stopwatch> stopwatches = {};

  StopwatchCommand() {
    argParser.addOption('start', abbr: 's');
    argParser.addOption('end', abbr: 'e');
    argParser.addOption('loop', abbr: 'l');
  }

  run() {
    if (argResults != null) {
      if (argResults!.wasParsed('start')) {
        stopwatches.update(argResults!['start'], (value) => Stopwatch(),
            ifAbsent: () => Stopwatch());
        stopwatches.update(
            '${argResults!['start']}loop', (value) => Stopwatch(),
            ifAbsent: () => Stopwatch());
        stopwatches[argResults!['start']]!.start();
        stopwatches['${argResults!['start']}loop']!.start();
        return ['Stopwatch started [${argResults!['start']}]'];
      } else if (argResults!.wasParsed('loop')) {
        final elapsed = stopwatches['${argResults!['loop']}loop']!.elapsed;
        stopwatches['${argResults!['loop']}loop']!.reset();
        return ['Stopwatch loop [${argResults!['loop']}] $elapsed'];
      } else if (argResults!.wasParsed('end')) {
        final elapsed = stopwatches[argResults!['end']]!.elapsed;
        stopwatches[argResults!['end']]!.stop();
        stopwatches['${argResults!['end']}loop']!.stop();
        return ['Stopwatch stopped [${argResults!['end']}] $elapsed'];
      }
    }
    return <String>[];
  }
}