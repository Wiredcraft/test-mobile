import React, {
  StyleSheet,
  View,
  Text,
  AsyncStorage,
  Component,
  PropTypes
} from 'react-native';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'transparent',
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
      }
    };

    this.fetchNewSeed = () => {
      fetch('http://localhost:3000/seed', {
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
      }))
      .then((responseJson) => {
        const { data, expiredAt } = responseJson;
        this.setState({
          seed: {
            data,
            expiredAt
          }
        });
      })
      .catch((error) => {
        console.warn(error);
      });
    };

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
  }

  componentDidMount() {
    this.getSeedFromStorage()
    .then((result) => {
      const now = new Date().getTime();

      if (!result || !result.data || !result.expiredAt || (result.expiredAt < now)) {
        console.log('seed result from storage invalid or expired, fetching new seed', result);
        this.fetchNewSeed();
        return;
      }

      console.log('stored seed: ', result.data, 'Will expire at: ', new Date(result.expiredAt));
      const { data, expiredAt } = result;
      this.setState({
        seed: {
          data,
          expiredAt
        }
      });
    })
    .catch((error) => {
      console.warn(error);
      this.fetchNewSeed();
    });
  }

  render() {
    const { data, expiredAt } = this.state.seed;
    return (
      <View style={ styles.container }>
        <Text>data: { data }</Text>
        <Text>expiredAt: { expiredAt }</Text>
      </View>
    );
  }
}

GenerateQRCodeScene.propTypes = {
  navigator: PropTypes.object
};

export default GenerateQRCodeScene;
