clc;
clear all;
close all;

t=0:0.001:1; %creating values for x axis
Am=1/2;     %amplitude of message signal
Ac=1;       %amplitude of carrier signal
fm=5;       %frequency of modulating signal
fc=500;      %frequency of carrier signal

%message signal
ym=Am*sin(2*pi*fm*t);   %message signal
figure(1)
subplot(6,1,1)
plot(t,ym)              %plotting message signal
title('Modulating signal')

%carrier signal
yc=Ac*cos(2*pi*fc*t);    %carrier signal
subplot(6,1,2)
plot(t,yc)               %plotting carrier signal
grid on;
title('Carrier signal')

%Conventional DSB-SC Modulation
y = ym.*yc;       %multiplying message signal with carrier
subplot(6,1,3)
plot(t,y)         %plotting DSB-SC modulated signal
title('Amplitude Modulated DSB-SC Signal')
grid on;

%demodulation of DSB-SC
d=y.*yc;                %multiplying the modulated signal with cos(2pifct)
[b,a]=butter(5,0.1);     %butterworth filter
d1=filter(b,a,d);       %implementing the filter passing the modulated signal through filter
subplot(6,1,4)
plot(d1)                  %plotting demodulated signal
title('demodulated Signal')
grid on;

%frequency domain plots

%modulated signal
%Spectrum of modulated signal
N=length(t);
ymf=fftshift(fft(y,N)/N);       %using fft to calculate fourier transform and fftshift is used to center the fourier transform
f=(-N/2:N/2-1);                 %creating range for x axis
subplot(6,1,5)
plot(f,real(ymf),'b')          %plotting the real part of fourier transform of modulating signal
hold on;
plot(f,imag(ymf),'r')          %plotting the imagfinary part of fourier transform of modulating signal
title('frequency modulated signal')

%demodulated signal
%Spectrum of demodulated signal
N=length(t);
ydf=fftshift(fft(d1,N)/N);    %using fft to calculate fourier transform and fftshift is used to center the fourier transform
f=(-N/2:N/2-1);                %creating range for x axis
subplot(6,1,6)
plot(f,real(ydf),'b')        %plotting the real part of fourier transform of modulating signal
hold on;
plot(f,imag(ydf),'r')         %plotting the imagfinary part of fourier transform of modulating signal
title('frequency demodulated signal')