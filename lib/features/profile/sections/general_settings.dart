import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../profile.dart';
import '../widgets/basic_settings_list.dart';

class GeneralSettings extends StatelessWidget {
  final ProfileController controller;
  const GeneralSettings({
    super.key, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff191919),
      ),
      child: ListView.separated(
          controller: controller.scrollController3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  controller.basicSettingsRouting(context,controller.generalSettings[index].routeLink!);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        controller.generalSettings[index]
                            .icon!,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          
                          controller.generalSettings[index]
                              .stringText!,
                              overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          "assets/svgs/images/right_arrow.svg",
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: const Color(0xff252525),
              ),
          itemCount: controller.generalSettings.length),
    );
  }
}
