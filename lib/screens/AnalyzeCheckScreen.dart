import 'package:flutter/material.dart';
import 'package:test_provider_app/model/ChecksData.dart';
import 'package:test_provider_app/ui/TwoButtonsRow.dart';
import 'package:carousel_pro/carousel_pro.dart';

class AnalyzeCheckScreen extends StatelessWidget {
  Check check;
  AnalyzeCheckScreen({this.check});

  @override
  Widget build(BuildContext context) {

    void onTapHero() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.check.title,
          style: Theme.of(context).textTheme.overline,
        ),
      ),
      body: Container(
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                        Container(
                          child: InkWell(
                            onTap: () => onTapHero(),
                            child: Hero(
                                tag: 'checkHero' + this.check.nb.toString(),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                  child: Carousel(
                                    autoplay: false,
                                    dotBgColor: Colors.transparent,
                                    dotSize: 5,
                                    dotColor: Colors.grey[300],
                                    dotIncreasedColor: Colors.grey[300],
                                    images: [
                                      Image.asset(this.check.images[0]),
                                      Image.asset(this.check.images[1])
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                            child: Text(
                              this.check.description,
                              style: Theme.of(context).textTheme.body1,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SafeArea(
                  child: TwoButtonsRow(check: check),
                )
              ])),
    );
  }
}
