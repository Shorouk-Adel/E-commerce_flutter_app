
abstract class AppStates{}


class AppInitialState extends AppStates{}
class BottomNavBarItemMovedToHome extends AppStates{}
class BottomNavBarItemMovedToCategories extends AppStates{}
class BottomNavBarItemMovedToCart extends AppStates{}
class BottomNavBarItemMovedToMenu extends AppStates{}


class HomeDataLoadingState extends AppStates{}
class AddTocartState extends AppStates{}
class ClearcartState extends AppStates{}
class HomeDataSuccessState extends AppStates{}
class CategoriesSuccessState extends AppStates{}
class HomeDataErrorState extends AppStates{}
class CategoriesErrorState extends AppStates{}
