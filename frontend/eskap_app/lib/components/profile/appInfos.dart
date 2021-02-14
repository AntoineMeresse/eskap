import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfos extends StatefulWidget {
  @override
  _AppInfosState createState() => _AppInfosState();
}

class _AppInfosState extends State<AppInfos> {
  final padding = EdgeInsets.all(10);

  bool showInfo = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        displayAppInfos(),
        showInfos(),
      ],
    );
  }

  Widget displayAppInfos() {
    return InkWell(
      onTap: () {
        setState(() {
          showInfo = !showInfo;
        });
      },
      child: Row(
        children: [
          Icon(showInfo ? Icons.expand_less : Icons.expand_more),
          Text(
            "Informations sur Eskap",
            style: TextStyle(
              fontStyle: !showInfo ? FontStyle.normal : FontStyle.italic,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget infosDev() {
    return Text(
      "Eskap a été développé par Antoine Méresse & Imad Abdelmouine dans le cadre de leur dernière année de Master ( Master E-services - Université de Lille).",
    );
  }

  Widget feedbacks() {
    return Text(
        "Si vous voulez voir l'avancement de notre application ou également nous faire des retours afin d'améliorer celle-ci, retrouvez nous ici :");
  }

  Widget link(String name, String url) {
    return InkWell(
      child: Padding(
        padding: padding,
        child: Text(
          "$name",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }

  Widget links() {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          link("Facebook", "https://www.facebook.com/EskapApp"),
          link("Blog", "https://eskap.team/"),
        ],
      ),
    );
  }

  Widget showInfos() {
    if (showInfo) {
      return Column(
        children: [
          Padding(
            padding: padding,
            child: infosDev(),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(10),
            child: feedbacks(),
          ),
          links(),
        ],
      );
    }
    return Container();
  }
}
