
# Linio
Linio is high customisable logger for dart and flutter.

## Getting Started

##### Add  `linio`  to  `pubspec.yaml`
```  
 dependencies: linio: ^0.0.1
 
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
`Linio.log('some_tag', 'some log'); // some_tag some log`

#### Headers & Footers
Linio has built in few type header. You can create your own.
##### `TagLinioHeader`

```  
factory Linio.custom({  
	... 
	headers = const [TagLinioHeader()], 
	...
})  
```

Output:  
`Linio.log('TAG', 'log'); // TAG log`

##### `DateTimeLinioHeader`

```  
factory Linio.custom({  
  ...  
  headers = const [DateTimeLinioHeader()],  
  ...  
})  
```  

You can also provide your own date provider


```  
factory Linio.custom({  
  ...  
  headers = const [DateTimeLinioHeader(dateTimeProvider: OwnDateTimeProvider()],  
  ...  
})  
```

Output:  
`Linio.log('log'); // 2020-01-01T00:00:00.000 log`


##### `UptimeLinioHeader`

```  
factory Linio.custom({  
	...
	headers = const [UptimeLinioHeader()], 
	...
})  
```  

You can also provide your own date provider

```  
factory Linio.custom({  
	... 
	headers = const [UptimeLinioHeader(dateTimeProvider: OwnDateTimeProvider()], 		
	...
})  
```

Output:  
`Linio.log('log'); // 10.000 log`