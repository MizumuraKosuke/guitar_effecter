%�f�B���C�E�G�t�F�N�^�[�̎��s
[y, fs]=audioread('creaphypmono.wav'); %�K���ȃ��m�����f�[�^
t=0:1/fs:length(y)/fs-1/fs;
delay_y=delay(y,fs,240,1,100,100); %������(�T���v���f�[�^,�T���v�����[�g,BPM,��,����(%),����(%))
figure;
plot(t,delay_y,t,y) %�����ƃf�B���C�̔g�`�̏d�ˍ��킹
legend('delay','y')
title('�����ƃf�B���C�̔g�`�̏d�ˍ��킹')
set(gca,'Fontsize',12)
soundsc(delay_y,fs) %�Đ�
%audiowrite('wah1.wav',wah_y,fs)