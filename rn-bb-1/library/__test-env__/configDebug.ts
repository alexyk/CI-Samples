import { LibraryConfig } from "./config";
const { __DEV__ } = LibraryConfig;

// ===========   RELEASE Options   ===========

export const LOGGING_IN_RELEASE = true;


// ===========   DEVELOP Options   ===========

export const MOCK = {
  ENABLED: __DEV__ && true,
  THROW_ON_ERROR: true
}


// Error handling
  // react-native-exception-handler
export const errorHandling = false;
export const errorHandlingPopup = false;
export const redScreenInDevMode = true;
  // react warn and error popups
export const popupErrors = true;

// Logging
  // Redux actions logging
export const reduxLogging = false;
export const collapsedReduxLogging = true;
export const reduxLoggingInclude = true;  // true - include all, RegExp - match it
export const reduxLoggingExclude = false; // false - don't exclude anything, RegExp - match it
  // log filtering (filter console.log calls)
export const logFiltering = false;
export const logFilterOptions = {
  include: /next|prev|action|@@@/, // redux actions and marked with @@@
  includeToJSON: /@@@JSON/,
  exclude: {
    log: false,
    info: false,
    debug: false,
    error: false
  },
  showNonString: false,
  toDebug: true, // logs filtered out to console.debug,
  toReactotron: false, // duplicate console.log calls to Reactotron,
  heartbeat: false
}
/** Rectotron - async-storage, api-sauce, console.tron.log etc.
 * More details at: 
 * (1) app/util/ReactotronConfig.ts
 * (2) https://github.com/infinitered/reactotron/tree/master/docs
 */
export const reactotronEnabled = false;
export const tronLog = {
  t: true,
  md: /login|query|subscr|bbo|ohlcv/
}
