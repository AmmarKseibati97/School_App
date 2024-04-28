class HomeItemModel {
  final String icon;
  final String title;
  final void Function() onTap;

  HomeItemModel({required this.icon, required this.title, required this.onTap});
}
