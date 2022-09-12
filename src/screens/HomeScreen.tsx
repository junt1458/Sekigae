import React from 'react';
import { StyleSheet } from 'react-native';
import { View, Text, Button } from 'react-native';
import { useFocusEffect, useNavigation } from '@react-navigation/native';
import { NativeStackNavigationProp } from '@react-navigation/native-stack/lib/typescript/src/types';
import { ScreenList } from '../App';

const HomeScreen = () => {
  const navigation = useNavigation<NativeStackNavigationProp<ScreenList, 'Home'>>();

  useFocusEffect(
    React.useCallback(() => {
      console.log('Home focused.');

      return () => {
        console.log('Home Unfocused');
      };
    }, []),
  );

  return (
    <View style={styles.container}>
      <Text>Home Screen</Text>
      <Button title="次のページ" onPress={() => navigation.navigate('Second')} />
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

export default HomeScreen;
