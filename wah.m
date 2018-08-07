function wah_y = wah(y, fs, t, fr)
%ワウ・エフェクター
%この関数は、波形yをt秒間を1回として、yが終わるまで、繰り返し強調する周波数をfrHzの幅で移動させる。
%周波数は低いところから上がって、また低いところに戻ってくる。

framesize=fs*(t/2)/(fr/100); %フレームサイズをワウの1/2回分として指定
framesize=round(framesize); %整数化
frame=1; %フレームの初期値
wah_y=[];
judge=0; %whileの判定に使用
low=10; %強調する周波数の最低値
ntrans=round(framesize/2); %強調する周波数の変わり目を滑らかに繋ぐために前後を足し合わせる部分のサイズ
up=linspace(0,1,ntrans)'; %フェードイン
down=linspace(1,0,ntrans)'; %フェードアウト
while judge==0
    for n=1:100:fr %強調する周波数は100Hzずつずらしていく
        f=[n+low n+1000+low]; %強調する周波数領域
        h_lp2k=fir1(50,f/fs/2); %フィルタ設計
        if (frame+framesize-1+ntrans)>length(y) %強調しようとしている領域がyの範囲内であるか判定
            judge=1;
            break
        end
        snf=filter(h_lp2k,1,y(frame:frame+framesize-1+ntrans)); %フィルタ
        if n>1
            snf(1:ntrans)=snf(1:ntrans).*up; %snfの頭をフェードインへ
            wah_y(length(wah_y)-ntrans+1:length(wah_y))=wah_y(length(wah_y)-ntrans+1:length(wah_y))+snf(1:ntrans); %wah_yのお尻にsnfの頭を足す
        end
        wah_y=[wah_y; snf(ntrans+1:length(snf))]; %残りのsnfを足す
        wah_y(length(wah_y)-ntrans+1:length(wah_y))=wah_y(length(wah_y)-ntrans+1:length(wah_y)).*down; %wah_yのお尻をフェードアウトへ
        frame=frame+framesize; %フレームの更新
    end
    for n=fr:-100:0 %強調する周波数が低下していく方についても同様に行う
        f=[n+low n+1000+low];
        h_lp2k=fir1(50,f/fs/2);
        if (frame+framesize-1+ntrans)>length(y)
            judge=1;
            break
        end
        snf=filter(h_lp2k,1,y(frame:frame+framesize-1+ntrans));
        snf(1:ntrans)=snf(1:ntrans).*up;
        wah_y(length(wah_y)-ntrans+1:length(wah_y))=wah_y(length(wah_y)-ntrans+1:length(wah_y))+snf(1:ntrans);
        wah_y=[wah_y; snf(ntrans+1:length(snf))];
        wah_y(length(wah_y)-ntrans+1:length(wah_y))=wah_y(length(wah_y)-ntrans+1:length(wah_y)).*down;
        frame=frame+framesize;
    end
end
wah_y=wah_y/max(abs(wah_y)); %正規化
end
%音のデータyにワウをかけたデータwah_yを出力できる
%wah_check.mにて実行