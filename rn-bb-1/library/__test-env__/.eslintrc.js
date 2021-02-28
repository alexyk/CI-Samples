module.exports = {
  extends: 'eslint:recommended',
  parser: '@typescript-eslint/parser',
  env: {
    node: true
  },
  plugins: ['unused-imports'],
  parserOptions: {
    sourceType: 'module',
    ecmaVersion: 7,
  },
  overrides: [
    {
      "files": [
        "**/*.test.ts",
        "**/*.test.js"
      ],
      env: {
        "jest": true
      }
    }
  ],
  rules: {
    // errors
    'unused-imports/no-unused-imports': 'error',
    'no-cond-assign': ['error', 'always'],
    
    // warnings
    indent: ['warn', 2],
    'no-unused-vars': 'warn',
    quotes: ['warn', 'single', { allowTemplateLiterals: true, avoidEscape: true }],
    'no-extra-boolean-cast': 'warn',
    
    // temporary off
    'linebreak-style': ['off', 'unix'],
    'comma-dangle': 'off', //['error', 'never'],
    'no-console': 'off',
    semi: 'off',
    'no-case-declarations': 'off',
    'no-global-assign': ['error', { "exceptions": [ "console" ] }]
  },
  globals: {
    WebSocket: true
  }
}