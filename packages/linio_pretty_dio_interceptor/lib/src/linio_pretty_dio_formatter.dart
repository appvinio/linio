import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:linio/linio.dart';

class LinioPrettyDioFormatter implements LinioFormatter {
  /// Print request [Options]
  final bool request;

  /// Print request header [Options.headers]
  final bool requestHeader;

  /// Print request data [Options.data]
  final bool requestBody;

  /// Print [Response.data]
  final bool responseBody;

  /// Print [Response.headers]
  final bool responseHeader;

  /// Print error message
  final bool error;

  /// InitialTab count to logs.add json response
  static const int initialTab = 1;

  /// 1 tab length
  static const String tabStep = '    ';

  /// Print compact json response
  final bool compact;

  /// Width size per logs.add
  final int maxWidth;

  LinioPrettyDioFormatter(
      {this.request = true,
      this.requestHeader = false,
      this.requestBody = false,
      this.responseHeader = false,
      this.responseBody = true,
      this.error = true,
      this.maxWidth = 90,
      this.compact = true});

  @override
  bool handleLog(log) {
    return log is RequestOptions || log is Response || log is DioError;
  }

  @override
  List<String> format(log) {
    switch (log.runtimeType) {
      case RequestOptions:
        return onRequest(log);
      case Response:
        return onResponse(log);
      case DioError:
        return onError(log);
      default:
        return [];
    }
  }

  List<String> onRequest(RequestOptions options) {
    final logs = <String>[];
    if (request) {
      logs.addAll(_printRequestHeader(options));
    }
    if (requestHeader) {
      logs.addAll(_printMapAsTable(options.queryParameters, header: 'Query Parameters'));
      final requestHeaders = {};
      requestHeaders.addAll(options.headers);
      requestHeaders['contentType'] = options.contentType?.toString();
      requestHeaders['responseType'] = options.responseType.toString();
      requestHeaders['followRedirects'] = options.followRedirects;
      requestHeaders['connectTimeout'] = options.connectTimeout;
      requestHeaders['receiveTimeout'] = options.receiveTimeout;
      logs.addAll(_printMapAsTable(requestHeaders, header: 'Headers'));
      logs.addAll(_printMapAsTable(options.extra, header: 'Extras'));
    }
    if (requestBody && options.method != 'GET') {
      final data = options.data;
      if (data != null) {
        if (data is Map) _printMapAsTable(options.data, header: 'Body');
        if (data is FormData) {
          final formDataMap = {}
            ..addEntries(data.fields)
            ..addEntries(data.files);
          logs.addAll(_printMapAsTable(formDataMap, header: 'Form data | ${data.boundary}'));
        } else {
          logs.addAll(_printBlock(data.toString()));
        }
      }
    }

    return logs;
  }

  List<String> onError(DioError err) {
    final logs = <String>[];
    if (error) {
      if (err.type == DioErrorType.response) {
        final uri = err.response?.requestOptions.uri;
        logs.addAll(_printBoxed(
            header: 'DioError ║ Status: ${err.response?.statusCode} ${err.response?.statusMessage}',
            text: uri.toString()));
        if (err.response != null && err.response?.data != null) {
          logs.add('╔ ${err.type.toString()}');
          logs.addAll(_printResponse(err.response!));
        }
        logs.add(_printLine('╚'));
        logs.add('');
      } else {
        logs.addAll(_printBoxed(header: 'DioError ║ ${err.type}', text: err.message));
      }
    }
    return logs;
  }

  List<String> onResponse(Response response) {
    final logs = <String>[];
    logs.addAll(_printResponseHeader(response));
    if (responseHeader) {
      final responseHeaders = <String, String>{};
      response.headers.forEach((k, list) => responseHeaders[k] = list.toString());
      logs.addAll(_printMapAsTable(responseHeaders, header: 'Headers'));
    }

    if (responseBody) {
      logs.add('╔ Body');
      logs.add('║');
      logs.addAll(_printResponse(response));
      logs.add('║');
      logs.add(_printLine('╚'));
    }
    return logs;
  }

  List<String> _printBoxed({required String header, required String text}) {
    final logs = <String>[];
    logs.add('');
    logs.add('╔╣ $header');
    logs.add('║  $text');
    logs.add(_printLine('╚'));
    return logs;
  }

  List<String> _printResponse(Response response) {
    final logs = <String>[];
    if (response.data != null) {
      if (response.data is Map) {
        logs.addAll(_printPrettyMap(response.data));
      } else if (response.data is List) {
        logs.add('║${_indent()}[');
        logs.addAll(_printList(response.data));
        logs.add('║${_indent()}[');
      } else {
        logs.addAll(_printBlock(response.data.toString()));
      }
    }
    return logs;
  }

  List<String> _printResponseHeader(Response response) {
    final logs = <String>[];
    final uri = response.requestOptions.uri;
    final method = response.requestOptions.method;
    logs.addAll(_printBoxed(
        header: 'Response ║ $method ║ Status: ${response.statusCode} ${response.statusMessage}', text: uri.toString()));
    return logs;
  }

  List<String> _printRequestHeader(RequestOptions options) {
    final logs = <String>[];
    final uri = options.uri;
    final method = options.method;
    logs.addAll(_printBoxed(header: 'Request ║ $method ', text: uri.toString()));
    return logs;
  }

  String _printLine([String pre = '']) => '$pre${'═' * maxWidth}';

  List<String> _printKV(String key, Object? v) {
    final logs = <String>[];
    final pre = '╟ $key: ';
    final msg = v.toString();

    if (pre.length + msg.length > maxWidth) {
      logs.add(pre);
      logs.addAll(_printBlock(msg));
    } else {
      logs.add('$pre$msg');
    }
    return logs;
  }

  List<String> _printBlock(String msg) {
    final logs = <String>[];
    final lines = (msg.length / maxWidth).ceil();
    for (var i = 0; i < lines; ++i) {
      logs.add((i >= 0 ? '║ ' : '') + msg.substring(i * maxWidth, math.min<int>(i * maxWidth + maxWidth, msg.length)));
    }
    return logs;
  }

  String _indent([int tabCount = initialTab]) => tabStep * tabCount;

  List<String> _printPrettyMap(Map data, {int tabs = initialTab, bool isListItem = false, bool isLast = false}) {
    var logs = <String>[];
    final isRoot = tabs == initialTab;
    final initialIndent = _indent(tabs);
    tabs++;

    if (isRoot || isListItem) logs.add('║$initialIndent{');

    data.keys.toList().asMap().forEach((index, key) {
      final isLast = index == data.length - 1;
      var value = data[key];
      if (value is String) {
        value = '\"${value.toString().replaceAll(RegExp(r'(\r|\n)+'), " ")}\"';
      }
      if (value is Map) {
        if (compact && _canFlattenMap(value)) {
          logs.add('║${_indent(tabs)} $key: $value${!isLast ? ',' : ''}');
        } else {
          logs.add('║${_indent(tabs)} $key: {');
          logs.addAll(_printPrettyMap(value, tabs: tabs));
        }
      } else if (value is List) {
        if (compact && _canFlattenList(value)) {
          logs.add('║${_indent(tabs)} $key: ${value.toString()}');
        } else {
          logs.add('║${_indent(tabs)} $key: [');
          logs.addAll(_printList(value, tabs: tabs));
          logs.add('║${_indent(tabs)} ]${isLast ? '' : ','}');
        }
      } else {
        final msg = value.toString().replaceAll('\n', '');
        final indent = _indent(tabs);
        final linWidth = maxWidth - indent.length;
        if (msg.length + indent.length > linWidth) {
          final lines = (msg.length / linWidth).ceil();
          for (var i = 0; i < lines; ++i) {
            logs.add(
                '║${_indent(tabs)} ${msg.substring(i * linWidth, math.min<int>(i * linWidth + linWidth, msg.length))}');
          }
        } else {
          logs.add('║${_indent(tabs)} $key: $msg${!isLast ? ',' : ''}');
        }
      }
    });

    logs.add('║$initialIndent}${isListItem && !isLast ? ',' : ''}');
    return logs;
  }

  List<String> _printList(List list, {int tabs = initialTab}) {
    var logs = <String>[];
    list.asMap().forEach((i, e) {
      final isLast = i == list.length - 1;
      if (e is Map) {
        if (compact && _canFlattenMap(e)) {
          logs.add('║${_indent(tabs)}  $e${!isLast ? ',' : ''}');
        } else {
          logs.addAll(_printPrettyMap(e, tabs: tabs + 1, isListItem: true, isLast: isLast));
        }
      } else {
        logs.add('║${_indent(tabs + 2)} $e${isLast ? '' : ','}');
      }
    });
    return logs;
  }

  bool _canFlattenMap(Map map) {
    return map.values.where((val) => val is Map || val is List).isEmpty && map.toString().length < maxWidth;
  }

  bool _canFlattenList(List list) {
    return (list.length < 10 && list.toString().length < maxWidth);
  }

  List<String> _printMapAsTable(Map map, {required String header}) {
    final logs = <String>[];
    if (map.isEmpty) return [];
    logs.add('╔ $header ');
    map.forEach((key, value) => logs.addAll(_printKV(key, value)));
    logs.add(_printLine('╚'));
    return logs;
  }
}
