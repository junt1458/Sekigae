import registerRootComponent from 'expo/build/launch/registerRootComponent';
import * as ScreenOrientation from 'expo-screen-orientation';
import App from './src/App';

registerRootComponent(App);
ScreenOrientation.lockAsync(ScreenOrientation.OrientationLock.LANDSCAPE);
