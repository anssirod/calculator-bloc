import 'package:bloc/bloc.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorCubit extends Cubit<String> {
  CalculatorCubit() : super("0");

  String _equation = "0";
  String _result = "0";
  String _expression = "";

  void calculate(String buttonText) {
    if (buttonText == "C") {
      emit(_equation = "0");
      emit(_result = "0");
    } else if (buttonText == "⌫") {
      emit(_equation = _equation.substring(0, _equation.length - 1));
      if (_equation == "") {
        emit(_equation = "0");
      }
    } else if (buttonText == "=") {
      emit(_expression = _equation);
      emit(_expression = _expression.replaceAll('×', '*'));
      emit(_expression = _expression.replaceAll('÷', '/'));

      try {
        Parser p = Parser();
        Expression exp = p.parse(_expression);

        ContextModel cm = ContextModel();
        emit(_result = '${exp.evaluate(EvaluationType.REAL, cm)}');
      } catch (e) {
        _result = "Error";
      }
    } else {
      if (_equation == "0") {
        emit(_equation = buttonText);
      } else {
        emit(_equation = _equation + buttonText);
      }
    }
  }
}
