import {
  HomeScene,
  ScanQRCodeScene,
  GenerateQRCodeScene
} from './scenes';

export function getHomeRoute() {
  return {
    getSceneClass() {
      return HomeScene;
    },

    onDidFocus(event) {
      console.log('Home Scene received focus.', event);
    },

    getTitle() {
      return 'Home';
    },
  };
}

export function getScanQRCodeRoute() {
  return {
    getSceneClass() {
      return ScanQRCodeScene;
    },

    getTitle() {
      return 'Scan';
    }
  };
}

export function getGenerateQRCodeRoute() {
  return {
    getSceneClass() {
      return GenerateQRCodeScene;
    },

    getTitle() {
      return 'QR Code';
    }
  };
}
