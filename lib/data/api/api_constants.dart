class ApiConstants {


  //Server url
  static String baseUrl = 'http://kmschool.observer.school/app23/';
  static String baseUrlAssets = '';


  // url end point
  static String usersSignUp = 'api/v1/register';
  static String usersChangePassword = 'update';
  static String signInWithPassword = 'api/v1/login';
  static String forgotPassword = 'api/v1/forget_password';
  static String verifyOTP = 'api/v1/verify_otp';
  static String resetPassword = 'api/v1/password/reset';
  static String API_LOGIN = "login.php";
  static String API_FORGOT_PASSWORD = "forgot_password";
  static String API_GET_LUNCH_MENU = "lunchmenu.php";
  static String API_GET_SNACK_MENU="snackmenu.php";
  static String API_GET_MESSAGESFROMSCHOOL="msgfromschool.php";
  static String API_GET_MESSAGESFROMTEACHER="msgfromteacher.php";
  static String API_GET_MESSAGE_TO_OFFICE_DATA="msgoffice.php";
  static String API_GET_MESSAGE_TO_TEACHER_DATA="msgteacher.php";
  static String API_GET_MESSAGE_SENT_TO_TEACHER_LIST="msgsendteacher.php";
  static String API_GET_MESSAGE_SENT_TO_OFFICE_LIST="msgsendoffice.php";
  static String API_GET_EVENT="event.php";
  static String API_GET_TEACHER_TIME_SLOTS="teacher-meeting-timeslots.php";
  static String API_GET_OFFICE_TIME_SLOTS="office-meeting-timeslots.php";
  static String API_GET_TEACHER_BOOK_MEETING="bookmeeting";
  static String API_GET_OFFICE_BOOK_MEETING="bookmeeting-with-office";

  static String API_GET_TEACHER_MEETING_LIST="meetwithteacher";
  static String API_GET_OFFICE_MEETING_LIST="meetwithoffice";
  static String API_GET_PARENT_PROFILE="parent-profile.php";
  static String API_GET_UPDATE_PARENT_PROFILE="update-parent-profile.php";
  static String API_GET_CHANGE_PASSWORD="change-password.php";
  static String API_GET_DELETE_MEETING="delete-meeting-with-office.php";
  static String API_GET_DELETE_MEETING_WITH_TEACHER="delete-meeting-with-teacher.php";
  static String API_GET_SUBJECT_LIST="get-subject.php";
  static String API_GET_LESSON_RECORD="get-subject.php?";
  static String API_GET_PARENT_REMINDER="parent_reminder.php?days=all";
  static String API_SET_PARENT_REMINDER="parent_reminder.php?student_id=";
  static String API_SET_ALREADY_PARENT_REMINDER="parent_reminder.php?days=getbyid&student_ids=";
  static String API_SET_STUDENT_PHOTOS="student-photos.php?student_id=";
  static String API_GET_DELETE_USER="del-act.php?pid=";



  //constant parameters
  static String EMAIL="email";
  static String PASSWORD="password";
  static String STUDENT_ID="studentid";
  static String PARENT_ID="pid";
  static String MEET_ID="meet_id";
  static String P_ID="parentid";
  static String SUB="sub";
  static String MSG="msg";
  static String FCMToken="fcm_token";
  static String TITLE="title";
  static String SESSION_YEAR="sessionyear";
  static String DATE="date";
  static String MEETING_DATE="meetingdate";
  static String VCH_MEETING_TIME="vchmeetingtime";
  static String CUSTOMER_ID="customer_id";
  static String DELIVERY_WEEK="delivery_week";
  static String INTEVAL="interval";
  static String ID="id";
  static String FARM_ID="farmId";
  static String PRODUCTION_DATE="productionDate";
  static String SHIPMENT_DATE="shipmentDate";
  static String T2_DATE="t2Date";
  static String studentId="student_id=";
  static String subjectId="&subjectid=";
  static String classId="classid";
  static String fcmToken="fcmToken";
  static String dayS="&days=";
  static String vchOldPassword="vchOldpassword";
  static String vchNewPassword="vchNewPassword";
  static String vchNewRetypePassword="vchNewRetypePassword";
}
