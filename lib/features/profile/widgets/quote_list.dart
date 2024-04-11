import '../../../models/basic_settings_category/basic_list_model.dart';

class QuotesList {
  List<BasicSettingsListModel> quotesList = [
    BasicSettingsListModel(icon: "assets/svgs/images/profile/messages.svg", stringText: "Need help?", routeLink: "/needhelp"),
    BasicSettingsListModel(icon: "assets/svgs/images/profile/notification.svg", stringText: "Privacy Policy", routeLink: "/privacy"),
    BasicSettingsListModel(icon: "assets/svgs/images/profile/notification.svg", stringText: "Terms and conditions", routeLink: "/termsandconditions"),
    
  ];
}
