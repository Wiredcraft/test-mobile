import React, {
  StyleSheet,
  View,
  Text,
  AsyncStorage,
  Component,
  PropTypes
} from 'react-native';

import QRCode from 'react-native-qrcode';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'transparent',
  },
  qrCodeContainer: {
    marginBottom: 40
  }
});

const seedStorageKey = 'SEED';

class GenerateQRCodeScene extends Component {
  constructor() {
    super();

    this.state = {
      seed: {
        data: '',
        expiredAt: 0
      },
      remainingSeconds: 0
    };

    this.fetchNewSeed = () => fetch('http://localhost:3000/seed', {
      method: 'GET',
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json',
      }
    })
    .then((response) => response.json())
    .then((responseJson) => new Promise((resolve, reject) => {
      AsyncStorage.setItem(seedStorageKey, JSON.stringify(responseJson), (error) => {
        if (error) {
          reject(error);
        }

        resolve(responseJson);
      });
    }));

    this.getSeedFromStorage = () => new Promise((resolve, reject) => {
      AsyncStorage.getItem(seedStorageKey, (error, result) => {
        if (error) {
          reject(error);
        }

        try {
          resolve(JSON.parse(result));
        } catch (e) {
          reject(e);
        }
      });
    });

    this.getQRCodeView = (seedData) => {
      if (!seedData) {
        return null;
      }

      return (
        <View style={ styles.qrCodeContainer }>
          <QRCode
            value={ seedData }
            size={ 200 }
            bgColor="black"
            fgColor="white"
          />
        </View>
      );
    };

    this.getRemainingSecondsView = (remainingSeconds) => {
      let wording = '';

      if (remainingSeconds <= 0) {
        wording = 'Updating...';
      } else {
        wording = `Update within: ${ remainingSeconds }s`;
      }

      return (
        <Text>{ wording }</Text>
      );
    };

    this.startTimer = () => {
      this.stopTimer();
      this.timer = setInterval(() => {
        const { expiredAt } = this.state.seed;
        const now = new Date().getTime();
        const remainingSeconds = Math.ceil((expiredAt - now) / 1000);

        if (remainingSeconds <= 0) {
          this.stopTimer();
          this.fetchNewSeed()
          .then((result) => {
            this.handleSeedResult(result);
          })
          .catch((error) => {
            console.warn('Auto update seed failed, ', error);
          });
        }

        this.setState({
          remainingSeconds
        });
      }, 1000);
    };

    this.stopTimer = () => {
      if (this.timer) {
        clearInterval(this.timer);
      }
    };

    this.handleSeedResult = (result) => {
      const { data, expiredAt } = result;
      console.log('Set new seed: ', result.data, 'Will expire at: ', new Date(expiredAt));
      this.setState({
        seed: {
          data,
          expiredAt
        }
      });

      this.startTimer();
    };
  }

  componentDidMount() {
    this.getSeedFromStorage()
    .then((result) => {
      const now = new Date().getTime();

      if (!result || !result.data || !result.expiredAt || (result.expiredAt < now)) {
        console.log('seed result from storage invalid or expired, fetching new seed', result);
        return this.fetchNewSeed();
      }

      console.log('stored seed: ', result.data, 'Will expire at: ', new Date(result.expiredAt));
      return Promise.resolve(result);
    })
    .then((result) => {
      this.handleSeedResult(result);
    })
    .catch((error) => {
      console.warn(error);
    });
  }

  componentWillUnmount() {
    if (this.timer) {
      clearInterval(this.timer);
    }
  }

  render() {
    const { remainingSeconds, seed } = this.state;
    const QRCodeView = this.getQRCodeView(seed.data);
    const RemainingSecondsView = this.getRemainingSecondsView(remainingSeconds);

    return (
      <View style={ styles.container }>
        { QRCodeView }
        { RemainingSecondsView }
      </View>
    );
  }
}

GenerateQRCodeScene.propTypes = {
  navigator: PropTypes.object
};

export default GenerateQRCodeScene;
