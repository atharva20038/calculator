import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Home(),
      theme: ThemeData(primarySwatch: Colors.blue),
      title: 'Calculator',
    );
  }
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();


}

class _HomeState extends State<Home> {
  String equation = "0";
  String expression = "0";
  String result = "0";
  double equationSize= 38.0;
  double resultSize =48.0;

  buttonPressed(funcString){
    if(funcString=="C"){
      equation="0";
      result="0";

    }
    else if(funcString=="Delete"){
      equationSize= 48.0;
      resultSize =38.0;
      equation = equation.substring(0,equation.length-1);


      if(equation==""){
        equation = "0";

      }
    }else if(funcString=="="){
      equationSize= 38.0;
      resultSize =48.0;
      expression = equation;
      expression = expression.replaceAll('x', '*');
      expression = expression.replaceAll('÷', '/');
      try {
        Parser p = Parser();

        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        equation = result;
      }catch(e){
        result = "Error";
      }

    }
    else{
      equationSize= 48.0;
      resultSize =38.0;
      if(equation=="0"){
        equation = funcString;
      }else{
        equation = equation + funcString;
      }
    }

  }

  Widget buttonBuild(functionString,ButtonColor,ButtonHeight){
    return Container(
      height: MediaQuery.of(context).size.height*0.1*ButtonHeight,
      color: ButtonColor,
      child: FlatButton(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            color: Colors.white,
            width: 1,
            style : BorderStyle.solid,
          ),
        ) ,
        onPressed: (){
          setState(() {
            buttonPressed(functionString);
          });
        },

        padding: EdgeInsets.all(16.0),
        child: Text(
            functionString,
          style:TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
                equation,
              style: TextStyle(
                fontSize: equationSize,
              ),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),

          ),
          Container(
            child: Text(
                result,
              style: TextStyle(
                fontSize: resultSize,
              ),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),

          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.75,
                child: Table(
                children: [
                  TableRow(
                      children: <Widget>[
                        buttonBuild("C",Colors.red,1),
                        buttonBuild("Delete", Colors.blue, 1),
                        buttonBuild("÷", Colors.blue, 1),
                      ],
                  ),
                  TableRow(
                    children: <Widget>[
                      buttonBuild("7",Colors.black54,1),
                      buttonBuild("8", Colors.black54, 1),
                      buttonBuild("9", Colors.black54, 1),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      buttonBuild("4",Colors.black54,1),
                      buttonBuild("5", Colors.black54, 1),
                      buttonBuild("6", Colors.black54, 1),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      buttonBuild("1",Colors.black54,1),
                      buttonBuild("2", Colors.black54, 1),
                      buttonBuild("3", Colors.black54, 1),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      buttonBuild(".",Colors.black54,1),
                      buttonBuild("0", Colors.black54, 1),
                      buttonBuild("00", Colors.black54, 1),
                    ],
                  ),

                ],
            ),

              ),
              Container(
                width: MediaQuery.of(context).size.width*0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: <Widget>[
                        buttonBuild("+",Colors.blue,1),


                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        buttonBuild("-",Colors.blue,1),


                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        buttonBuild("x",Colors.blue,1),


                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        buttonBuild("=",Colors.red,2),


                      ],
                    ),


                  ],
                ),
              ),

              ],
          ),

        ],
      ),
    );
  }
}
