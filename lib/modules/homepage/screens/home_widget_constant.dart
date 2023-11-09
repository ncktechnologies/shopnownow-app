import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/strings.dart';

class HomeMenuItems{
  final String icon;
  final String text;

  HomeMenuItems({required this.text, required this.icon});
}

List<HomeMenuItems> menuItems = [
  HomeMenuItems(text: groceries, icon: AssetPaths.grocery),
  HomeMenuItems(text: homeCare, icon: AssetPaths.homeCare),
  HomeMenuItems(text: alcohol, icon: AssetPaths.alcohol),
  HomeMenuItems(text: gift, icon: AssetPaths.gift),
  HomeMenuItems(text: chopNow, icon: AssetPaths.chopLogo),
  HomeMenuItems(text: meat, icon: AssetPaths.meat),
];