class PlaceDetails {
  final int responseCode;
  final String address;
  final String city;
  final String country;
  final String postalCode;
  final double latitude;
  final double longitude;
  PlaceDetails({
    required this.responseCode,
    required this.address,
    required this.city,
    required this.country,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
  });
}