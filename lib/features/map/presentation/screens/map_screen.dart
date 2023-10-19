import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vzadi/core/helper/location_helper.dart';
import 'package:vzadi/core/utils/extensions.dart';
import 'package:vzadi/features/map/data/models/final-destination-model.dart';
import 'package:vzadi/features/map/presentation/widgets/distance_and_time_widget.dart';
import 'package:vzadi/injection_container.dart' as di;
import 'package:vzadi/core/utils/app_colors.dart';
import 'package:vzadi/features/map/presentation/cubit/map_cubit.dart';
import 'package:vzadi/features/map/presentation/cubit/map_state.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../../core/widgets/custome_text_form_field.dart';
import '../../data/models/get_direction_model.dart';
import '../../data/models/place_suggestations_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  static Position? position;
  Completer<GoogleMapController> _mapController = Completer();
  TextEditingController _searchController = TextEditingController();
  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
      bearing: 0.0,
      target: LatLng(position!.latitude, position!.longitude),
      tilt: 0.0,
      zoom: 17);

  Future<void> getMyCurrentLocation() async {
    await LocationHelper.getCurrentLocation();
    position = await Geolocator.getLastKnownPosition().whenComplete(() {
      setState(() {});
    });
  }

  Widget buildMap() {
    return GoogleMap(
      markers: markers,
      initialCameraPosition: _myCurrentLocationCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        return _mapController.complete(controller);
      },
      polylines: getDirectionsModel != null ?{
        Polyline(
          polylineId: const PolylineId("my-polyLine"),
          color: AppColors.primaryColor,
          width: 2,
          points: polyLinePoints,
        )
      }:{},
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  Future<void> goToMyFinalDestinationLocation()async{
   buildCameraNewPosition();
   final GoogleMapController controller = await _mapController.future;
   controller.animateCamera(
       CameraUpdate.newCameraPosition(goToSearchedForPlace));
   buildSearchedPlaceMarker();

  }
void buildSearchedPlaceMarker(){
    searchPlaceMarker = new Marker(
      position: goToSearchedForPlace.target,
      markerId: MarkerId("2"),
      infoWindow: InfoWindow(
        title: "${placeSuggestionsDescription}",
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      onTap: (){
        buildCurrentLocationMarker();
        //show Time and distance
        setState(() {
          isSearchedPlaceMarkedClicked=true;
          isTimeAndDistanceVisible=true;
        });
      },
    );
    addMarkerToMarkersAndUpdateUi(searchPlaceMarker);
}

void buildCurrentLocationMarker(){
  currentLocationMarker = new Marker(
    position: LatLng(position!.latitude , position!.longitude),
    markerId: MarkerId("5"),
    infoWindow: InfoWindow(
      title: "My current Location",
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    onTap: (){
    },
  );
  addMarkerToMarkersAndUpdateUi(currentLocationMarker);

}
void addMarkerToMarkersAndUpdateUi(Marker marker){
    setState(() {
      markers.add(marker);
    });
}

  @override
  void initState() {
    super.initState();
    getMyCurrentLocation();
  }
  //these variables for marker
  Set<Marker> markers = Set();
  late PlaceSuggestionsModel placeSuggestionsModel;
  late String placeSuggestionsDescription;
  late FinalDestinationModel finalDestinationModel;
  late Marker searchPlaceMarker ;
  late Marker currentLocationMarker ;
  late CameraPosition goToSearchedForPlace;

  void buildCameraNewPosition(){
    goToSearchedForPlace = CameraPosition(
        bearing: 0.0,
        target: LatLng(
          finalDestinationModel.result.geometry.location.lat,
          finalDestinationModel.result.geometry.location.lng,
        ),
        tilt: 0.0,
        zoom: 13);
}

///these variables for get directions
  GetDirectionsModel?getDirectionsModel;
  var progressIndicator = false;
  late List<LatLng> polyLinePoints;
  var isSearchedPlaceMarkedClicked = false;
  var isTimeAndDistanceVisible = false;
  late String time;
  late String distance;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(
          placesSuggestionsUseCase: di.sl(), getDirectionsUseCase: di.sl(),finalDestinationUseCase: di.sl()),
      child: BlocConsumer<MapCubit, MapState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                position != null
                    ? buildMap()
                    : Center(
                        child: SizedBox(
                            child: CircularProgressIndicator(
                          backgroundColor: AppColors.primaryColor,
                          color: AppColors.grey,
                        )),
                      ),
                Padding(
                    padding: getPadding(top: 35, left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.lightGrey,
                      ),
                      child: _searchTextFormField(
                          context: context,
                          searchController: _searchController),
                    )),

                (state is GetPlacesSuggestionLoaded &&
                        state.placeSuggestionsModel.predictions.isEmpty)
                    ? Center(
                        child: Padding(
                        padding: getPadding(all: 10),
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                          backgroundColor: AppColors.grey,
                        ),
                      ))
                    : Padding(
                        padding: getPadding(top: 85, left: 20, right: 20),
                        //EdgeInsets.only(top: 90,bottom: 150,left: 20,right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                          ),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (state is GetPlacesSuggestionLoading) {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: AppColors.primaryColor,
                                    color: AppColors.grey,
                                  ));
                                } else if (state is GetPlacesSuggestionLoaded &&
                                    state.placeSuggestionsModel.predictions
                                        .isNotEmpty) {
                                  return InkWell(
                                      onTap: () {
                                       context.read<MapCubit>().getFinalDestination(
                                           placeId: state.placeSuggestionsModel.predictions[index].placeId,
                                           fields: "geometry",
                                           key: "AIzaSyBG8JxYDhMogn1An7Vo0dnYTge7A3xkVYo",
                                           sessiontoken: "usnffn589dfgf76h59jvh8rjhbfjfkjb76875").then((value){

                                       });

                                       placeSuggestionsDescription = state.placeSuggestionsModel.predictions[index].description;
                                       polyLinePoints.clear();
                                      },
                                      child: Padding(
                                        padding: getPadding(
                                            top: 5,
                                            right: 10,
                                            left: 10,
                                            bottom: 10),
                                        child: Container(
                                            padding: getPadding(all: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: AppColors.grey,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.place,
                                                  color: AppColors.white,
                                                ),
                                                10.width,
                                                Expanded(
                                                  child: Text(
                                                    state
                                                        .placeSuggestionsModel
                                                        .predictions[index]
                                                        .description,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: primaryTextStyle(
                                                        color: AppColors.white),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ));
                                } else {
                                  return SizedBox();
                                }
                              },
                              itemCount: (state is GetPlacesSuggestionLoaded &&
                                      state.placeSuggestionsModel.predictions
                                          .isNotEmpty)
                                  ? state
                                      .placeSuggestionsModel.predictions.length
                                  : 1),
                        ),
                      ),

                isSearchedPlaceMarkedClicked
                ?DistanceAndTine(isTimeAndDistanceVisible: isTimeAndDistanceVisible,getDirectionsModel:getDirectionsModel,)
                    :SizedBox(),
              ],
            ),
            floatingActionButton: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 8, 30),
              child: FloatingActionButton(
                onPressed: _goToMyCurrentLocation,
                child: Icon(Icons.place, color: AppColors.white),
                backgroundColor: AppColors.primaryColor,
              ),
            ),
          );
        },
        listener: (context, state) {
          if(state is GetFinalDestinationLoaded){
            finalDestinationModel = state.finalDestinationModel;
            goToMyFinalDestinationLocation();
            getDirections(context: context);
          }
          if(state is GetDirectionsLoaded){
            getDirectionsModel=state.getDirectionsModel;
            getDirections(context: context);
            getPolyLinePoints();
          }
        },
      ),
    );
  }
  void getDirections({required BuildContext context}){
    context.read<MapCubit>().getDirections(
        origin: LatLng(position!.latitude, position!.longitude),
        destination: LatLng(finalDestinationModel.result.geometry.location.lat ,finalDestinationModel.result.geometry.location.lng),
        key: "AIzaSyBG8JxYDhMogn1An7Vo0dnYTge7A3xkVYo");
  }
void getPolyLinePoints(){
    polyLinePoints= getDirectionsModel!.polylinePoints.map((e)=>LatLng(e.latitude, e.longitude)).toList();
}
  Widget _searchTextFormField(
          {required BuildContext context,
          required TextEditingController searchController}) =>
      CustomTextFormField(
        controller: searchController,
        prefix: Padding(
            padding: getPadding(all: getSize(8)), child: Icon(Icons.search)),
        onChanged: (String quary) {
          context.read<MapCubit>().getPlacesSuggestions(
              input: quary,
              type: "address",
              components: "country:eg",
              key: "AIzaSyBG8JxYDhMogn1An7Vo0dnYTge7A3xkVYo",
              sessiontoken: "usnffn589dfgf76h59jvh8rjhbfjfkjb76875");
          setState(() {
            isTimeAndDistanceVisible=false;
          });
        },
        textInputType: TextInputType.text,
        hintText: AppStrings.search,
        hintStyle: primaryTextStyle(
          color: AppColors.primaryColor,
        ),
      );

}
