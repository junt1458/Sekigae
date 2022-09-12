import React from 'react';
import { StyleSheet } from 'react-native';
import { View, Text, Button } from 'react-native';
import { useFocusEffect, useNavigation } from '@react-navigation/native';
import { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { ScreenList } from '../App';

const SecondScreen = () => {
  const navigation = useNavigation<NativeStackNavigationProp<ScreenList, 'Second'>>();

  useFocusEffect(
    React.useCallback(() => {
      console.log('Second focused.');

      return () => {
        console.log('Second Unfocused');
      };
    }, []),
  );

  return (
    <View style={styles.container}>
      <Text>Second Screen</Text>
      <Button title="ホームに戻る" onPress={() => navigation.navigate('Home')} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default SecondScreen;
