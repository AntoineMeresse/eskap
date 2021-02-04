import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/escapeFilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EskapFilter extends StatefulWidget {
  final RangeValues currentRangeValues;
  final setCurrentRangeValues;

  EskapFilter({Key key, this.currentRangeValues, this.setCurrentRangeValues})
      : super(key: key);
  @override
  _EskapFilterState createState() => _EskapFilterState();
}

class _EskapFilterState extends State<EskapFilter> {
  RangeValues _currentRangeValues = RangeValues(0, 100);
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder<EskapBloc, EskapState>(builder: (context, state) {
      if (state is EskapSuccess) {
        return insideBlocBuilder();
      }
      return Center(child: Text("Data not loaded yet"));
    }));
  }

  Widget insideBlocBuilder() {
    return Container(
      child: Column(
        children: [
          Text("Ville"),
          cityFilter(),
          divider(),
          Text(
              "Prix : ${_currentRangeValues.start.round()} - ${_currentRangeValues.end.round()} €"),
          priceRangeSlider(),
          divider(),
          filterButtons(),
        ],
      ),
    );
  }

  Widget divider() {
    return Divider(
      thickness: 3,
      height: 40,
    );
  }

  Widget cityFilter() {
    return Container(
      child: TextField(
        controller: cityController,
        decoration: InputDecoration(
          labelText: "Ville",
        ),
      ),
    );
  }

  Widget priceRangeSlider() {
    return RangeSlider(
      values: _currentRangeValues,
      min: 0,
      max: 100,
      divisions: 100,
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
        });
      },
    );
  }

  Widget filterButtons() {
    return TextButton(
      child: Text("Test"),
      onPressed: () {
        Filter filter = Filter(
          city: cityController.text.trim().toLowerCase(),
          minPrice: _currentRangeValues.start,
          maxPrice: _currentRangeValues.end,
        );
        BlocProvider.of<EskapBloc>(context).add(EskapFilterEvent(filter));
      },
    );
  }
}
