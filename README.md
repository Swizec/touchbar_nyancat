# Touchbar Nyancat Webpack Progress

Stupid Nyan Cat animation to show Webpack build progress on your +$2k MacBook Pro's Touchbar. Enjoy.


[Video 📼](https://twitter.com/Swizec/status/909565004642316288)

[Download ⬇️](https://github.com/Swizec/touchbar_webpack_progress/raw/master/touchbar_webpack_progress.zip)


![](http://i.imgur.com/mHYg4vE.jpeg)

## Here's how you set it up

You can start using it right now. 

**1. ** [Download the app](https://github.com/Swizec/touchbar_webpack_progress/raw/master/touchbar_webpack_progress.zip)), run it. Set it up to run at startup, if you want to be fancy.

**2. ** Add my nyan-progress-webpack-plugin to your `package.json`. I'll try to convince @alexcuz to merge it into his published package. When that happens, this step will be easier.

```
// package.json
"dependencies" {
	// ...
	"nyan-progress-webpack-plugin": "git://github.com/Swizec/nyan-progress-webpack-plugin#send-progress-to-touchbar",
}
```

Then run installation:

```
$ npm install
```

Now you have my progress indicator. It can talk to your Touchbar when the app from step 1 is running.

**3. ** Update your Webpack config.

```javascript
// webpack.config.js

plugins: [
	// ...
	new require('nyan-progress-webpack-plugin')({
		sendProgressToTouchbar: true
	})
]
```

This enables a Nyan Cat webpack progress indicator in your terminal and tells it to send progress to the touchbar.

**4. ** Voila, enjoy your Touchbar Progress indicator. 


## Other awesome TouchBar apps

* [Nyancat][nyancat] by @avatsev
* [TouchFart][touchfart] - by @hungtruong
* [KnightTouchBar2000][KnightTouchBar2000] - by @AkdM
* [TouchBarSpaceFight][TouchBarSpaceFight] - by @insidegui

[nyancat]: <https://github.com/avatsaev/touchbar_nyancat>
[touchfart]: <https://github.com/hungtruong/TouchFart>
[KnightTouchBar2000]: <https://github.com/AkdM/KnightTouchBar2000>
[TouchBarSpaceFight]: <https://github.com/insidegui/TouchBarSpaceFight>
