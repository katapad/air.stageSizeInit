# what is this

* Adobe AIR のステージサイズの取得がバグってるかんじがするのを吸収するやつです。

参考: 
[地獄の“大開発者”養成ブログ — [AIR for iOS] 初期化時にStageの幅高さが2倍以上の1280x2192になる件について。](http://jigoku-no.tumblr.com/post/47738907684/air-for-ios-stage-2-1280x2192)




## 現象
* iOSで
	* stageScaleMode = 'noScale'のときに
	* stage.stageWidthが倍の大きさになる
	* 2度目のonResizeで期待通りのstageWidthが取得可能。


### デバイス別現象

* iOS → アプリ起動イベント後に正しい幅高さにリサイズ
* Android → 最初っから正しい幅高さ
* Desktop → アプリ起動イベント前に正しい幅高さにリサイズ

stage.fullscreenWidthで取得可能。だが、なんしかstageWidthが違うと面倒なので、stageWidthが期待通りの値になるのを待つことにする
(待つと行っても1フレーム以内に終わる)


## 使い方
```
//Desktop
new StageSizeInit().init(new DesktopStageSizeState(), layer, addedCallback, callback);

//iOS
new StageSizeInit().init(new iOSStageSizeState(), layer, addedCallback, callback);

//Android
new StageSizeInit().init(new AndroidStageSizeState(), layer, addedCallback, callback);


function addedCallback():void {
    stage.scaleMode = 'noScale'; //←addedしたときにコールバックが来ます。ここでstageにnoScale設定を必ずする。
}

function callback():void {
    trace('ちゃんとしたstageWidthが取れる');
}
```


## Testing

FlexUnitでstageの取得がわかんないからやってません。こんど調べてやります。すみません！！

