class AppUrls {
  static const String baseUrl = "http://15.235.204.49:5000/";
  static const String otp = "auth/send-otp";
  static const String forgotPass = "auth/forgot-password";
  static const String confirmPass = "auth/user-reset_password";
  static const String verifyOtp = "auth/verify-otp";
  static const String signUp = "auth/user-signup";
  static const String logIn = "auth/user-signin";
  static const String onBoard = "tutor/onboarding";
  ///////// Tutor Experience //////////////
  static const String getTutorExp = "tutor/experience";
  static const String addTutorExp = "tutor/experience/add";

  ////////////  Add Eduction Tutor ////////
  static const String getTutorProfile = "tutor/profile";
  static const String getTutorEdu = "tutor/education";
  static const String addTutorEdu = "tutor/education/add";
  static const String addAbout = "tutor/about/add";
  static const String editAbout = "tutor/about/edit";

  ////////////  Add parent child Profile ////////
  static const String addChild = "parent/child/add";
  static const String parentOnBoard = "parent/onboarding";
  static const String getChildren = "parent/children";

  ////////////  Tutor Location ////////
  static const String addLocation= "tutor/location";
  static const String getLocations = "tutor/location";
  static const String deleteLocation= "tutor/location";
  
  ////////////  Cost setting screen ////////
  static const String getcostsetting = "tutor/subject/settings";
  static const String postcostsetting = "tutor/subject/settings";
  static const String editcostsetting = "tutor/subject/settings";
  ////////////  Chat APIs ////////
  static const String getAllChat = "chat/conversations";
  ////////////  GET TUTORS ////////
  static const String getTutor = "tutor/locations";
  static const String getTutorProfileFromParentSide = "parent/tutor/";

}
