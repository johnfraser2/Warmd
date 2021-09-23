import 'dart:io';
import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dartx/dartx.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:markup_text/markup_text.dart';
import 'package:provider/provider.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';
import 'package:warmd/common/criteria.dart';
import 'package:warmd/common/delayable_state.dart';
import 'package:warmd/common/extensions.dart';
import 'package:warmd/common/states.dart';
import 'package:warmd/common/widgets.dart';
import 'package:warmd/translations/gen/l10n.dart';

import 'score_widget.dart';

class FootprintScreen extends StatefulWidget {
  const FootprintScreen({
    Key? key,
    required this.onSeeClimateChangeTapped,
    required this.onSeeAdvicesTapped,
    required this.onRestartTapped,
    required this.onSeeAboutTapped,
  }) : super(key: key);

  final Function(BuildContext) onSeeClimateChangeTapped;
  final Function(BuildContext) onSeeAdvicesTapped;
  final Function(BuildContext) onRestartTapped;
  final Function(BuildContext) onSeeAboutTapped;

  @override
  _FootprintScreenState createState() => _FootprintScreenState();
}

class _FootprintScreenState extends DelayableState<FootprintScreen> {
  final _scrollController = ScrollController();
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    initializeTimeZones();

    _localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('ic_notif'),
        iOS: IOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onSelectNotification: (String? payload) async {
        _scheduleReminder();

        widget.onRestartTapped(context);
      },
    ).then((success) {
      if (success == true && context.read<HistoryState>().isReminderEnable) {
        _scheduleReminder();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriaState>();

    final sortedCategories = state.categories.where((cat) => cat.co2EqTonsPerYear() > 0).toList();
    sortedCategories.sort((a, b) => -a.co2EqTonsPerYear().compareTo(b.co2EqTonsPerYear()));

    final hiddenShareWidgetContainer = GlobalKey();

    return Scaffold(
      backgroundColor: warmdLightBlue, // for iOS scrolling effect
      body: SafeArea(
        child: Stack(
          children: [
            // This widget will never been shown, it is only use to get an image to share.
            // There may be a better solution.
            _buildHiddenShareWidget(hiddenShareWidgetContainer, context, sortedCategories, state),
            Container(color: warmdLightBlue), // for iOS scrolling effect
            SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    _buildHeader(context, sortedCategories, state, hiddenShareWidgetContainer),
                    const Gap(64),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildFootprintAnalysis(context, state, sortedCategories),
                      ),
                    ),
                    const Gap(24),
                    _buildReminderOption(context),
                    const Gap(48),
                    _buildRedoQuestionnaireButton(context),
                    const Gap(64),
                    _buildGoToSourcesButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHiddenShareWidget(
    GlobalKey<State<StatefulWidget>> hiddenShareWidgetContainer,
    BuildContext context,
    List<CriteriaCategory> sortedCategories,
    CriteriaState state,
  ) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: SingleChildScrollView(
        child: RepaintBoundary(
          key: hiddenShareWidgetContainer,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Gap(32),
                SvgPicture.asset(
                  'assets/splash.svg',
                ),
                const Gap(48),
                Text(
                  Translation.current.footprintShareTitle,
                  textAlign: TextAlign.center,
                  style: context.textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),
                ),
                Center(child: ScoreWidget(state)),
                const Gap(16),
                _buildCarKmEquivalent(state),
                const Gap(64),
                _buildFootprintAnalysis(context, state, sortedCategories),
                const Gap(64),
                SvgPicture.asset(
                  'assets/play_store.svg',
                  width: 148,
                ),
                const Gap(8),
                SvgPicture.asset(
                  'assets/app_store.svg',
                  width: 150,
                ),
                const Gap(32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarKmEquivalent(CriteriaState state) {
    final countryCriteria = state.generalCategory.countryCriteria;
    final meanCarCriteria = CarCriteria(CarConsumptionCriteria(countryCriteria), countryCriteria)..currentValue = 1000;
    final distanceForCurrentScore =
        (state.co2EqTonsPerYear() / meanCarCriteria.co2EqTonsPerYear()) * meanCarCriteria.currentValue;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/car.svg',
          height: 16,
        ),
        const Gap(12),
        // Flexible needed to avoid text overflow
        Flexible(
          child: MarkupText(
            Translation.current.footprintCarKmEquivalent(distanceForCurrentScore.toInt().toString(), meanCarCriteria.unit),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(
    BuildContext context,
    List<CriteriaCategory> sortedCategories,
    CriteriaState state,
    GlobalKey hiddenShareWidgetContainer,
  ) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36)),
            color: warmdLightBlue,
          ),
          margin: const EdgeInsets.only(bottom: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 44),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 220),
                      child: Text(
                        Translation.current.footprintTitle,
                        style: context.textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        alignment: Alignment.topRight,
                        icon: Icon(Platform.isIOS ? CupertinoIcons.share : Icons.share),
                        onPressed: () {
                          ShareFilesAndScreenshotWidgets().shareScreenshot(
                            hiddenShareWidgetContainer,
                            1024,
                            Translation.current.footprintShareTitle,
                            'warmd_carbon_footprint.png',
                            'image/png',
                            text: Translation.current.footprintShareLink,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Center(child: ScoreWidget(state)),
              const Gap(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    _buildCarKmEquivalent(state),
                    Center(
                      child: TextButton(
                        onPressed: () => widget.onSeeClimateChangeTapped(context),
                        child: Text(
                          Translation.current.footprintWarning,
                          textAlign: TextAlign.center,
                          style: context.textTheme.caption?.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(48),
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 212),
                    child: ElevatedButton(
                      onPressed: () => widget.onSeeAdvicesTapped(context),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(warmdGreen),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          context.textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(64)),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        ),
                      ),
                      child: Text(
                        Translation.current.seeAdvices,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFootprintAnalysis(BuildContext context, CriteriaState state, List<CriteriaCategory> sortedCategories) {
    const colors = {
      UtilitiesCategory: Color(0xFFF9A500),
      TravelCategory: warmdRed,
      FoodCategory: warmdGreen,
      GoodsCategory: warmdBlue,
    };

    return Column(
      children: [
        Text(
          Translation.current.footprintRepartitionTitle,
          style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(24),
        SizedBox(
          height: 216,
          child: Row(
            children: [
              Expanded(
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    sections: sortedCategories
                        .map(
                          (cat) => PieChartSectionData(
                            color: colors[cat.runtimeType],
                            value: cat.co2EqTonsPerYear(),
                            title: Translation.current.co2EqKgValue(((cat.co2EqTonsPerYear() / 12) * 1000).round().toString()),
                            radius: 90,
                            titleStyle: context.textTheme.caption?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                            badgeWidget: _PieBadge(
                              'assets/${cat.key}.svg',
                              size: 35,
                              borderColor: colors[cat.runtimeType]!,
                            ),
                            badgePositionPercentageOffset: .98,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              const Gap(8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: sortedCategories
                      .map(
                        (cat) => _PieIndicator(
                          color: colors[cat.runtimeType]!,
                          text: cat.title(),
                          textColor: warmdDarkBlue,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        const Gap(64),
        Text(
          Translation.current.footprintEvolutionTitle,
          style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            Translation.current.footprintEvolutionExplanation,
            textAlign: TextAlign.start,
            style: context.textTheme.subtitle2?.copyWith(color: warmdDarkBlue),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 48),
          child: _FootprintChart(),
        ),
      ],
    );
  }

  Widget _buildReminderOption(BuildContext context) {
    final historyState = context.watch<HistoryState>();

    void setReminderEnable({required bool isOptionEnabled}) {
      if (!isOptionEnabled) {
        _localNotificationsPlugin.cancelAll();
      } else {
        _scheduleReminder();
      }
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 250),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Text(Translation.current.redoQuestionnaireReminder),
            ),
            const Gap(8),
            Switch.adaptive(
              value: historyState.isReminderEnable,
              onChanged: (bool newValue) {
                historyState.isReminderEnable = newValue;

                _localNotificationsPlugin
                        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
                        ?.requestPermissions(
                          alert: true,
                          badge: true,
                          sound: true,
                        )
                        .then((value) => setReminderEnable(isOptionEnabled: newValue)) ??
                    setReminderEnable(isOptionEnabled: newValue);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRedoQuestionnaireButton(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: ElevatedButton(
          onPressed: () {
            // We want to scroll back to the top, I want to see the score after a "Redo questionnaire"
            delay(500.milliseconds, () => _scrollController.jumpTo(0));

            widget.onRestartTapped(context);
          },
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                textStyle:
                    MaterialStateProperty.all<TextStyle>(context.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 32, vertical: 14)),
              ),
          child: Text(
            Translation.current.redoQuestionnaire,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildGoToSourcesButton(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onSeeAboutTapped(context),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(36), topRight: Radius.circular(36)),
          color: warmdLightBlue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  Translation.current.seeAbout,
                  style: context.textTheme.subtitle2?.copyWith(
                    color: warmdDarkBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Gap(24),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: warmdDarkBlue,
                ),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _scheduleReminder() async {
    _localNotificationsPlugin.cancelAll();

    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();

    _localNotificationsPlugin.zonedSchedule(
      0,
      Translation.current.reminderNotificationTitle,
      Translation.current.reminderNotificationDescription,
      TZDateTime.now(getLocation(currentTimeZone)).add(31.days),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminderChannelId',
          'Carbon footprint reminder',
          'Notifications to reminds you to calculate your new carbon footprint',
        ),
        iOS: IOSNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}

class _PieBadge extends StatelessWidget {
  const _PieBadge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
        ),
      ),
    );
  }
}

class _PieIndicator extends StatelessWidget {
  const _PieIndicator({
    Key? key,
    required this.color,
    required this.text,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  final Color color;
  final String text;
  final double size;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 42),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: Row(
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
            const Gap(4),
            Expanded(
              child: Text(
                text,
                style: context.textTheme.bodyText2?.copyWith(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FootprintChart extends StatelessWidget {
  const _FootprintChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyState = context.watch<HistoryState>();
    final scores = historyState.scores!;
    // FOR TEST PURPOSE ONLY
    // final firstScoreDate = DateTime.utc(2020, 7);
    // final scores = {
    //   firstScoreDate: 16.2,
    //   DateTime.utc(firstScoreDate.year, firstScoreDate.month + 2): 15.3,
    //   DateTime.utc(firstScoreDate.year, firstScoreDate.month + 3): 15.7,
    //   DateTime.utc(firstScoreDate.year, firstScoreDate.month + 5): 14.7
    // };
    final improvementPercent = historyState.improvementPercent;

    final years = scores.keys.map((d) => d.year);
    final numYears = max(years.last - years.first + 1, 2);
    final startMonth = scores.keys.first.month;

    final maxX = numYears * 12.0; // each month is represented
    final maxY = max(1.0, (scores.values.reduce(max) / 12) * 1.5);

    int? previousYearForTitle;
    int? previousYearForVerticalLine;

    int xValueToYear(double value) => years.first + (value + startMonth - 1) ~/ 12;

    return AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: [
          LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.white.withOpacity(0.9),
                ),
                handleBuiltInTouches: true,
              ),
              gridData: FlGridData(
                drawHorizontalLine: false,
                drawVerticalLine: true,
                checkToShowVerticalLine: (value) {
                  final year = xValueToYear(value);

                  if (year != years.first && previousYearForVerticalLine != year) {
                    previousYearForVerticalLine = year;
                    return true;
                  }
                  return false;
                },
                getDrawingVerticalLine: (value) => FlLine(
                  color: Colors.black12,
                  strokeWidth: 1,
                  dashArray: const [5],
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) {
                    final year = xValueToYear(value);

                    //TODO Allow to always display all years but may be ugly on small devices when there is several years
                    if (year != years.first && previousYearForTitle != year) {
                      previousYearForTitle = year;
                      return year.toString();
                    }
                    return '';
                  },
                  getTextStyles: (context, value) => context.textTheme.caption?.copyWith(color: warmdDarkBlue),
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) {
                    if (value % 1 == 0) {
                      return value.toInt().toString();
                    }
                    return '';
                  },
                  getTextStyles: (context, value) => context.textTheme.caption?.copyWith(color: warmdDarkBlue),
                ),
                rightTitles: SideTitles(showTitles: false),
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Colors.black12,
                  ),
                  left: BorderSide(
                    width: 2,
                    color: Colors.black12,
                  ),
                  right: BorderSide(
                    color: Colors.transparent,
                  ),
                  top: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
              minX: 0,
              maxX: maxX,
              maxY: maxY,
              minY: 0,
              lineBarsData: [
                _buildGoalLine(scores, improvementPercent, maxX),
                _buildScoresLine(numYears, scores),
              ],
              axisTitleData: FlAxisTitleData(
                leftTitle: AxisTitle(
                  showTitle: true,
                  titleText: Translation.current.footprintEvolutionTonsAxis,
                  textStyle: context.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  showOkCancelAlertDialog(
                    context: context,
                    title: Translation.current.resetFootprintHistoryQuestion,
                    message: Translation.current.resetFootprintHistoryConfirmation,
                  ).then((result) {
                    if (result == OkCancelResult.ok) {
                      historyState.resetHistory();
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: warmdGreen.withOpacity(.1),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Icon(
                    CupertinoIcons.trash,
                    size: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 48),
              child: GestureDetector(
                onTap: () {
                  switch (improvementPercent) {
                    case 6:
                      historyState.improvementPercent = 8;
                      break;
                    case 8:
                      historyState.improvementPercent = 10;
                      break;
                    case 10:
                      historyState.improvementPercent = 12;
                      break;
                    case 12:
                      historyState.improvementPercent = 14;
                      break;
                    case 14:
                      historyState.improvementPercent = 6;
                      break;
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: warmdGreen.withOpacity(.1),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(
                    '$improvementPercent% ▼',
                    style: context.textTheme.caption?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartBarData _buildGoalLine(Map<DateTime, double> scores, int improvementPercent, double maxX) {
    var goalValue = scores.entries.first.value / 12;

    return LineChartBarData(
      spots: List.generate((maxX ~/ 12) + 1, (i) {
        if (i > 0) {
          goalValue = goalValue - (goalValue / 100 * improvementPercent);
        }
        return FlSpot(i * 12.0, (goalValue * 100).round() / 100);
      }),
      isCurved: true,
      colors: [
        warmdGreen,
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [
          warmdGreen.withOpacity(.15),
        ],
      ),
    );
  }

  LineChartBarData _buildScoresLine(int numYears, Map<DateTime, double> scores) {
    final minYear = scores.entries.first.key.year;
    final minMonth = scores.entries.first.key.month;

    final spots = scores.entries
        .map((e) => FlSpot((((e.key.year - minYear) * 12.0) + e.key.month) - minMonth, ((e.value / 12) * 100).round() / 100))
        .toList();

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      colors: [
        warmdBlue,
      ],
      barWidth: 4,
      dotData: FlDotData(
        getDotPainter: (spot, d, data, i) => FlDotCirclePainter(radius: 4, color: warmdBlue, strokeColor: Colors.transparent),
      ),
      isStrokeCapRound: true,
    );
  }
}
