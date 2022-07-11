import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelling_app/colors/colors.dart';
import 'package:travelling_app/models/covid_model.dart';
import 'package:travelling_app/provider/covid_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/covid_widgets/covid_card_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CovidScreen extends StatefulWidget {
  @override
  State<CovidScreen> createState() => _CovidScreenState();
}

class _CovidScreenState extends State<CovidScreen> {
  final format = DateFormat('yyyy-MM-dd');
  late CovidModel covidModel;
  var _auth;
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<CovidProvider>(context).getCovidDialy().then((value) {
        setState(() {
          _isLoading = false;
        });
        covidModel = value;
        // print(value);
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  Widget _buildHelpCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 150,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                // left side padding is 40% of total width
                left: MediaQuery.of(context).size.width * .4,
                top: 20,
                right: 20,
              ),
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                // color: k,
                gradient: LinearGradient(
                  colors: [
                    kPlumpPurple,
                    kRed
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: " Dial 1330 for \n Medical Help!\n",
                          style: TextStyle(fontFamily: 'Aeonik', fontSize: 20)),
                      TextSpan(
                        text: " If any symptoms appear",
                        style: TextStyle(color: kWheat, fontFamily: 'Aeonik'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 170, 0),
              child: SvgPicture.asset(
                "lib/assets/logos/4.svg",
                height: 150.0,
                fit: BoxFit.scaleDown,
                width: 150.0,
              ),
            ),
            Positioned(
              top: 30,
              right: 10,
              child: FaIcon(FontAwesomeIcons.virusCovid, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(color: kRed),
          )
        : SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("Thailand Covid Health information",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800, color: kBrown)),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 64,
                  alignment: WrapAlignment.spaceEvenly,
                  direction: Axis.horizontal,
                  children: [
                    CovidCardWidget(
                      title: 'Date',
                      iconImage: FontAwesomeIcons.calendarDay,
                      iconColor: kRed,
                      info: DateFormat.yMMMd()
                          .format(DateTime.parse(covidModel.txnDate!)),
                    ),
                    CovidCardWidget(
                      title: 'New Cases',
                      iconImage: FontAwesomeIcons.calendarPlus,
                      iconColor: kRed,
                      info: covidModel.newCase!.toString(),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 64,
                  alignment: WrapAlignment.spaceEvenly,
                  direction: Axis.horizontal,
                  children: [
                    CovidCardWidget(
                        title: 'Total Cases',
                        iconImage: FontAwesomeIcons.briefcaseMedical,
                        iconColor: kRed,
                        info: covidModel.totalCase!.toString()),
                    CovidCardWidget(
                        title: 'New Cases Inbound',
                        iconImage: FontAwesomeIcons.arrowRightToCity,
                        iconColor: kRed,
                        info: covidModel.newCaseExAbroad!.toString()),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Wrap(
                  spacing: 10,
                  alignment: WrapAlignment.spaceEvenly,
                  direction: Axis.horizontal,
                  children: [
                    CovidCardWidget(
                        title: 'New Recovered',
                        iconImage: FontAwesomeIcons.virusCovidSlash,
                        iconColor: kRed,
                        info: covidModel.newRecvoered!.toString()),
                    CovidCardWidget(
                        title: 'New Death',
                        iconImage: FontAwesomeIcons.personCircleXmark,
                        iconColor: kRed,
                        info: covidModel.newCase!.toString()),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Preventions',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800,  color: kBrown)),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PreventionCard(
                              imgPath: 'lib/assets/logos/washhands.png',
                              title: 'Wash hands'),
                          PreventionCard(
                              imgPath: 'lib/assets/logos/mask.png',
                              title: 'Wear mask'),
                          PreventionCard(
                              imgPath: 'lib/assets/logos/distance.png',
                              title: 'Social distance'),
                        ],
                      )
                    ],
                  ),
                ),
                _buildHelpCard(context),
              ]),
            ),
          );
  }
}

class PreventionCard extends StatelessWidget {
  final String imgPath;
  final String title;
  PreventionCard({required this.imgPath, required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imgPath,
          width: 100,
          height: 100,
        ),
        Text(
          title,
        )
      ],
    );
  }
}
