const path = require('path');

const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    mode: 'development',
    entry: {
        index: './src/index.tsx'
    },
    output: {
        filename: '[name]-[hash:6].js',
        path: path.resolve(__dirname, 'build')
    },
    optimization: {
        usedExports: true
    },
    devtool: 'source-map',
    resolve: {
        extensions: ['.webpack.js', '.web.js', '.ts', '.tsx', '.js']
    },
    module: {
        rules: [{
            test: /\.tsx?$/,
            use: 'ts-loader'
        }, {
            test: /\.js$/,
            enforce: 'pre',
            use: ['source-map-loader'],
        }]
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: 'src/index.html'
        })
    ],
    devServer: {
        contentBase: path.join(__dirname, 'build'),
        compress: true,
        host: '0.0.0.0',
        port: 8081,
        historyApiFallback: true,
        disableHostCheck: true,
        proxy: {
            '/api': 'http://server:8080'
        }
    }
};