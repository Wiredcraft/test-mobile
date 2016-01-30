import React, {
  StyleSheet,
  View,
  Text,
  // Image,
  Component,
  PropTypes
} from 'react-native';

// import MK from 'react-native-material-kit';
// import { getHomeRoute } from './router.js';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'transparent',
  }
});

// const {
//   MKButton
// } = MK;

class GenerateQRCodeScene extends Component {
  constructor() {
    super();
  }

  render() {
    return (
      <View style={ styles.container }>
        <Text>Generate QR Code Placeholder</Text>
      </View>
    );
  }
}

GenerateQRCodeScene.propTypes = {
  navigator: PropTypes.object
};

export default GenerateQRCodeScene;
