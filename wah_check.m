%ワウ・エフェクターの実行
[y, fs]=audioread('creaphypmono.wav'); %適当なモノラルデータ
t=0:1/fs:length(y)/fs-1/fs;
wah_y=wah(y,fs,0.5,9000); %引数(サンプルデータ,サンプルレート,ワウ1回の時間(秒),強調する周波数の幅(Hz))
figure;
subplot(2,1,1);
spectrogram(y,hann(512),256,512,fs,'yaxis') %音源のスペクトログラム
title('音源のスペクトログラム')
set(gca,'Fontsize',16)
subplot(2,1,2);
spectrogram(wah_y,hann(512),256,512,fs,'yaxis') %ワウのスペクトログラム
title('ワウのスペクトログラム') 
set(gca,'Fontsize',16)
sound(wah_y,fs) %再生
%audiowrite('wah1.wav',wah_y,fs)