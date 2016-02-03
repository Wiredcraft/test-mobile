import React, {
  AppRegistry,
  Component
} from 'react-native';

import IndexView from './index.js';

class QRGenerator extends Component {
  render() {
    return (
      <IndexView />
    );
  }
}

AppRegistry.registerComponent('QRGenerator', () => QRGenerator);
