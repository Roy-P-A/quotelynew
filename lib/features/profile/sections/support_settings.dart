import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../profile.dart';
import '../widgets/quote_list.dart';

class SupportSettings extends StatelessWidget {
  final ProfileController controller;
  const SupportSettings({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff191919),
      ),
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  controller.supportSettingsRouting(QuotesList().quotesList[index].routeLink!);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        QuotesList().quotesList[index].icon!,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          QuotesList().quotesList[index].stringText!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          "assets/svgs/images/right_arrow.svg",
                          color: const Color(0xffAAABAD),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          separatorBuilder: (context, index) => Divider(
                height: 1,
                color: const Color(0xff252525),
              ),
          itemCount: QuotesList().quotesList.length),
    );
  }
}
