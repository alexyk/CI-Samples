module.exports = {
  verbose: true,
  roots: [
    '<rootDir>'
  ],
  transform: {
    "\\.ts$": "<rootDir>/node_modules/babel-jest"
  },
  globals: {
    "__TESTING__": true,
    WebSocket: Object
  },
  coverageThreshold: {
    global: {
        branches: 5,
        functions: 5,
        lines: 5,
        statements: 5
    }
  },
  coverageReporters: ['json', 'lcov', 'text', 'clover'],
  testRegex: ['__tests__/.*\.test\.ts'],
  moduleFileExtensions: [ "ts", "json", "js" ],
  testEnvironment: 'node',
  bail: 1
}