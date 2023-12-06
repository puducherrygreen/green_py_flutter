class GreenApi {
  // us-central1-green-puducherry.cloudfunctions.net/app/v1/admin/get/user/plants/byUserId/:userId
  static String kBaseUrl = "us-central1-green-puducherry.cloudfunctions.net";

  static String kGetCommuneWithRegionIdUrl =
      "app/v1/user/get/commune/byRegionId/";
  static String kGetQueryUrl = "app/v1/admin/get/user/query/byuserId/";
  static String kGetUserPlantByIdUrl = "app/v1/admin/get/user/plants/byUserId/";
  static String kGetUserPlantByPlantIdUrl =
      "app/v1/user/plant/details/by/passing/plantId/";
  static String kGetUserNotificationUrl =
      "app/v1/admin/get/notification/ByuserId/";
  static String kMakeNotificationReadUrl =
      "app/v1/user/update/read/notification/";

  static Uri kBaseUri = Uri.https(kBaseUrl, '');
  static Uri kGetPlantLand = Uri.https(kBaseUrl, 'app/v1/user/get/plant/land');
  static Uri kUpdateDeviceToken =
      Uri.https(kBaseUrl, 'app/v1/user/update/device/token');
  static Uri kSendQuery = Uri.https(kBaseUrl, 'app/v1/user/add/query');
  static Uri kGetSelectedPlantUrl =
      Uri.https(kBaseUrl, "app/v1/admin/get/admin/gallery/selected");

  static Uri kCreateUserUri = Uri.https(kBaseUrl, 'app/v1/user/create/user');

  static String kGetAvailablePlant = "app/v1/user/get/plant/byLandId/";
  static Uri kAddPlantImage =
      Uri.https(kBaseUrl, 'app/v1/user/create/plant/images');

  static Uri kLoginUri = Uri.https(kBaseUrl, 'app/v1/user/user/login');

  static Uri kGetRegionUri =
      Uri.https(kBaseUrl, '/app/v1/user/get/region/list');
}
