%XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%XXXXXXXX BER performance annalysis of BPSK modulation Technique XXXXXXXXX
%XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
clc;
clear all;
close all;
num_bit=1500;%number of bit
data=randi([0,1],num_bit);%random bit generation (1 or 0)
s=2*data-1;%conversion of data for BPSK modulation
SNRdB=-10:1:10; % SNR in dB
SNR=10.^(SNRdB/10);

%calculation of error
for(k=1:length(SNRdB))%BER (error/bit) calculation for different SNR
y=awgn(complex(s),SNRdB(k));
error=0;
for(c=1:1:num_bit)
    if (y(c)>0&&data(c)==0)||(y(c)<0&&data(c)==1)%logic acording to BPSK
        error=error+1;
    end
end
error=error/num_bit; %Calculate error/bit
m(k)=error;
end


figure(1) 
%plot start
semilogy(SNRdB,m,'o','linewidth',2.5);
grid on;
hold on;
BER_th=(1/2)*erfc(sqrt(SNR)); 
semilogy(SNRdB,BER_th,'r','linewidth',2);
title(' curve for Bit Error Rate verses  SNR for Binary PSK modulation');
xlabel(' SNR(dB)');
ylabel('BER');
legend('simulation','theorytical')
axis([-10 10 10^-5 1]);
%XXXXXXXXXXXXXXXXXXXX End of program XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
