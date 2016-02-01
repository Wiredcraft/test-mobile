import React from 'react-native';
import {
  HomeScene,
  ScanQRCodeScene,
  GenerateQRCodeScene
} from './scenes';

import env from './manifests/env';

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
    renderScene(navigator) {
      return (
        <GenerateQRCodeScene navigator={ navigator } env={ env } />
      );
    },

    getTitle() {
      return 'QR Code';
    }
  };
}
