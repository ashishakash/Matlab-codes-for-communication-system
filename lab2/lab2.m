clc;
clear all;
close all;

fm=50; %modulating signal frequency(frequency of message signal)
fc=300; %carrier signal frequency
B=10; %modulation index
t=0:0.0001:0.5; %defining time period from 0 to 0.5s in 0.0001s interval


%considering amplitude of message and carrier signals to be 1
m=cos(2*pi*fm*t); %message signal
c=cos(2*pi*fc*t); %carrier signal
y=cos((2*pi*fc*t)+(B.*sin(2*pi*fm*t))); % frequency modulated signal(y=cos(2*pi*fc*t+integralof(messagesignal))


%plotting message signal
figure;
subplot(6,1,1);
plot(t,m); %plotting message signal
xlabel('Time(sec)');
ylabel('Amplitude');
title('message signal');
grid on;


%plotting modulated signal
subplot(6,1,2);
plot(t,y); %plotting modulated signal
xlabel('Time(sec)');
ylabel('Amplitude');
title('modulated signal');
grid on;


%plotting demodulated signal(demodulation is done using envelope detection)
%for demodulation of fm signal it is first differentiated to get slope and
%then passed through an envelope detector circuit which is basically a
%lowpass filter
x=diff(y); %differentiating the message signals
ydemod=abs(x); %taking absolute value
[b,a]=butter(10,0.014); %implementing butterworth lowpass fiter of order 10 with cutoff frequency 0.056
s1=filter(b,a,ydemod);  %using filter
subplot(6,1,3);
plot(s1); %plotting demodulated signal
xlabel('Time(sec)');
ylabel('Amplitude');
title('demodulated signal');
grid on;


%plotting frequency plot for message signal
ts=1/(10*fc);
fs=1/ts; %sampling frequency
mf=fftshift(fft(m))*ts; %calculating fourier transform of message signal using inbuilt function fft
delta=fs/length(mf);
f=-fs/2:delta:fs/2-delta;  %defining the x range of frequencies
subplot(6,1,4);
plot(f,abs(mf));  %plotting frquency plot of message signal(taking absolute value)
xlabel('Time(sec)');
ylabel('Amplitude');
title('frequency plot of message signal');
grid on;


%plotting frequency plot for modulated signal
yf=fftshift(fft(y))*ts; %calculaing fourier transform of modulated signal using fft
delta=fs/length(yf);
f=-fs/2:delta:fs/2-delta;  %defining the x range of frequencies
subplot(6,1,5);
plot(f,abs(yf)); %plotting frquency plot of modulated signal(taking absolute value)
xlabel('Time(sec)');
ylabel('Amplitude');
title('frequency plot of modulated signal');
grid on;


%plotting frequency plot for demodulated signal
ydef=fftshift(fft(s1))*ts;  %calculaing fourier transform of demodulated signal using fft
delta=fs/length(ydef);
f=-fs/2:delta:fs/2-delta;
subplot(6,1,6);
plot(f,abs(ydef)); %plotting frquency plot of demodulated signal(taking absolute value)
xlabel('Time(sec)');
ylabel('Amplitude');
title('frequency plot of demodulated signal');
grid on;