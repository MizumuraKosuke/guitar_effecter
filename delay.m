function delay_y = delay(y,fs,bpm,feedback,lebel,decay)
%�f�B���C�E�G�t�F�N�^�[
%���̊֐��́A�g�`y�ɁAbpm�̔��̎��Ԃ������炵���g�`y���Afeedback�񑫂����킹��B
%�f�B���C����1��ڂ̉��ʂ́A������lebel%�ł���B
%�f�B���C���̉��ʂ́A�J��Ԃ����тɁA1�O�̃f�B���C����decay%�ɂȂ�B

time=60/bpm; %1���̕b��
delay_y=y;
DECAY=decay/100; %�S������������
LEBEL=lebel/100; %�S������������
for n=1:feedback
    shift=wshift(1,y,round(-(time*fs*n))); %time*n�b�g�`�����炷
    shift=shift*LEBEL*DECAY; %����
    for m=1:length(shift)
        if m<=round(time*fs*n)
            shift(m)=0; %���炵���Ƃ��ɔg�`�̌��̕������O�ɂ��Ă��܂��̂ŁA���̕�����0�ɂ���
        end
    end
    DECAY=DECAY*DECAY;
    delay_y=delay_y+shift; %���炵���g�`�����̔g�`�ɑ���
end
delay_y=delay_y/max(abs(delay_y)); %���K��
end
%���̃f�[�^y�Ƀf�B���C���������f�[�^delay_y���o�͂ł���
%delay_check.m�ɂĎ��s