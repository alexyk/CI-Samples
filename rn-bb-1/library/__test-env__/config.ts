const mainConfig = {
  auth: {
    issuer: '',
    clientId: '',
    redirectUrl: '',
    scopes: [],
  },
  fundamental: {
    url: '',
  },
  crm: {
    url: '',
  },
  reporting: {
    url: '',
  },
  news: {
    url: '',
  },
};

// market data api
export const WEBSOCKET_SERVER_MARKET_DATA: string = '';
// trading api
export const WEBSOCKET_SERVER_TRADE_CLIENT: string = '';

// =========== React-Native alaric-retail-terminal-library config ===========

export const LibraryConfig = {
  __DEV__: true,
  REFRESH_DELAY_MS: 0,
  authService: { refresh: () => {}, authorize: () => {} },
  getRandomValuesInit: () => {},
  storage: {},
  bugReport: () => {},
  disablePopups: (value: boolean) => {},
  errorHandlingInit: () => null,
  reactotronInit: () => null,
  isWeb: true,
};

export default mainConfig;
