import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_forex_app/bloc/candles_bloc.dart';
import 'package:flutter_forex_app/model/candles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PriceEurUsd extends StatefulWidget {
  @override
  _PriceEurUsdState createState() => _PriceEurUsdState();
}

class _PriceEurUsdState extends State<PriceEurUsd> {
  String selectedGranularity = '5S';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CandlesBloc()
        ..add(
          CandlesEventStated('EUR_USD', 'S5'),
        ),
      child: Container(
        child: BlocBuilder<CandlesBloc, CandlesState>(
          builder: (context, state) {
            if (state is CandlesLoading) {
              return Center(
                child: Platform.isAndroid
                    ? CircularProgressIndicator()
                    : CupertinoActivityIndicator(),
              ); // Center
            } else if (state is CandlesLoaded) {
              Candles candles = state.candles;
              final List<CandleData> candleData = [];
              int index = 0;
              for (Candle candle in candles.candles) {
                candleData.add(
                  CandleData(
                    index: '${index++}',
                    ask: double.parse(candle.candleItem.close),
                  ), // CandleData
                );
              }
              return Column(
                children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    height: 260,
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: SfCartesianChart(
                        backgroundColor: Colors.transparent,
                        title: ChartTitle(
                          text: 'Euro / U.S. Dollar',
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ), // TextStyle
                        ), // ChartTitle
                        primaryXAxis: CategoryAxis(
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ), // TextStyle
                        ), // CategoryAxis
                        primaryYAxis: NumericAxis(
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ), // TextStyle
                        ), // NumericAxis
                        series: <ChartSeries<CandleData, String>>[
                          SplineSeries(
                            color: Colors.red[500],
                            width: 6,
                            dataSource: candleData,
                            xValueMapper: (CandleData c, _) => c.index,
                            yValueMapper: (CandleData c, _) => c.ask,
                            animationDuration: 6500,
                          ), // SplineSeries
                        ], // <ChartSeries<CandleData, String>>[]
                      ), // SfCartesianChart
                    ), // Card
                  ), // Container
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        selectGranularity(context, '5S', 'S5'),
                        selectGranularity(context, '15S', 'S15'),
                        selectGranularity(context, '30S', 'S30'),
                        selectGranularity(context, '1M', 'M1'),
                        selectGranularity(context, '15M', 'M15'),
                        selectGranularity(context, '30M', 'M30'),
                      ], // <Widget>[]
                    ), // Row
                  ), // Container
                ], // <Widget> []
              ); // Column
            } else {
              return Container();
            }
          },
        ), // BlocBuilder
      ), // Container
    ); // BlocProvider
  }

  Widget selectGranularity(BuildContext context, String title, String gran) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedGranularity = title;
          context.read<CandlesBloc>()
            ..add(
              CandlesEventStated('EUR_USD', gran),
            );
        });
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: (selectedGranularity == title)
              ? Border.all(
                  color: Colors.red[500],
                ) // Border.all
              : null,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ), // BorderRadius.all
        ), // BoxDecoration
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black54,
          ), // TextStyle
        ), // Text
      ), // Container
    ); // InkWell
  }
}

class CandleData {
  final String index;
  final double ask;

  CandleData({this.index, this.ask});
}
