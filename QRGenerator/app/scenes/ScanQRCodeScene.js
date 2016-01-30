import React, {
  StyleSheet,
  AlertIOS,
  Text,
  Component,
  PropTypes
} from 'react-native';

import Camera from 'react-native-camera';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'transparent',
  },
  scanTip: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  }
});

class ScanQRCodeScene extends Component {
  constructor() {
    super();

    this.state = {
      scanning: true
    };

    this.onBarCodeRead = (result) => {
      if (!this.state.scanning) {
        return;
      }

      // console.log(result.type, result.data, /qr/.test(result.type));

      if (result.type && result.data && /qr/i.test(result.type)) {
        this.setState({
          scanning: false
        });

        AlertIOS.alert(
          'Scan Result',
          result.data,
          [{
            text: 'ok',
            onPress: () => {
              this.setState({
                scanning: true
              });
            }
          }]
        );
      }
    };
  }

  render() {
    return (
      <Camera
        ref="cam"
        style={ styles.container }
        onBarCodeRead={ this.onBarCodeRead }
      >
        <Text style={ styles.scanTip }>
          Scanning!
        </Text>
      </Camera>
    );
  }
}

ScanQRCodeScene.propTypes = {
  navigator: PropTypes.object
};

export default ScanQRCodeScene;
