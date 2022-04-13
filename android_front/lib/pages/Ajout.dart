import 'package:flutter/material.dart';
import 'package:flutterapp/livre.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class Ajout extends StatefulWidget {
  const Ajout({Key? key}) : super(key: key);

  @override
  State<Ajout> createState() => _AjoutState();
}

class _AjoutState extends State<Ajout> {
  bool isAPIcallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? title;
  String? body;
  String? date;
  String? heure;
  String? en_cours;
  String? tour;
  String? nomcompetition;
  String? circuit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ajouter une compétition"),
        ),
        backgroundColor: Colors.white,
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _AjoutUI(context),
          ),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _AjoutUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                " Nom compétition:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
            ),
            FormHelper.inputFieldWidget(
              context,
              "test",
              "test",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Le Nom ne peut être vide";
                }
                return null;
              },
              (onSaved) {
                nomcompetition = onSaved;
              },
              borderFocusColor: Colors.blue,
              borderColor: Colors.blue,
              textColor: Colors.blue,
              hintColor: Colors.blue.withOpacity(0.8),
              borderRadius: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                " Date compétition:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
            ),
            FormHelper.inputFieldWidget(
              context,
              "test",
              "année-mois-jour",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "La date ne peut être vide";
                }
                return null;
              },
              (onSaved) {
                date = onSaved;
              },
              borderFocusColor: Colors.blue,
              borderColor: Colors.blue,
              textColor: Colors.blue,
              hintColor: Colors.blue.withOpacity(0.8),
              borderRadius: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                " Heure compétition:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
            ),
            FormHelper.inputFieldWidget(
              context,
              "test",
              "heure:minute:seconde",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "L'heure ne peut être vide";
                }
                return null;
              },
              (onSaved) {
                heure = onSaved;
              },
              borderFocusColor: Colors.blue,
              borderColor: Colors.blue,
              textColor: Colors.blue,
              hintColor: Colors.blue.withOpacity(0.8),
              borderRadius: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                " Nombre de tour:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
            ),
            FormHelper.inputFieldWidget(
              context,
              "test",
              "nb tour",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Le nombre de tour ne peut être vide";
                }
                return null;
              },
              (onSaved) {
                tour = onSaved;
              },
              borderFocusColor: Colors.blue,
              borderColor: Colors.blue,
              textColor: Colors.blue,
              hintColor: Colors.blue.withOpacity(0.8),
              borderRadius: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                " ID de circuit:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
            ),
            FormHelper.inputFieldWidget(
              context,
              "test",
              "id circuit",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Le circuit ne peut être vide";
                }
                return null;
              },
              (onSaved) {
                circuit = onSaved;
              },
              borderFocusColor: Colors.blue,
              borderColor: Colors.blue,
              textColor: Colors.blue,
              hintColor: Colors.blue.withOpacity(0.8),
              borderRadius: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: FormHelper.submitButton("Validez", () {
                dynamic validate = globalFormKey.currentState?.validate();
                if (validate != null && validate) {
                  globalFormKey.currentState?.save();
                  Competition.ajout(
                      context, date, heure, 0, tour, nomcompetition, circuit);
                }
              },
                  btnColor: Colors.blue,
                  borderColor: Colors.white,
                  txtColor: Colors.white,
                  borderRadius: 10),
            )
          ]),
    );
  }
}
