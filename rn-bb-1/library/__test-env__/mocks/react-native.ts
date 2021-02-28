import { noop } from "./jest-helpers";

export const LogBox = {ignoreAllLogs: noop};
export const AppRegistry = {registerComponent: noop};
export const NativeModules = {
  RNGetRandomValues: {
    getRandomBase64: noop
  }
}