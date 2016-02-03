import React, {
  StyleSheet,
  AlertIOS,
  View,
  Component,
  PropTypes
} from 'react-native';

import Camera from 'react-native-camera/index.ios';

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
  },
  scanningBorderContainer: {
    width: 200,
    height: 200,
    flexDirection: 'column',
    justifyContent: 'space-between'
  },
  scanningFirstRow: {
    width: 196,
    flexDirection: 'row',
    alignSelf: 'flex-start',
    justifyContent: 'space-between'
  },
  scanningLastRow: {
    width: 196,
    flexDirection: 'row',
    alignSelf: 'flex-end',
    justifyContent: 'space-between'
  },
  scanningBorderLeftTop: {
    alignSelf: 'flex-start',
    width: 32,
    height: 32,
    borderTopWidth: 2,
    borderLeftWidth: 2,
    borderColor: '#eee',
    opacity: 0.9
  },
  scanningBorderRightTop: {
    alignSelf: 'flex-end',
    width: 32,
    height: 32,
    borderTopWidth: 2,
    borderRightWidth: 2,
    borderColor: '#eee',
    opacity: 0.9
  },
  scanningBorderLeftBottom: {
    alignSelf: 'flex-start',
    width: 32,
    height: 32,
    borderBottomWidth: 2,
    borderLeftWidth: 2,
    borderColor: '#eee',
    opacity: 0.9
  },
  scanningBorderRightBottom: {
    alignSelf: 'flex-end',
    width: 32,
    height: 32,
    borderBottomWidth: 2,
    borderRightWidth: 2,
    borderColor: '#eee',
    opacity: 0.9
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
        <View style={ styles.scanningBorderContainer }>
          <View style={ styles.scanningFirstRow }>
            <View style={ styles.scanningBorderLeftTop } />
            <View style={ styles.scanningBorderRightTop } />
          </View>
          <View style={ styles.scanningLastRow }>
            <View style={ styles.scanningBorderLeftBottom } />
            <View style={ styles.scanningBorderRightBottom } />
          </View>
        </View>
      </Camera>
    );
  }
}

ScanQRCodeScene.propTypes = {
  navigator: PropTypes.object
};

export default ScanQRCodeScene;
