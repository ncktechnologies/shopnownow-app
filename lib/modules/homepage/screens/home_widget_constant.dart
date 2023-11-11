import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/strings.dart';

class HomeMenuItems{
  final String icon;
  final String text;

  HomeMenuItems({required this.text, required this.icon});
}

List<String> pay = [debitCard, payWallet];

List<HomeMenuItems> menuItems = [
  HomeMenuItems(text: groceries, icon: AssetPaths.grocery),
  HomeMenuItems(text: homeCare, icon: AssetPaths.homeCare),
  HomeMenuItems(text: alcohol, icon: AssetPaths.alcohol),
  HomeMenuItems(text: gift, icon: AssetPaths.gift),
  HomeMenuItems(text: chopNow, icon: AssetPaths.chopLogo),
  HomeMenuItems(text: meat, icon: AssetPaths.meat),
];

List<String> naijaState = [
  "Abia",
  "Adamawa",
  "Akwa Ibom",
  "Anambra",
  "Bauchi",
  "Bayelsa",
  "Benue",
  "Borno",
  "Cross River",
  "Delta",
  "Ebonyi",
  "Edo",
  "Ekiti",
  "Enugu",
  "Federal Capital Territory",
  "Gombe",
  "Imo",
  "Jigawa",
  "Kaduna",
  "Kano",
  "Katsina",
  "Kebbi",
  "Kogi",
  "Kwara",
  "Lagos",
  "Nasarawa",
  "Niger",
  "Ogun",
  "Ondo",
  "Osun",
  "Oyo",
  "Plateau",
  "Rivers",
  "Sokoto",
  "Taraba",
  "Yobe",
  "Zamfara"
];