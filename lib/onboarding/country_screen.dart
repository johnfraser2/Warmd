import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../common/common.dart';
import '../common/criterias.dart';

class CountryScreen extends StatelessWidget {
  final Function onCountrySelected;

  CountryScreen({this.onCountrySelected, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriasState>();
    final c = state.categorySet.categories[0].criterias[0];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.h64,
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Text(
                    'COUNTRY',
                    style: TextStyle(color: warmdBlue, fontSize: 20),
                  ),
                  Gaps.h32,
                  const Text(
                    'Which country do you reside in?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: warmdDarkBlue, fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  Gaps.h64,
                  Container(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton<int>(
                        isExpanded: true,
                        selectedItemBuilder: (BuildContext context) {
                          return c.labels.map((String item) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            );
                          }).toList();
                        },
                        value: c.currentValue.toInt(),
                        underline: Container(),
                        onChanged: (int value) {
                          c.currentValue = value.toDouble();
                          state.persist(c);
                        },
                        items: c.labels
                            .mapIndexed((index, label) => DropdownMenuItem<int>(
                                  value: index,
                                  child: Text(
                                    label,
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  Gaps.h32,
                  const Text(
                    'This information allows us to correctly compute your carbon footprint.',
                    style: TextStyle(color: warmdDarkBlue, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                onCountrySelected();
              },
              child: const Text(
                'CONTINUE',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Gaps.h64,
          SvgPicture.asset(
            'assets/bear.svg',
          ),
        ],
      ),
    );
  }
}
