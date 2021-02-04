import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EskapFilter extends StatefulWidget {
  final Filter filter;
  final setCurrentFilter;

  EskapFilter({Key key, this.filter, this.setCurrentFilter}) : super(key: key);
  @override
  _EskapFilterState createState() => _EskapFilterState();
}

class _EskapFilterState extends State<EskapFilter> {
  RangeValues _currentRangeValues = RangeValues(0, 100);
  final TextEditingController cityController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController themeController = TextEditingController();

  static const padding = EdgeInsets.only(bottom: 20);

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentRangeValues =
          RangeValues(widget.filter.minPrice, widget.filter.maxPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder<EskapBloc, EskapState>(builder: (context, state) {
      if (state is EskapSuccess) {
        if (state.filter != null) {
          cityController.text = state.filter.city;
        }
        return insideBlocBuilder();
      }
      return Center(child: Text("Data not loaded yet"));
    }));
  }

  Widget insideBlocBuilder() {
    return Container(
      child: Column(
        children: [
          Text(
              "Prix : ${_currentRangeValues.start.round()} - ${_currentRangeValues.end.round()} €"),
          priceRangeSlider(),
          divider(),
          Text("Ville"),
          stringFilter(cityController, "Ville"),
          Text("Nom Escape Game"),
          stringFilter(nameController, "Nom"),
          Text("Theme"),
          stringFilter(themeController, "Theme"),
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

  Widget stringFilter(TextEditingController controller, String label,
      {String hint = ""}) {
    return Container(
      padding: padding,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
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
      child: Text("Filtrer"),
      onPressed: () {
        Filter filter = Filter(
          city: cityController.text.trim().toLowerCase(),
          minPrice: _currentRangeValues.start,
          maxPrice: _currentRangeValues.end,
        );
        widget.setCurrentFilter(filter);
        BlocProvider.of<EskapBloc>(context).add(EskapFilterEvent(filter));
        Navigator.pop(context);
      },
    );
  }
}
