// webpack.config.js

const path = require("path");

module.exports = {
  mode: "production",
  entry: "./src/index.js",
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "dist"),
  },
  resolve: {
    fallback: {
      crypto: require.resolve("crypto-browserify"),
      async_hooks: require.resolve("async_hooks"), // Add this line if needed
      zlib: require.resolve("browserify-zlib"), // Add this line if needed
      querystring: require.resolve("querystring-es3"), // Add this line if needed
      stream: require.resolve("stream-browserify"), // Add this line if needed
      path: false, // Add this line if needed
      fs: false,
      vm: require.resolve("vm-browserify"),
      assert: false,
      util: false,
      child_process: false,
      http: require.resolve("stream-http"),
      os: require.resolve("os-browserify/browser"),
      url: require.resolve("url/"),
      net: false, // or require.resolve('net')
      async_hooks: false, // or require.resolve('async_hooks')
    },
  },
  module: {
    rules: [
      {
        test: /\.(node)$/,
        use: {
          loader: "file-loader",
          options: {
            name: "[name].[ext]",
          },
        },
      },
    ],
  },
};
