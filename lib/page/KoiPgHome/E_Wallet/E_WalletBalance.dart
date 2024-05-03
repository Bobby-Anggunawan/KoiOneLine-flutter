import 'package:flutter/material.dart';
import 'package:koi_one_line/koi_one_line.dart';

class E_WalletBalance extends StatelessWidget {
  const E_WalletBalance({Key? key, required this.slideCard, required this.iconButton, this.maxHeight = 100}) : super(key: key);

  final List<Widget> slideCard;
  final List<Widget> iconButton;
  
  final double maxHeight;

  final int slideCardFlex = 1;
  final int iconButtonFlex = 1;

  @override
  Widget build(BuildContext context) {

    List<Widget> buildSlideCard = [];
    slideCard.forEach((element) {
      buildSlideCard.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.koiSpacing.medium),
          child: Material(
            type: MaterialType.card,
            borderRadius: BorderRadius.circular(context.koiSpacing.smallest),
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(context.koiSpacing.medium),
              child: element,
            ),
          ),
        )
      );
    });
    buildSlideCard.insert(0, SizedBox(height: context.koiSpacing.smallest,));
    buildSlideCard.add(SizedBox(height: context.koiSpacing.smallest,));

    List<Widget> buildIconButton = [];
    iconButton.forEach((element) {
      buildIconButton.add(
        Expanded(child: element)
      );
    });
    
    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight
      ),
      child: Material(
        type: MaterialType.card,
        elevation: 1,
        borderRadius: BorderRadius.circular(context.koiSpacing.small),
        color: context.koiThemeColor.primary,
        child: Row(
          children: [
            Expanded(
              flex: slideCardFlex,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView(
                  reverse: true,
                  children: buildSlideCard.koiAddBetweenElement(SizedBox(height: context.koiSpacing.autoBetweenCard,)),
                ),
              ),
            ),
            Expanded(
              flex: iconButtonFlex,
              child: Row(
                children: buildIconButton,
              )
            )
          ],
        ),
      ),
    );
  }
}
