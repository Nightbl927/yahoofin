// https://query1.finance.yahoo.com/v8/finance/chart/tsla?interval=1d&range=1mo

import 'package:equatable/equatable.dart';

class ChartQuotes {
  ChartQuotes({
    this.open,
    this.low,
    this.close,
    this.volume,
    this.high,
    this.timestamp,
  });

  List<num>? open;
  List<num>? low;
  List<num>? close;
  List<num>? volume;
  List<num>? high;
  List<num>? timestamp;

  factory ChartQuotes.fromJson(dynamic timestamp, Map<String, dynamic> json) {
    List<dynamic> openList = json["open"];
    openList.removeWhere((element) => element == null);
    List<double> openListInt = openList.cast<double>();

    List<dynamic> lowList = json["low"];
    lowList.removeWhere((element) => element == null);
    List<double> lowListInt = lowList.cast<double>();

    List<dynamic> closeList = json["close"];
    closeList.removeWhere((element) => element == null);
    List<double> closeListInt = closeList.cast<double>();

    List<dynamic> volumeList = json["volume"];
    volumeList.removeWhere((element) => element == null);
    List<double> volumeListInt = volumeList.cast<double>();

    List<dynamic> highList = json["high"];
    highList.removeWhere((element) => element == null);
    List<double> highListInt = highList.cast<double>();

    return ChartQuotes(
      timestamp: List<int>.from(timestamp),
      open: openListInt,
      low: lowListInt,
      close: closeListInt,
      volume: volumeListInt,
      high: highListInt,
    );
  }
}

class StockChart extends Equatable {
  final String? ticker;
  final int? mode;
  // mode 0 means only chartQuotes is initialized
  // mode 1 means only adjustedClose is initialized
  // mode 2 means both are initialized


  final ChartQuotes? chartQuotes;


  StockChart({this.ticker, this.chartQuotes, this.mode});

  // Will take in result.

  /// Returns StockChart with chartQuotes filled.
  /// [chartQuotes] contain high, low, open, close and volume.
  factory StockChart.fromJsonGetChart(
    Map<String, dynamic> json,
  ) {
    //print();
    return StockChart(
      chartQuotes: ChartQuotes.fromJson(json["timestamp"],json["indicators"]["quote"][0]),
      mode: 0,
      ticker: json["meta"]["symbol"],
    );
  }

  @override
  List<Object?> get props => [mode, ticker];
}
