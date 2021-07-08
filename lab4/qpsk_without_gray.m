clc;
clear all;
close all;
N=10000;
x=randi([0,1],1,N);
yy=[];
for i=1:2:length(x)
    if x(i)==0 && x(i+1)==0
        y=cosd(45)+1j*sind(45);
    elseif x(i)==0 && x(i+1)==1
            y=cosd(135)+1j*sind(135);
    elseif x(i)==1 && x(i+1)==0
            y=cosd(225)+1j*sind(225);
    elseif x(i)==1 && x(i+1)==1
             y=cosd(315)+1j*sind(315);
    end
  yy=[yy y];
end

ebnodb = -10:10;
number_snrs = length(ebnodb);
BER_SIM=[];
BER_TH=[];
for k=1:number_snrs%SNR for loop
    ebnodb_now = ebnodb(k);
    ebno=10^(ebnodb_now/10);
    sigma=sqrt(1/((log2(4))*ebno));
    n=(1/sqrt(2))*[randn(1,length(yy))+1j*randn(1,length(yy))];
    r=yy+sigma*n;
    I=(real(r)>0);
    Q=(imag(r)>0);
    x_cap=[];
    for i=1:length(r)
        x_cap=[x_cap I(i) Q(i)];
    end
    ber_sim=sum(x~=x_cap)/N;
    BER_SIM=[BER_SIM ber_sim];
    BER_TH=[BER_TH 0.5*((erfc(sqrt(ebno)))-(1/4)*((erfc(sqrt(ebno)))^2))];
end
figure(1);
semilogy(ebnodb,BER_TH,'m--');%semilog plot of BER with snr theoritical
hold on;
semilogy(ebnodb,BER_SIM,'bo-');%semilog plot of BER with snr simulated
grid on;
xlabel('SNR(Eb/No), dB');
ylabel('Bit Error Rate');
title('Bit error probability curve for BPSK modulation');
legend('theoritical', 'simulation');