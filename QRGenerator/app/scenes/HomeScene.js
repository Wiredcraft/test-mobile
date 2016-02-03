import React, {
  StyleSheet,
  View,
  Text,
  Image,
  Component,
  PropTypes
} from 'react-native';

import MK from 'react-native-material-kit';
import { getScanQRCodeRoute, getGenerateQRCodeRoute } from '../router.js';

const styles = StyleSheet.create({
  container: {
    flex: 1
  },
  cornerButtonContainer: {
    flex: 1,
    paddingBottom: 20,
    paddingRight: 20,
    justifyContent: 'flex-end',
    alignItems: 'flex-end',
    backgroundColor: 'transparent',
  },
  homeWordingContainer: {
    justifyContent: 'center',
    alignItems: 'center'
  },
  welcome: {
    fontWeight: '200',
    fontSize: 42,
    textAlign: 'center',
    marginTop: 100,
    marginBottom: 10,
  },
  instructions: {
    fontSize: 12,
    textAlign: 'center',
    color: '#333333'
  },
  iconPlus: {
    height: 14,
    width: 14
  },
  iconSmallerFab: {
    height: 12,
    width: 12
  },
  buttonContainer: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    marginBottom: 20
  },
  buttonIcon: {
    width: 20,
    height: 20,
    marginLeft: 20,
    marginRight: 20
  },
  buttonIconStyle: {
    shadowRadius: 1,
    shadowOffset: {
      width: 0,
      height: 0.5
    },
    shadowOpacity: 0.4,
    shadowColor: 'black',
    width: 32,
    height: 32,
    borderRadius: 16
  }
});

const {
  MKButton,
  MKColor,
  getTheme
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
  }

  render() {
    const { plainFabCollapsed } = this.state;
    const iconPlus = {
      uri: 'IconPlus',
      isStatic: true
    };
    const iconPlusRotated = {
      uri: 'IconPlusRotated',
      isStatic: true
    };
    const iconQRCode = {
      uri: 'IconQRCode',
      isStatic: true
    };
    const iconScan = {
      uri: 'IconScan',
      isStatic: true
    };
    const PlainFab = MKButton.plainFab()
      .withOnPress(this.onPlainFabButtonPress)
      .build();
    const ScanQRCodeButton = MKButton.button()
      .withText('Scan')
      .withOnPress(this.onScanQRCodeButtonPress)
      .build();

    const GenerateQRCodeButton = MKButton.button()
      .withText('Generate')
      .withOnPress(this.onGenerateQRCodeButtonPress)
      .build();

    const ScanQRCodeButtonIcon = new MKButton.Builder()
      .withStyle(styles.buttonIconStyle)
      .withRippleLocation('center')
      .withMaskColor(getTheme().bgPlain)
      .withRippleColor(getTheme().bgPlain)
      .withBackgroundColor(MKColor.Silver)
      .withOnPress(this.onScanQRCodeButtonPress)
      .build();

    const GenerateQRCodeButtonIcon = new MKButton.Builder()
      .withStyle(styles.buttonIconStyle)
      .withRippleLocation('center')
      .withMaskColor(getTheme().bgPlain)
      .withRippleColor(getTheme().bgPlain)
      .withBackgroundColor(MKColor.Silver)
      .withOnPress(this.onGenerateQRCodeButtonPress)
      .build();

    const iconPlusImg = plainFabCollapsed ?
      iconPlus : iconPlusRotated;

    return (
      <View style={ styles.container }>
        <View style={ styles.homeWordingContainer }>
          <Text style={ styles.welcome }>
            Welcome.
          </Text>
          <Text style={ styles.instructions }>
            To get started, hit the big fat button.
          </Text>
        </View>
        <View style={ styles.cornerButtonContainer }>
          { !plainFabCollapsed &&
          <View style={ styles.buttonContainer }>
            <View style={ styles.buttonText }>
              <ScanQRCodeButton />
            </View>
            <View style={ styles.buttonIcon }>
              <ScanQRCodeButtonIcon>
                <Image
                  style={ styles.iconSmallerFab }
                  source={ iconScan }
                />
              </ScanQRCodeButtonIcon>
            </View>
          </View>
          }
          { !plainFabCollapsed &&
          <View style={ styles.buttonContainer }>
            <View style={ styles.buttonText }>
              <GenerateQRCodeButton />
            </View>
            <View style={ styles.buttonIcon }>
              <GenerateQRCodeButtonIcon>
                <Image
                  style={ styles.iconSmallerFab }
                  source={ iconQRCode }
                />
              </GenerateQRCodeButtonIcon>
            </View>
          </View>
          }
          <PlainFab>
            <Image
              style={ styles.iconPlus }
              pointerEvents="none"
              source={ iconPlusImg }
            />
          </PlainFab>
        </View>
      </View>
    );
  }
}

HomeScene.propTypes = {
  navigator: PropTypes.object
};

export default HomeScene;
