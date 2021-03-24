clc;
clear all;
close all;

num_bit=10; %number of bit
data=randi([0,1],num_bit); %random bit generation(1 or 0)
pData=2*data-1;


%%Define Carrier
f=1000; %carrier frequency
fs=f*10; %sampling frequency
Ts=1/fs; 
T=1/f;
M=2; %modulation index
n=M*length(data);
t=0:Ts:n*T; %defining x-range values
car=sin(2*pi*f*t); %carrier frequency
subplot(2,1,1);
stem(pData); %plotting data points after mapping 1 to 1 and 0 to -1
xlabel('Time');
ylabel('Amplitude');
title('mapped data points');
subplot(2,1,2);
plot(car);  %plotting carrier frequency
xlabel('Time');
ylabel('Amplitude');
title('Carrier signal');


%convert impulse data to square pulse
%converting the data points to square pulse with amplitude varying betwen 1
%and -1
tp=0:Ts:T*M;
exData=[];
for(i=1:length(data))
    for(j=1:length(tp)-1)
        exData=[exData pData(i)];
    end
end
exData=[exData 0];
figure;
subplot(2,1,1);
plot(exData,'r-','LineWidth',2); %plotting square wave
xlabel('Time');
ylabel('Amplitude');
title('Square Pulse');
grid on;


%%Modulation
%modulation is done by multiplying square wave by carrier frequency
mSig=exData.*car;
subplot(2,1,2);
plot(mSig,'b-','LineWidth',1);
xlabel('Time');
ylabel('Amplitude');
title('Modulated signal');


%%channel
%here i am adding additive white gaussian noise to the modulated signal
%with SNR varying between -10 and 10 in steps of 1
SNR=-10:10;
for(k=1:length(SNR))
    rx=awgn(mSig,SNR(k));
end
figure;
plot(rx,'g-','LineWidth',1); %plotting noisy signal
xlabel('Time');
ylabel('Amplitude');
title('Noisy signal');
grid on;


%%Demodulation
%demodulation can be simply done by multiplying nosiy signal with carrier
%signal.
%By this we will get a noisy version of orginal square pulse
dem=rx.*car;
figure;
plot(dem,'r-','LineWidth',1); %plotting demodulated signal
xlabel('Time');
ylabel('Amplitude');
title('Demodulated signal');
grid on;

%%decoding
%here i am deciding whether the incoming bit is 1 or 0 and is stored
%in rcv
k=1;
rcv=[];
for(i=1:length(data))
    sm=0;
    for(j=1:length(tp)-1)
        sm=sm+dem(k);
        k=k+1;
    end
    if(sm>0)
        rcv=[rcv 1];
    else
        rcv=[rcv 0];
    end
end
ber=sum(data~=rcv)/num_bit;
ber