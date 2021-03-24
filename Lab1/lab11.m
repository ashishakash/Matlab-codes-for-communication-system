clc;
clear all;
close all;

m=1;   %modulation index
Am=5;  %Amplitude of modulating signal
fa=5; %frequency of modulating signal
Ta=1/fa;  %timeperiod
t=0:Ta/999:6*Ta; %creating values for x axis

%message signal
ym=Am*cos(2*pi*fa*t); %message signal
figure(1)
subplot(6,1,1)     %used to plot graphs on same figure
plot(t,ym)
title('Modulating signal')

%carrier signal
Ac=Am/m;  %carrier amplitude
fc=500;   %carrier frequency
Tc=1/fc;
yc=Ac*cos(2*pi*fc*t);  %carrier signal
subplot(6,1,2)
plot(t,yc)
grid on;
title('Carrier signal')

%Conventional AM Modulation
y = Ac * (1+m*cos(2*pi*fa*t)).*cos(2*pi*fc*t);  %conventional AM
subplot(6,1,3)
plot(t,y)
title('Amplitude Modulated Signal')
grid on;

%demodulation of conventional AM
d=y.*yc;              %multiplying the modulated signal with cos(2pifct)
[b,a]=butter(2,0.1);  %butterworth filter
d1=filter(b,a,d);     %implementing the filter passing the modulated signal through filter
subplot(6,1,4)     
plot(d1)
title('demodulated Signal')
grid on;


%frequency domain plots

%modulated signal
%Spectrum of modulated signal
N=length(t);
ymf=fftshift(fft(y,N)/N);   %using fft to calculate fourier transform and fftshift is used to center the fourier transform
f=(-N/2:N/2-1);             %creating range for x axis
subplot(6,1,5)
plot(f,real(ymf),'b')  %plotting the real part of fourier transform of modulating signal
hold on;
plot(f,imag(ymf),'r')   %plotting the imagfinary part of fourier transform of modulating signal
title('frequency plot of AM modulated signal')


%demodulated signal

%Spectrum of demodulated signal
N=length(t);
ydf=fftshift(fft(d1,N)/N);   %using fft to calculate fourier transform and fftshift is used to center the fourier transform
f=(-N/2:N/2-1);              %creating range for x axis
subplot(6,1,6)
plot(f,real(ydf),'b')  %plotting the real part of fourier transform of demodulating signal
hold on;
plot(f,imag(ydf),'r')    %plotting the imagfinary part of fourier transform of demodulating signal
title('frequency plot of AM demodulated signal')