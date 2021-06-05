const GOOGLE_MAP_API = "AIzaSyBxwFDQcEsYGA-lPy_Rksw6xdOCfcCuFCM";

class LocationHelper {
  static String generateLocationPreviewImage(
      double latitude, double longitude) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Alabel:S%7C$latitude,$longitude&key=$GOOGLE_MAP_API";
  }
}
