class Location {
  const Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.timezone,
    this.adminArea,
  });

  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String country;
  final String timezone;
  final String? adminArea;

  String get subtitle {
    final parts = <String>{
      if (adminArea != null && adminArea!.isNotEmpty) adminArea!,
      country,
    };
    return parts.join(' · ');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Location && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
