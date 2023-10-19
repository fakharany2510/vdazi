import 'package:flutter/material.dart';
import 'package:vzadi/features/map/presentation/screens/map_screen.dart';
import 'package:vzadi/features/media/presentation/screens/media_screen.dart';
import 'package:vzadi/features/select_map_or_media/presentation/screens/select_map_or_media_screen.dart';

class Routes{
  static const String initialRoute = '/';
  static const String mapScreen = '/mapScreen';
  static const String mediaScreen = '/mediaScreen';


}

class AppRoutes{
  static Route? onGenerateRoute (RouteSettings routeSettings){
    switch(routeSettings.name){
      case Routes.initialRoute:
        return pageBottomLeftToTopRightSlideTransition(widget: const SelectMapOrMediaScreen(), routeSettings: routeSettings);
      case Routes.mapScreen:
        return pageBottomLeftToTopRightSlideTransition(widget: const MapScreen(), routeSettings: routeSettings);
      case Routes.mediaScreen:
        return pageBottomLeftToTopRightSlideTransition(widget:  MediaScreen(), routeSettings: routeSettings);
      default:
        return undefinedRoute();
    }
  }
  static Route<dynamic> undefinedRoute(){
    return MaterialPageRoute(builder: ((context)=>const Scaffold(
      body: Center(
        child: Text('no route founded'),
      ),
    )));
  }
}


pageBottomLeftToTopRightSlideTransition({
  required Widget widget , required RouteSettings routeSettings
})=>PageRouteBuilder(
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
  pageBuilder: (context, animation, animatedTo)=>widget,
  transitionsBuilder:  (context, animation, animatedTo , widget){
    Animation<Offset>  position = animation.drive(Tween(begin:  const Offset(-0.5, 1), end: const Offset(0, 0)).chain(CurveTween(curve:Curves.easeIn)));
    return SlideTransition(
       position: position,
      child: widget,
    );
  }
);

 pageFadeTransition({
  required Widget widget , required RouteSettings routeSettings
})=>PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 100),
    reverseTransitionDuration: const Duration(milliseconds: 50),
    pageBuilder: (context, animation, animatedTo)=>widget,
    transitionsBuilder:  (context, animation, animatedTo , widget){
      Animation<double>  opacity = animation.drive(Tween(begin:0.0, end:1)..chain(CurveTween(curve:Curves.easeIn)));
      return FadeTransition(
        opacity: opacity,
        child: widget,
      );
    }
);