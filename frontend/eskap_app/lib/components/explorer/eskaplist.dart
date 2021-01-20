import 'package:eskap_app/models/escapeGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eskap_app/bloc/bloc.dart';

class EskapListBloc extends StatefulWidget {
  @override
  _EskapListBlocState createState() => _EskapListBlocState();
}

class _EskapListBlocState extends State<EskapListBloc> {
  EskapBloc _eskapBloc;

  @override
  void initState() {
    super.initState();
    _eskapBloc = BlocProvider.of<EskapBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EskapBloc, EskapState>(builder: (context, state) {
      if (state is EskapInitial) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is EskapFailure) {
        return Center(child: Text('Failed to fetch datas'));
      }
      if (state is EskapSuccess) {
        if (state.eskaps.isEmpty)
          return Center(child: Text('No data'));
        else {
          return ListView.builder(
              itemCount: state.eskaps.length,
              itemBuilder: (BuildContext context, int index) {
                return EskapWidget(eg: state.eskaps[index]);
              });
        }
      }
      return null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _eskapBloc.close();
  }
}

class EskapWidget extends StatelessWidget {
  final EscapeGame eg;

  const EskapWidget({Key key, @required this.eg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text(eg.name),
      subtitle: Text(eg.id),
      trailing: IconButton(
        icon: Icon(eg.isFav ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          if (eg.isFav)
            print("ISFAV");
          else
            print("ISNOTFAV");
        },
      ),
    );
  }
}
