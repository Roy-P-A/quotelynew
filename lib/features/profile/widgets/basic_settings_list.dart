import '../../../models/basic_settings_category/basic_list_model.dart';

class BasicSettingsList {
  List<BasicSettingsListModel> settingsList = [
    BasicSettingsListModel(
        icon: "assets/svgs/images/profile/crown.svg",
        stringText: "Buy Premium",
        routeLink: "/buypremium"),
    BasicSettingsListModel(
        icon: "assets/svgs/images/profile/heart.svg",
        stringText: "Favorites",
        routeLink: "/favorites"),
    BasicSettingsListModel(
        icon: "assets/svgs/images/profile/category.svg",
        stringText: "Categories",
        routeLink: "/categories"),
    BasicSettingsListModel(
        icon: "assets/svgs/images/profile/notification1.svg",
        stringText: "Widgets and Notifications",
        routeLink: "/notifications"),
  ];
}
