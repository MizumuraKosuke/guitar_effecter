%���E�E�G�t�F�N�^�[�̎��s
[y, fs]=audioread('creaphypmono.wav'); %�K���ȃ��m�����f�[�^
t=0:1/fs:length(y)/fs-1/fs;
wah_y=wah(y,fs,0.5,9000); %����(�T���v���f�[�^,�T���v�����[�g,���E1��̎���(�b),����������g���̕�(Hz))
figure;
subplot(2,1,1);
spectrogram(y,hann(512),256,512,fs,'yaxis') %�����̃X�y�N�g���O����
title('�����̃X�y�N�g���O����')
set(gca,'Fontsize',16)
subplot(2,1,2);
spectrogram(wah_y,hann(512),256,512,fs,'yaxis') %���E�̃X�y�N�g���O����
title('���E�̃X�y�N�g���O����') 
set(gca,'Fontsize',16)
sound(wah_y,fs) %�Đ�
%audiowrite('wah1.wav',wah_y,fs)