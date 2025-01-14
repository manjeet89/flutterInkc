// version.dart
class Version {
  final int major;
  final int minor;
  final int patch;

  Version(this.major, this.minor, this.patch);

  factory Version.parse(String version) {
    final parts = version.split('.');
    return Version(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  bool operator <(Version other) {
    if (major != other.major) return major < other.major;
    if (minor != other.minor) return minor < other.minor;
    return patch < other.patch;
  }

  @override
  String toString() {
    return '$major.$minor.$patch';
  }
}
