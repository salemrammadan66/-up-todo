class OnboardingModel {
  final String image;
  final String title;
  final String description;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingContent {
  static const List<OnboardingModel> pages = [
    OnboardingModel(
      image: 'assets/images/onboarding_1.png',
      title: 'Manage your tasks',
      description:
          'You can easily manage all of your daily tasks in UpTodo for free',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding_2.png',
      title: 'Create daily routine',
      description:
          'In Uptodo you can create your personalized routine to stay productive',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding_3.png',
      title: 'Orgonaize your tasks',
      description:
          'You can organize your daily tasks by adding your tasks into separate categories',
    ),
  ];
}
