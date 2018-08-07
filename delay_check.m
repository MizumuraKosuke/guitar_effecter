%ディレイ・エフェクターの実行
[y, fs]=audioread('creaphypmono.wav'); %適当なモノラルデータ
t=0:1/fs:length(y)/fs-1/fs;
delay_y=delay(y,fs,240,1,100,100); %引数は(サンプルデータ,サンプルレート,BPM,回数,音量(%),減衰(%))
figure;
plot(t,delay_y,t,y) %音源とディレイの波形の重ね合わせ
legend('delay','y')
title('音源とディレイの波形の重ね合わせ')
set(gca,'Fontsize',12)
soundsc(delay_y,fs) %再生
%audiowrite('wah1.wav',wah_y,fs)