import React, {
  Component
} from 'react-native';

import ExNavigator from '@exponent/react-native-navigator';
import { getHomeRoute } from './router';

class IndexView extends Component {
  render() {
    return (
      <ExNavigator
        initialRoute={ getHomeRoute() }
        style={{ flex: 1 }}
        sceneStyle={{ paddingTop: 64 }}
      />
    );
  }
}

export default IndexView;
