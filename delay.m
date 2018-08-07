function delay_y = delay(y,fs,bpm,feedback,lebel,decay)
%ディレイ・エフェクター
%この関数は、波形yに、bpmの拍の時間だけずらした波形yを、feedback回足し合わせる。
%ディレイ音の1回目の音量は、原音のlebel%である。
%ディレイ音の音量は、繰り返すたびに、1つ前のディレイ音のdecay%になる。

time=60/bpm; %1拍の秒数
delay_y=y;
DECAY=decay/100; %百分率を少数へ
LEBEL=lebel/100; %百分率を少数へ
for n=1:feedback
    shift=wshift(1,y,round(-(time*fs*n))); %time*n秒波形をずらす
    shift=shift*LEBEL*DECAY; %音量
    for m=1:length(shift)
        if m<=round(time*fs*n)
            shift(m)=0; %ずらしたときに波形の後ろの部分が前にきてしまうので、その部分を0にする
        end
    end
    DECAY=DECAY*DECAY;
    delay_y=delay_y+shift; %ずらした波形を元の波形に足す
end
delay_y=delay_y/max(abs(delay_y)); %正規化
end
%音のデータyにディレイをかけたデータdelay_yを出力できる
%delay_check.mにて実行