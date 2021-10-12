
# Linio
Linio is high customisable logger for dart and flutter.

## Getting Started

##### Init `linio`
###### Add to dependencies
```yaml
  dependencies: 
    linio: ^0.0.3
```  
###### Init
```dart
  Linio.init();
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

`L.log('some log'); // some log`  
`L.log('some_tag', 'some log'); // some_tag some log`

#### Headers & Footers
Linio has built in few type header. You can also create your own.
##### `TagLinioHeader`

```  
factory Linio.custom({  
	... 
	headers = const [TagLinioHeader()], 
	...
})  
```

Output:  
`L.log('TAG', 'log'); // TAG log`

##### `AvoidFlutterHeader`
With standard print all of logs have prefix `flutter:`
With `AvoidFlutterHeader` header this prefix will be removed
```  
factory Linio.custom({  
	... 
	headers = const [AvoidFlutterHeader()], 
	...
})  
```

Output:  
`L.log('log'); // log`

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
`L.log('log'); // 2020-01-01T00:00:00.000 log`


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
`L.log('log'); // 10.000 log`