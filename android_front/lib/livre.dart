import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Competition {
  static Future<List> getAllComp() async {
    try {
      var res = await http.get(
        Uri.parse('http://192.168.22.98:5500/api/competition'),
      );

      print(res.body);
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return Future.error("erreur serveur");
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  static ListeInscrit(BuildContext context, idcompt) async {
    try {
      Navigator.pushNamed(context, '/inscrit', arguments: idcompt);
    } catch (err) {
      return Future.error(err);
    }
  }

  static Future<List> getAllInscrit(context, idComp) async {
    try {
      print('inscrit');
      print(idComp);
      var res = await http.get(
        Uri.parse('http://192.168.22.98:5500/api/competition/inscrit/$idComp'),
      );

      if (res.statusCode == 200) {
        print(res.body);
        return jsonDecode(res.body);
      } else {
        return Future.error("erreur serveur");
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  static Login(BuildContext context, login, password) async {
    try {
      //var connection = {"email": login, "password": password};
      final res = await http.get(
        Uri.parse(
            'http://192.168.22.98:5500/api/users/verify_mdp/$login/$password'),
      );
      if (jsonDecode(res.body)["result"] == 'true' &&
          jsonDecode(res.body)["user"]["admin"] == 1) {
        //print(res);
        Navigator.pushNamed(context, '/liste');
      } else {
        Navigator.pushNamed(context, '/');
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  static ajout(BuildContext context, date, heure, en_cours, tour,
      nomcompetition, circuit) async {
    try {
      var res = await http.get(Uri.parse(
          'http://192.168.22.98:5500/api/competition/add_competition/$circuit/$date/$heure/$en_cours/$tour/$nomcompetition'));
      if (res.statusCode == 200) {
        Navigator.pushNamed(context, '/liste');
      } else {
        Navigator.pushNamed(context, '/');
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  static supprimer(BuildContext context, id) async {
    print('id del $id');
    try {
      var res = await http.get(Uri.parse(
          'http://192.168.22.98:5500/api/competition/del_competition/$id'));
      if (res.statusCode == 200) {
        Navigator.pushNamed(context, '/liste');
      } else {
        Navigator.pushNamed(context, '/');
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  static delinscrit(BuildContext context, idComp, idUser) async {
    try {
      var res = await http.get(Uri.parse(
          'http://192.168.22.98:5500/api/competition/del_inscrit/$idComp/$idUser'));
      if (res.statusCode == 200) {
        Navigator.pushNamed(context, '/liste');
      } else {
        Navigator.pushNamed(context, '/liste');
      }
    } catch (err) {
      return Future.error(err);
    }
  }
}
