# Linio
Linio is high customisable logger for dart and flutter.

## Getting Started

##### Add  `fimber`  to  `pubspec.yaml`
```
  dependencies:
    fimber: ^0.0.1
```
```
  import 'package:linio/linio.dart';
```


## Customisation

```
factory Linio.custom({
  List<LinioPrinter> printers = const [],
  List<LinioFormatter> formatters = const [SimpleLinioFormatter()],
  List<LinioHeaderFooter> headers = const [],
  List<LinioCommand> manipulators = const [],
  List<LinioFilter> filters = const [],
  String name = 'main'
})
```
## Logs possibilites

#### Simple logs
`Linio.log('some log'); // some log`
`Linio.log('some log'); // TAG test`

#### Headers & Footers
Linio has build in few type header. You can create your own.

 - DateTime 	`Linio.log('log'); // 2020-01-01T00:00:00.000 log`
 - Uptime 		`Linio.log('log'); // 10.000 log`
 - Tag			`Linio.log('TAG', 'log'); // TAG log`