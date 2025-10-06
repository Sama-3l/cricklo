part of 'onboarding_page_cubit.dart';

@immutable
sealed class OnboardingPageState {
  final bool loading;

  const OnboardingPageState({this.loading = false});
}

final class OnboardingPageLoading extends OnboardingPageState {
  const OnboardingPageLoading({super.loading});
}
