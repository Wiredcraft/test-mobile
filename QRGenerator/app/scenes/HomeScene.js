import React, {
  StyleSheet,
  View,
  Image,
  Component,
  PropTypes
} from 'react-native';

import MK from 'react-native-material-kit';
import { getScanQRCodeRoute, getGenerateQRCodeRoute } from '../router.js';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'transparent',
  },
  plainFabContainer: {
    marginBottom: 20
  },
  row: {
    flexDirection: 'row',
  },
  col: {
    flex: 1,
    flexDirection: 'column',
    alignItems: 'center',
    marginLeft: 7,
    marginRight: 7
  },
  iconPlus: {
    height: 14,
    width: 14
  }
});

const {
  MKButton
} = MK;


class HomeScene extends Component {
  constructor() {
    super();

    this.state = {
      plainFabCollapsed: true
    };

    this.onPlainFabButtonPress = () => {
      this.setState({
        plainFabCollapsed: !this.state.plainFabCollapsed
      });
    };

    this.onScanQRCodeButtonPress = () => {
      const route = getScanQRCodeRoute();
      this.props.navigator.push(route);
    };

    this.onGenerateQRCodeButtonPress = () => {
      const route = getGenerateQRCodeRoute();
      this.props.navigator.push(route);
    };

    this.getButtonsNode = () => {
      if (this.state.plainFabCollapsed) {
        return null;
      }

      const ScanQRCodeButton = MKButton.flatButton()
        .withText('Scan')
        .withOnPress(this.onScanQRCodeButtonPress)
        .build();

      const GenerateQRCodeButton = MKButton.flatButton()
        .withText('Generate')
        .withOnPress(this.onGenerateQRCodeButtonPress)
        .build();

      return (
        <View style={ styles.row }>
          <View style={ styles.col }>
            <ScanQRCodeButton />
          </View>
          <View style={ styles.col }>
            <GenerateQRCodeButton />
          </View>
        </View>
      );
    };
  }

  render() {
    const iconPlus = {
      uri: 'IconPlus',
      isStatic: true
    };
    const PlainFab = MKButton.plainFab()
      .withOnPress(this.onPlainFabButtonPress)
      .build();

    return (
      <View style={ styles.container }>
        <View style={ styles.plainFabContainer }>
          <PlainFab>
            <Image style={ styles.iconPlus } pointerEvents="none" source={ iconPlus } />
          </PlainFab>
        </View>
        { this.getButtonsNode() }
      </View>
    );
  }
}

HomeScene.propTypes = {
  navigator: PropTypes.object
};

export default HomeScene;
