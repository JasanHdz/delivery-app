// HTPPS
const FIREBASE_AUTH = 'identitytoolkit.googleapis.com';
const FIRESTORE_HOST = 'firestore.googleapis.com';
const TOKEN_HOST = 'securetoken.googleapis.com';

// KEYS
const PUBLIC_API_KEY='AIzaSyDmG7ZCTd4pvtKsHnEZWtWutdBRMWuXY-0';
const PUBLIC_PROJECT_ID='platziconfapp1';

const FIRESTORE_PATH = 'v1/projects/$PUBLIC_PROJECT_ID/databases/(default)/documents';
const SING_UP_URL = 'v1/accounts:signUp?key=$PUBLIC_API_KEY';
const CREATE_TOKEN = '$TOKEN_HOST/}/token?key=$PUBLIC_API_KEY';
const SIGNIN_WITH_PASSWORD_URL = '$FIREBASE_AUTH/accounts:signInWithPassword?key=$PUBLIC_API_KEY';

const API_KEY = 'AIzaSyAJgHr5EhxdBiE9l_P7FTdBv-MY3GeyUiM';