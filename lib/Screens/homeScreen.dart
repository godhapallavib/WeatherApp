//import 'package:flutter_weather/widgets/searchBar.dart' as custom;

import 'package:flutter/material.dart' hide SearchBar;
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../provider/weatherProvider.dart';
import '../widgets/Login.dart';
import '../widgets/WeatherInfo.dart';
import '../widgets/fadeIn.dart';
import '../widgets/locationError.dart';
import '../widgets/mainWeather.dart';
import '../widgets/searchBar.dart';
import '../widgets/sevenDayForecast.dart';
import '../widgets/weatherDetail.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/homeScreen';

  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<void> _getData() async {
    _isLoading = true;
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getWeatherData(context);
    _isLoading = false;
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .getWeatherData(context, isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer<WeatherProvider>(
          builder: (context, weatherProv, _) {
            if (weatherProv.loggedIn) return RequestError();
            if (weatherProv.isLocationError) return const LocationError();
            return Column(
              children: [
                const SearchBar(),
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 2,
                    effect: ExpandingDotsEffect(
                      activeDotColor: themeContext.primaryColor,
                      dotHeight: 6,
                      dotWidth: 6,
                    ),
                  ),
                ),
                if (_isLoading || weatherProv.isLoading) Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: themeContext.primaryColor,
                            color: Colors.white,
                          ),
                        ),
                      ) else Expanded(
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          controller: _pageController,
                          children: [
                            // First Page of the Page View
                            RefreshIndicator(
                              onRefresh: () async => _refreshData(context),
                              child: ListView(
                                padding: const EdgeInsets.all(10),
                                shrinkWrap: true,
                                children: <FadeIn>[
                                  FadeIn(
                                    curve: Curves.easeIn,
                                    child: MainWeather(),
                                  ),
                                  const FadeIn(
                                    curve: Curves.easeIn,
                                    duration: Duration(milliseconds: 500),
                                    child: WeatherInfo(),
                                  ),
                                  // FadeIn(
                                  //   curve: Curves.easeIn,
                                  //   duration: Duration(milliseconds: 750),
                                  //   child: HourlyForecast(),
                                  // ),
                                ],
                              ),
                            ),
                            // Second Page of the Page View
                            ListView(
                              padding: const EdgeInsets.all(10),
                              children: const [
                                FadeIn(
                                  curve: Curves.easeIn,
                                  child: SevenDayForecast(),
                                ),
                                SizedBox(height: 16.0),
                                FadeIn(
                                  curve: Curves.easeIn,
                                  duration: Duration(milliseconds: 500),
                                  child: WeatherDetail(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
