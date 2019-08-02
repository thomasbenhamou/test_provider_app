import 'package:flutter/material.dart';
import 'package:test_provider_app/ui/SumCheck.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SummaryRow extends StatelessWidget {
  final String category;
  final int checked;
  final int total;
  final bool done;

  SummaryRow({this.category, this.checked, this.total, this.done});

  @override
  Widget build(BuildContext context) {
    double calculateWidth() {
      double width =
          MediaQuery.of(context).size.width * (this.checked / this.total);
      if (width < 200) {
        return 200;
      } else {
        return width;
      }
    }

    return Container(
      decoration: ShapeDecoration(
          color: Colors.grey[200],
          shape: RoundedRectangleBorder(
              borderRadius: this.done == true
                  ? BorderRadius.circular(0)
                  : BorderRadius.only(
                      topRight: Radius.circular(90),
                      bottomRight: Radius.circular(90)))),
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      width: calculateWidth(),
      height: 45,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
                padding: EdgeInsets.fromLTRB(25, 10, 10, 10),
                child: Text(
                  this.category,
                  style: Theme.of(context).textTheme.button.apply(
                        color:
                            this.done == true ? Colors.green : Colors.grey[800],
                        fontWeightDelta: this.done == true ? 700 : 0,
                      ),
                )),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: this.done == true
                  ? Icon(
                      Feather.getIconData("check-circle"),
                      color: Colors.green,
                      size: 30,
                    )
                  : SumCheck(checked: this.checked, total: this.total),
            ),
          )
        ],
      ),
    );
  }
}
