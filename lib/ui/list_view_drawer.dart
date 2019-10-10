import 'package:flutter/material.dart';
import 'package:flutter_ui_example/models/car_model.dart';
import 'package:intl/intl.dart';

class ListViewDrawer extends StatefulWidget {
  final List<Visit> visits;

  ListViewDrawer(this.visits);

  @override
  _ListViewDrawerState createState() => _ListViewDrawerState();
}

class _ListViewDrawerState extends State<ListViewDrawer> {
  var _isExpanded = false;

  Widget _buildHealthStatusWidget(int percentage, bool trend) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("$percentage %"),
        Icon(
          trend ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: trend ? Colors.green : Colors.red,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var drawerHeight = MediaQuery.of(context).size.height - 80;

    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutQuad,
      bottom: _isExpanded ? 0 : -(drawerHeight - 55),
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
          color: Colors.white,
        ),
        height: drawerHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 40,
              child: Stack(children: <Widget>[
                Container(
                  height: 40,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 17),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 24,
                          ),
                          Text(
                            "Past Virtual Visits",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            "Health Score",
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onPanEnd: (details) {
                    print("pan event ended");
                    print(details);
                    if ((details.velocity.pixelsPerSecond.dy < -700 &&
                            _isExpanded == false) ||
                        (details.velocity.pixelsPerSecond.dy > 700 &&
                            _isExpanded)) {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    }
                  },
                )
              ]),
            ),
            Divider(
              color: Colors.black45,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0, bottom: 20),
                itemCount: widget.visits.length,
                itemBuilder: (context, index) {
                  print("index $index");
                  Visit visit = widget.visits[index];
                  return ListTile(
                    title: Text(
                      visit.getDate,
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(visit.getTime),
                    trailing: _buildHealthStatusWidget(
                        visit.healthPercentage, visit.healthTrend),
                  );
                },
              ),
            )
          ],
        ),
//          child: Stack(children: <Widget>[
//            Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: <Widget>[
//                Container(
//                  height: 40,
//                  child: Column(
//                    children: <Widget>[
//                      SizedBox(height: 17),
//                      Row(
//                        children: <Widget>[
//                          SizedBox(
//                            width: 24,
//                          ),
//                          Text(
//                            "Past Virtual Visits",
//                            style: TextStyle(fontWeight: FontWeight.w500),
//                          ),
//                          Expanded(
//                            child: Container(),
//                          ),
//                          Text(
//                            "Health Score",
//                            style: TextStyle(
//                                color: Colors.black38,
//                                fontWeight: FontWeight.w400),
//                          ),
//                          SizedBox(
//                            width: 24,
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//                Divider(
//                  color: Colors.black45,
//                ),
//                Expanded(
//                  child: ListView.builder(
//                    padding: EdgeInsets.only(top: 0, bottom: 20),
//                    itemCount: widget.visits.length,
//                    itemBuilder: (context, index) {
//                      print("index $index");
//                      Visit visit = widget.visits[index];
//                      return ListTile(
//                        title: Text(
//                          visit.getDate,
//                          style: TextStyle(color: Colors.black),
//                        ),
//                        subtitle: Text(visit.getTime),
//                        trailing: _buildHealthStatusWidget(
//                            visit.healthPercentage, visit.healthTrend),
//                      );
////                          trailing:
////                              Text(visit.healthPercentage.toString() + "%"));
//                    },
//                  ),
//                )
//              ],
//            ),
//            GestureDetector(
//              onPanEnd: (details) {
//                print("pan event ended");
//                print(details);
//                if ((details.velocity.pixelsPerSecond.dy < -700 && _isExpanded == false) ||
//                    (details.velocity.pixelsPerSecond.dy > 700 && _isExpanded)) {
//                  setState(() {
//                    _isExpanded = !_isExpanded;
//                  });
//                }
//              },
//            )
//          ]),
      ),
    );
  }
}
