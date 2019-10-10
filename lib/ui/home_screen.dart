import 'package:flutter/material.dart';
import 'package:flutter_ui_example/models/car_model.dart';
import 'package:flutter_ui_example/networking/fetch_car_data.dart';
import 'package:flutter_ui_example/utils/date_formatter.dart';

import 'list_view_drawer.dart';

class HomeScreen extends StatelessWidget {
  DateTime _getRecentVirtualVisit(List<Visit> visits) {
    var mostRecent;
    visits.forEach((visit) {
      if (mostRecent == null) {
        mostRecent = visit.getTimeStamp;
      } else {
        if (visit.getTimeStamp.isAfter(mostRecent)) {
          print("${visit.getTimeStamp} is after $mostRecent");
        }
      }
    });
    return mostRecent;
  }

  int _returnDaySinceLastVisit(String timestampString) {
    return DateFormatter.getNumberOfDaysSinceTimeStampString(timestampString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FetchCarDataAPI().fetchCar(),
        builder: (context, AsyncSnapshot<Car> snapshot) {
          if (snapshot.hasData) {
            return _buildAppBody(context, snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildAppBody(context, Car car) {
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0xFF1F304A),
          child: Center(
            child: Column(
              children: <Widget>[
                _buildTopBar(),
                _buildTitleAndIconWidget(context, car),
                Divider(
                  indent: 16,
                  endIndent: 16,
                  color: Colors.white30,
                ),
                SizedBox(
                  height: 16,
                ),
                _buildStatusTiles(car.visits),
                Expanded(child: Container()),
                _buildNewVisitButton(context),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
        ListViewDrawer(car.visits)
      ],
    );
  }

  Widget _buildTopBar() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 60,
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white30,
              ),
              onPressed: () {
                print("back");
              },
            ),
            Expanded(
              child: Container(),
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white30,
              ),
              onPressed: () {
                print("settings");
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitleAndIconWidget(BuildContext context, Car car) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      child: Center(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Container(
            child: Icon(
              Icons.line_weight,
              color: Colors.white,
              size: 30,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF425978),
            ),
            height: 60,
            width: 60,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            car.name,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          SizedBox(height: 6),
          Text(
            car.propertyName,
            style: TextStyle(fontSize: 18, color: Colors.white30),
          ),
          Expanded(
            child: Container(),
          )
        ],
      )),
    );
  }

  _buildStatusTiles(List<Visit> visits) {
    String lastPhysicalDate = "2019-08-10T18:34:13.847619Z";

    String lastVirtualDate = _getRecentVirtualVisit(visits).toIso8601String();

    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          leading: Icon(
            Icons.directions_walk,
            color: Color(0xFF5BB1CB),
          ),
          title: Align(
            alignment: Alignment(-1.35, 0),
            child: Text(
              "Last physical visit ${_returnDaySinceLastVisit(lastPhysicalDate)} days ago",
              style: TextStyle(color: Colors.white),
            ),
          ),
          subtitle: Align(
            alignment: Alignment(-1.15, 0),
            child: Text(
              DateFormatter.getDateFromString(lastPhysicalDate),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          leading: Icon(
            Icons.blur_circular,
            color: Colors.yellow.shade200,
          ),
          title: Align(
            alignment: Alignment(-1.28, 0),
            child: Text(
              "Last virtual visit ${_returnDaySinceLastVisit(lastVirtualDate)} days ago",
              style: TextStyle(color: Colors.white),
            ),
          ),
          subtitle: Align(
            alignment: Alignment(-1.13, 0),
            child: Text(
              DateFormatter.getDateFromString(lastVirtualDate),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewVisitButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 50,
      child: RaisedButton(
        color: Color(0xFF5BB1CB),
        child: Text(
          "NEW VIRTUAL VISIT",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: () {
          print("hey");
        },
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10),
        ),
      ),
    );
  }
}
