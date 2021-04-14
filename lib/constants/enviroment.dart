const _FIRESTORE_HOST = 'https://firestore.googleapis.com/v1/projects';
const FIREBASE_AUTH = 'https://identitytoolkit.googleapis.com';
const _TOKEN_HOST = 'https://securetoken.googleapis.com/v1';
const PUBLIC_API_KEY='AIzaSyDmG7ZCTd4pvtKsHnEZWtWutdBRMWuXY-0';
const _PUBLIC_PROJECT_ID='platziconfapp1';

const FIRESTORE_URL = '$_FIRESTORE_HOST/$_PUBLIC_PROJECT_ID/databases/(default)/documents';
const SING_UP_URL = 'v1/accounts:signUp?key=$PUBLIC_API_KEY';
const CREATE_TOKEN = '$_TOKEN_HOST/}/token?key=$PUBLIC_API_KEY';
const SIGNIN_WITH_PASSWORD_URL = '$FIREBASE_AUTH/accounts:signInWithPassword?key=$PUBLIC_API_KEY';