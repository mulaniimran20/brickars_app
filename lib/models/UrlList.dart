class UrlList {
  static String baseUrl = "https://www.brickars.com/app_api/";

  String sliderImagesFromHomePage = baseUrl + "slider_images.php";
  String categories = baseUrl + "categories.php";
  String getRecommendationUrl = baseUrl + "getRecommendationUrl.php";

  String getCategorywiseData = baseUrl + "getCatgorywiseHomePageData.php";

  String getSingleListingDetails = baseUrl + "singleListingDetails.php?lisitngid=";

  String getSingleListingDetailsRelatedSuggestion = baseUrl + "getSuggestion.php?lisitngid=";

  String catgosryWiseDataUrl = baseUrl + "category_data.php?catid=";

  String getSearchData = baseUrl + "search_data.php?searchText=";

  String getUserDetails =baseUrl + "getUserProfileDetails.php?userid=";

  String updateUserDetails =baseUrl + "updateUserDetails.php";

  String registerUser =baseUrl + "registerUser.php";


}