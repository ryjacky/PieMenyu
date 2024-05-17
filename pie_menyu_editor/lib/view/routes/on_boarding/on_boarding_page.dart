import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pie_menyu_editor/preferences/editor_preferences.dart';
import 'package:pie_menyu_editor/view/routes/home/home_route.dart';
import 'package:pie_menyu_editor/view/widgets/language_dropdown_menu.dart';
import 'package:pie_menyu_editor/view/widgets/title_bar.dart';
import 'package:provider/provider.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    context.read<EditorPreferences>().showOnBoarding = false;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeRoute()),
    );
  }

  Widget _buildImage(String assetName, [double width = 150]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle:
          const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: const TextStyle(color: Colors.grey, fontSize: 16),
      bodyPadding: const EdgeInsets.fromLTRB(64.0, 0.0, 64.0, 16.0),
      pageColor: Theme.of(context).colorScheme.background,
      imagePadding: EdgeInsets.zero,
    );

    return Column(
      children: [
        TitleBar(
          title: Text(
            "label-welcome".tr(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: IntroductionScreen(
            key: introKey,
            globalBackgroundColor: Theme.of(context).colorScheme.background,
            allowImplicitScrolling: true,
            infiniteAutoScroll: false,
            pages: [
              PageViewModel(
                title: "label-welcome".tr(),
                body: "description-welcome".tr(),
                image: _buildImage('icon.png'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "label-q-language".tr(),
                bodyWidget: LanguageDropdownMenu(
                  initialSelection: context.locale.languageCode,
                  onSelected: (value) {
                    if (value == null) return;
                    context.setLocale(Locale(value));
                  },
                ),
                image: SvgPicture.asset(
                  "assets/images/language-solid.svg",
                  width: 150,
                  colorFilter: const ColorFilter.mode(
                    Colors.white70,
                    BlendMode.srcIn,
                  ),
                ),
                decoration: pageDecoration,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            onSkip: () => _onIntroEnd(context),
            // You can override onSkip callback
            showSkipButton: true,
            skipOrBackFlex: 0,
            nextFlex: 0,
            showBackButton: false,
            //rtl: true, // Display as right-to-left
            back: const Icon(Icons.arrow_back),
            skip: const Text('Skip'),
            next: const Icon(Icons.arrow_forward),
            done: const Text('Done'),
            curve: Curves.fastLinearToSlowEaseIn,
            controlsMargin: const EdgeInsets.all(16),
            controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            dotsContainerDecorator: const ShapeDecoration(
              color: Colors.black45,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
