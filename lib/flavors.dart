enum Flavor {
  dev,
  hom,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'To Do Dev';
      case Flavor.hom:
        return 'To Do Hom';
      case Flavor.prod:
        return 'To Do Prod';
      default:
        return 'title';
    }
  }

}
