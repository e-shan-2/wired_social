class AppStrings {
  static const String appName = "Wired";
  static const String login = "Login";
  static const String signUp = "Sign up";
  static const String userName = "UserName";
  static const String password = "Password";
  static const String forgotPassword = "Forgot Password ?";
  static const String or = "OR";
  static const String searchUpperCase = "Search";
  static const String bySigningIn = "By logging in or registering";
  static const String youAgree = " you agree to Terms of Service";
  static const String yourName = "Your Name";
  static const String yourEmail = "Your e-mail";
  static const String yourPassword = "Your password";
  static const String projectUnderDevelopmen = "Project Under Development";
  static const String message = "Message";
  static const String messageSmallCase = "message";
  static const String emailIsRequired = "Email is required";
  static const String pleaseEnterAValidEmail = "Please enter a valid email";
  static const String required = "Required";
  static const String passwordIsRequired = "Password cant be empty";
  static const String noSpace = "It Should not contain space";
  static const String passwordFiveCharacters =
      "Password must have atleast 5 Characters";
  static const String passwordUpperCase =
      "Passwords must have at least one uppercase character";
  static const String passwordLowerCase =
      "Passwords must have at least one lowercase character";
  static const String passwordAtleastOneNumber =
      'Passwords must have at least one number';
  static const String passwordSpecialCharacter =
      'Passwords need at least one special character like !@#\$&*~-';
  static const String success = "Success";
  static const String userId = "userId";
  static const String unableToFindUSerId = "Unable to find  userId";
  static const String chatScreen = "Chat Screen";
  static const String search = "search";
  static const String sendMessage = "Send Message";
  static const String pathUserCollection = "users";
  static const String pathMessageCollection = "messages";
  static const String displayName = "displayName";
  static const String aboutMe = "aboutMe";
  static const String photoUrl = "photoUrl";
  static const String phoneNumber = "phoneNumber";
  static const String id = "id";
  static const String chattingWith = "chattingWith";
  static const String idFrom = "idFrom";
  static const String idTo = "idTo";
  static const String timestamp = "timestamp";
  static const String content = "content";
  static const String type = "type";
  static const String email = "email";
  static const String chatRoomId = 'chatRoomId';

  //Authentication
  static const String users = 'users';
  static const String name = 'name';

  static const String uid = 'uid';
  static const String googleSignIn = "Google Sign In";

  //Chat Screen
  static const String chatRoomList = 'chatRoomList';
  static const String sendBy = "sendby";

  static const String time = 'time';
  static const String chatRoom = 'chatroom';
  static const String chats = 'chats';
  static const String errorSignIn = "Error Sign in";
  static const String loginSuccess = "Login Sucess";
  static const String createdSuccessfully = "created Successfully";
  static const String logOut = 'LogOut';
  static const String chatroom = "chatroom";
  static const String enterSomeText = "Enter some text";
  static const String somethingwentWrong = "Something went wrong";
  static const String loading = "Loading";
  static const String followandInviteFriends = "Follow and invite friends";
  static const String notification = "Notifications";
  static const String privacy = "Privacy";
  static const String security = "Security";
  static const String theme = "Theme";
  static const String help = "Help";
  static const String account = "Account";
  static const String about = "About";
  static const String noResultFound = "No Results Found";
  static const String camera = "Camera";
  static const String gallery = "Gallery";
  static const String profilePic = "profilePic";
  static const String closeApp = "CloseApp";
  static const String yes = "Yes";
  static const String no = "No";
  static const String viewAllString = "View all Comments ....";
  static const String chooseImage = "Choose Image From";
  static const String wired = "Wired";

  static const String emailAlreadyInUse =
      'The email address is already in use by another account.';
  static const String unknownError = "Unknown Error";
  static const String loginSucess = "Login Sucess";
  static const String imageIsRequired = "Image is Required";
  static const String receievedBy = "Receieved By";
  static const String description = "descriptions";
  static const String admin = "admin";
  static const String lastMessage = "lastMessage";
}

  // getchatList() async {
  //   List<Map<String, dynamic>> userDataMap = [];

  //   var x = await _fireStore
  //       .collection(AppStrings.chatRoom)
  //       .where(
  //         "users",
          // arrayContainsAny: [
          //   _auth.currentUser!.uid,
          //   "KI9oI5VVCkghifcjfwA3"
          // ]
        // )
        // .get();

    // print("${x.docs.length} @@@@@@@@@@");
    // userDataMap = x.docs[0].data();

    // for(int i=0;i<x.docs.length-1;i++){

    //   (x.docs[i]==_auth.currentUser!.uid)&&
    // }

    // print(userDataMap);
    // print(userDataMap.containsValue(
    //     ["VRuIxDgzfyM5OHQXtmWRP5RHA4l2", "KI9oI5VVCkghifcjfwA3"]));
    // .then(
    //   (value) {

    //     // userDataMap.add(value.docs);
    //     // userDataMap = value.docs[0].data()['users'] as List<dynamic>;

    //     // print(userDataMap);
    //   },
    // );usre
    // userDataMap = x.docs.map((e) => e.data()) as Map<String, dynamic>;
    // print(x.docs[0].data());
    // print(x.docs);
    // print(x.docs.map((e) => e.data()));

    // bool value = userDataMap.contains(_auth.currentUser!.uid);
    // // print(value);
    // if (!userDataMap.contains(_auth.currentUser!.uid)) {
    //   // var x=await _fireStore.collection(AppStrings.chatRoom).add(data)
    //   // var x = await _fireStore.collection(AppStrings.chatRoom).add({
    //   //   "users": FieldValue.arrayUnion([_auth.currentUser!.uid])
    //   // });
    // }

    // print(x.id)

    // .then((value) => print(value.docs.length));
  // }
