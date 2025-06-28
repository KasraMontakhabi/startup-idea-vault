class StartupIdea {
  final String title;
  final String description;
  final List<String> tags;
  final String icon;
  final int innovation;
  final int feasibility;
  final int monetization;

  StartupIdea({
    required this.title,
    required this.description,
    required this.tags,
    required this.icon,
    required this.innovation,
    required this.feasibility,
    required this.monetization,
  });

  double get averageRating => (innovation + feasibility + monetization) / 3.0;
}