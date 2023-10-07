abstract class JaredahStates {}

class JaredahInitialState extends JaredahStates {}

class JaredahBottomNaveBarState extends JaredahStates {}

class JaredahGetBusinessDataLoadingState extends JaredahStates {}

class JaredahGetBusinessDataSuccessState extends JaredahStates {}

class JaredahGetBusinessDataErrorState extends JaredahStates
{
  final String error;
  JaredahGetBusinessDataErrorState(this.error);
}

class JaredahGetSportsDataLoadingState extends JaredahStates {}

class JaredahGetSportsDataSuccessState extends JaredahStates {}

class JaredahGetSportsDataErrorState extends JaredahStates
{
  final String error;
  JaredahGetSportsDataErrorState(this.error);
}

class JaredahGetScienceDataLoadingState extends JaredahStates {}

class JaredahGetScienceDataSuccessState extends JaredahStates {}

class JaredahGetScienceDataErrorState extends JaredahStates
{
  final String error;
  JaredahGetScienceDataErrorState(this.error);
}

class JaredahRefresh extends JaredahStates {}

class JaredahRefreshDone extends JaredahStates {}

class JaredahSearchLoadingState extends JaredahStates {}

class JaredahSearchSuccessState extends JaredahStates {}

class JaredahSearchErrorState extends JaredahStates
{
  final String error;
  JaredahSearchErrorState(this.error);
}

class JaredahWebVieSuccess extends JaredahStates {}
class JaredahWebVieError extends JaredahStates {}
