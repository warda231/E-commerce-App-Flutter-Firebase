importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js");

// todo Copy/paste firebaseConfig from Firebase Console
const firebaseConfig = {
 apiKey: "AIzaSyA_9JRMZoiy0ObanG8PCUM0ew5HDqOd7MA",
 authDomain: "loginauth-6577d.firebaseapp.com",
 databaseURL: "https://loginauth-6577d-default-rtdb.firebaseio.com",
 projectId: "loginauth-6577d",
 storageBucket: "loginauth-6577d.appspot.com",
 messagingSenderId: "16040205626",
 appId: "1:16040205626:web:a2a903f9a33cf240754403",
};

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

// todo Set up background message handler