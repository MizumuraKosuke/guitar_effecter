function wah_y = wah(y, fs, t, fr)
%���E�E�G�t�F�N�^�[
%���̊֐��́A�g�`y��t�b�Ԃ�1��Ƃ��āAy���I���܂ŁA�J��Ԃ�����������g����frHz�̕��ňړ�������B
%���g���͒Ⴂ�Ƃ��납��オ���āA�܂��Ⴂ�Ƃ���ɖ߂��Ă���B

framesize=fs*(t/2)/(fr/100); %�t���[���T�C�Y�����E��1/2�񕪂Ƃ��Ďw��
framesize=round(framesize); %������
frame=1; %�t���[���̏����l
wah_y=[];
judge=0; %while�̔���Ɏg�p
low=10; %����������g���̍Œ�l
ntrans=round(framesize/2); %����������g���̕ς��ڂ����炩�Ɍq�����߂ɑO��𑫂����킹�镔���̃T�C�Y
up=linspace(0,1,ntrans)'; %�t�F�[�h�C��
down=linspace(1,0,ntrans)'; %�t�F�[�h�A�E�g
while judge==0
    for n=1:100:fr %����������g����100Hz�����炵�Ă���
        f=[n+low n+1000+low]; %����������g���̈�
        h_lp2k=fir1(50,f/fs/2); %�t�B���^�݌v
        if (frame+framesize-1+ntrans)>length(y) %�������悤�Ƃ��Ă���̈悪y�͈͓̔��ł��邩����
            judge=1;
            break
        end
        snf=filter(h_lp2k,1,y(frame:frame+framesize-1+ntrans)); %�t�B���^
        if n>1
            snf(1:ntrans)=snf(1:ntrans).*up; %snf�̓����t�F�[�h�C����
            wah_y(length(wah_y)-ntrans+1:length(wah_y))=wah_y(length(wah_y)-ntrans+1:length(wah_y))+snf(1:ntrans); %wah_y�̂��K��snf�̓��𑫂�
        end
        wah_y=[wah_y; snf(ntrans+1:length(snf))]; %�c���snf�𑫂�
        wah_y(length(wah_y)-ntrans+1:length(wah_y))=wah_y(length(wah_y)-ntrans+1:length(wah_y)).*down; %wah_y�̂��K���t�F�[�h�A�E�g��
        frame=frame+framesize; %�t���[���̍X�V
    end
    for n=fr:-100:0 %����������g�����ቺ���Ă������ɂ��Ă����l�ɍs��
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
wah_y=wah_y/max(abs(wah_y)); %���K��
end
%���̃f�[�^y�Ƀ��E���������f�[�^wah_y���o�͂ł���
%wah_check.m�ɂĎ��s