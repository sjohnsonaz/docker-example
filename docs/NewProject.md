# New Project

Create a new folder.  Open a terminal and navigate to that folder.

Create an `src` folder.
``` bash
mkdir src
```

We need to create our root file.  The file type will depend on the type of application we are creating.

* For **server-side** applications, create `index.ts`.
* For **client-side** applications, create `index.tsx`.

Initialize **npm**.
``` bash
npm init
```

Configure **npm** by editing `package.json`.

* Set `main` to `"./src/index.js"`
* Create `typings`, and set it to `"./dist/index.d.ts"`

## Set Up TypeScript

Install **TypeScript** globally.
``` bash
npm install -g typescript

```
Install **TypeScript** locally.
``` bash
npm install --save-dev typescript
```

Initialize **TypeScript**
``` bash
tsc --init
```

Configure **TypeScript** by editing `tsconfig.json`.

* Change `target` to `"ES2017"`
* Change `sourceMap` to `true`
* Change `jsx` to `react`
* Change `outDir` to `"./dist"`
* Change `rootDir` to `"./src"`
* Create `include` in the JSON root, and set it to `["./src"]`

## Set Up Webpack

If we are creating a Web Application, we need to create the root files, and set up **Webpack** to build it.

Create
* `src/index.html`

Install **Webpack**
``` bash
npm install --save-dev webpack webpack-cli webpack-dev-server
```

Install Loaders
``` bash
ts-loader html-webpack-plugin source-map-loader
```

Configure **Webpack** by creating `webpack.config.js`.

``` JavaScript
const path = require('path');

const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    mode: 'development',
    entry: {
        index: './src/index.tsx'
    },
    output: {
        filename: '[name]-[hash:6].js',
        path: path.resolve(__dirname, './build')
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
        historyApiFallback: true
    }
};
```

> Note: Webpack Dev Server has a Web Socket error when behind a reverse-proxy.
> We should expose a different port than the reverse-proxy.

## Install React
``` bash
npm install --save react react-dom
```

``` bash
npm install --save-dev @types/react @types/react-dom
```
