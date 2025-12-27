import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:referral_app/styles.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PostOpInstructionsView extends StatefulWidget {
  const PostOpInstructionsView({super.key});

  @override
  State<PostOpInstructionsView> createState() => _PostOpInstructionsViewState();
}

class _PostOpInstructionsViewState extends State<PostOpInstructionsView> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              //for landscape and tablet orientations
              maxWidth: 600,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),

              child: ScrollablePositionedList.builder(
                itemCount: 6,
                itemScrollController: itemScrollController,
                scrollOffsetController: scrollOffsetController,
                itemPositionsListener: itemPositionsListener,
                scrollOffsetListener: scrollOffsetListener,

                itemBuilder: (context, index) {
                  return item(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Generate item number [i].
  Widget item(int i) {
    List<Widget> items = [
      // header
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        height: 42,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                height: 24,
                width: 28,
                'assets/svg/Park_Ave_OMS_square.svg',
                semanticsLabel: 'Park Avenue OMS',
                fit: BoxFit.contain,
              ),
            ),
            Text('Postop Instructions', style: MyFonts.title),
          ],
        ),
      ),

      // jump buttons

      // diet
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(text: "Diet\n", style: MyFonts.header),
                TextSpan(
                  text:
                      "Eating after oral surgery can be an adjustment - start with liquid diet and advance as you can tolerate gradually\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text: "Start with soft, cool diet",
                  style: MyFonts.bold,
                ),
                TextSpan(
                  text:
                      " - such as ice cream, milk shakes, protein shakes, yogurt, jello, pudding that does not require much chewing the day of surgery\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(text: "Gradually advance", style: MyFonts.bold),
                TextSpan(
                  text:
                      " to foods with more substance subsequent days - such as apple sauce, scrambled eggs, mashed potatoes, overcooked pasta, fish\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text: "Avoid food with seeds or particulates",
                  style: MyFonts.bold,
                ),
                TextSpan(
                  text: " to avoid them getting into surgical sites\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text:
                      "Most patients are able to return to normal diet 1 week after surgery\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text: "Keep yourself well hydrated",
                  style: MyFonts.bold,
                ),
                TextSpan(
                  text: " with Gatorade or Pedialyte\n",
                  style: MyFonts.regular,
                ),
              ],
            ),
          ),
        ],
      ),

      // avoid 3 "S"
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Avoid 3 "S"\n', style: MyFonts.header),
                TextSpan(
                  text:
                      '3 "S" will help lower your postop bleeding and risk of dry socket - a condition that prolongs recovery and postop pain\n',
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(text: 'No "S"pitting\n', style: MyFonts.bold),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(text: 'No "S"traws\n', style: MyFonts.bold),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text: 'No "S"moking (or Vaping)\n',
                  style: MyFonts.bold,
                ),
              ],
            ),
          ),
        ],
      ),

      // Surgical Site Care
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(text: "Surgical Site Care\n", style: MyFonts.header),
                TextSpan(
                  text:
                      "Taking great care of the surgical site is just as important as the surgery itself\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text: "Biting down on gauze - ",
                  style: MyFonts.regular,
                ),
                TextSpan(
                  text:
                      "Sustained pressure over the surgical site helps in minimizing bleeding.",
                  style: MyFonts.bold,
                ),
                TextSpan(
                  text:
                      " Avoid changing out the gauze too often, rather prolonged pressure works best\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text:
                      "If you run out of gauze, moist tea bags (any type) works well in replacement\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text: "Apply ice on the affected side",
                  style: MyFonts.bold,
                ),
                TextSpan(
                  text:
                      " for 4 days - 20 min on, followed by, 20 min off to avoid frostbites. After 4th day, you can switch to warm compresses\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(text: "Bruising is normal", style: MyFonts.bold),
                TextSpan(
                  text:
                      " and will descend down to your neck/chest over time. Warm compresses help dissipate bruising quicker\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text: "After meals, rinse with salt water",
                  style: MyFonts.bold,
                ),
                TextSpan(
                  text: " (cup of water, teaspoon of salt) with gentle swirl\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text: "All sutures placed will dissolve",
                  style: MyFonts.bold,
                ),
                TextSpan(
                  text:
                      " - they will unravel and fall out at different time points\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text:
                      "Do not keep your mouth closed tight - mobilize your jaw after surgery and stretch your mouth open to help with swelling and pain\n",
                  style: MyFonts.regular,
                ),
              ],
            ),
          ),
        ],
      ),

      // Medications
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(text: "Medications\n", style: MyFonts.header),
                TextSpan(
                  text:
                      "Staying on top of medications help minimize postop pain and complications\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text:
                      "If antibiotics are prescribed, take them exactly as prescribed. Take probiotics or yogurt with it",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text: "Stay ahead of the pain curve\n",
                  style: MyFonts.bold,
                ),
                TextSpan(
                  text:
                      ' and avoid playing "catch up". It is expected that you will have some discomfort and tenderness especially the first 3-4 days after surgery',
                  style: MyFonts.regular,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(text: "Studies have shown ", style: MyFonts.regular),
                TextSpan(
                  text:
                      " taking Ibuprofen & Tylenol together is more effective than narcotics\n",
                  style: MyFonts.bold,
                ),
                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text: "For the first 3 days you can take\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "    ◦ ", style: MyFonts.bold),
                TextSpan(
                  text:
                      "Ibuprofen 600mg (3 tabs of Regular strength 200mg) - every 6 hours​\n",
                  style: MyFonts.regular,
                ),
                TextSpan(text: "    ◦ ", style: MyFonts.bold),
                TextSpan(
                  text:
                      "Tylenol 500mg (Extra strength tylenol) or Tylenol 650mg (2 tabs of Regular strength) - every 6 hours\n",
                  style: MyFonts.regular,
                ),

                TextSpan(text: "• ", style: MyFonts.bold),
                TextSpan(
                  text:
                      "If narcotics are prescribed to you, take ONLY if you have first taken ibuprofen and tylenol, not as a first line\n",
                  style: MyFonts.regular,
                ),
              ],
            ),
          ),
        ],
      ),

      // For any questions contact our team
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "For any questions contact our team\n",
                  style: MyFonts.header,
                ),
                TextSpan(
                  text: "info@parkavenueoralsurgery.com\n",
                  style: MyFonts.regular_underline,
                ),
                TextSpan(
                  text: "212-339-3930\n\n\n\n\n",
                  style: MyFonts.regular,
                ),
              ],
            ),
          ),
        ],
      ),
    ];

    return items[i];
  }

  final scrollDuration = Duration(milliseconds: 750);
  double alignment = 0;
  void scrollTo(int index) => itemScrollController.scrollTo(
    index: index,
    duration: scrollDuration,
    curve: Curves.easeInOutCubic,
    alignment: alignment,
  );

  void scrollBy(double offset) => scrollOffsetController.animateScroll(
    offset: offset,
    duration: scrollDuration,
    curve: Curves.easeInOutCubic,
  );

  void jumpTo(int index) =>
      itemScrollController.jumpTo(index: index, alignment: alignment);
}
