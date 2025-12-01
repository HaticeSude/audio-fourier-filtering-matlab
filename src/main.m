%% =========================================================================
%  Audio Signal Processing with FFT and Low-Pass Filtering
%  Author: Hatice Sude Mutlu
%  Description:
%       This script loads an audio signal, visualizes it in the time domain,
%       computes its frequency spectrum using FFT, applies a low-pass filter,
%       reconstructs the filtered signal, compares both signals, and saves
%       the filtered audio to disk.
% =========================================================================

clear; close all; clc;

%% 1. LOAD AUDIO FILE & TIME-DOMAIN VISUALIZATION
% MATLAB’s sample audio (handel.mat) is converted to .wav and used as input.

load handel.mat                          % Load sample audio signal
audiowrite('ornek_ses.wav', y, Fs);      % Convert to WAV format

[signal, Fs] = audioread('ornek_ses.wav'); % Read WAV file
t = (0:length(signal)-1) / Fs;            % Time vector

figure;
plot(t, signal, 'LineWidth', 1.2)
xlabel('Time (s)')
ylabel('Amplitude')
title('Original Audio Signal (Time Domain)')
grid on;

%% 2. APPLYING FFT (FREQUENCY-DOMAIN TRANSFORMATION)
% Compute the frequency components of the signal using Fast Fourier Transform.

N = length(signal);           % Signal length
Y = fft(signal);              % FFT computation
f = (0:N-1) * (Fs/N);         % Frequency axis (Hz)

magnitude = abs(Y) / N;       % Normalized magnitude spectrum

figure;
plot(f(1:round(N/2)), magnitude(1:round(N/2)), 'LineWidth', 1.1)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Frequency Spectrum of the Signal')
grid on;

%% 3. LOW-PASS FILTERING IN FREQUENCY DOMAIN
% Suppress all frequencies above 1500 Hz.

cutoff = 1500;                          % Cutoff frequency
mask = double(f < cutoff);              % Create binary mask
Y_filtered = Y .* mask(:);              % Apply mask on frequency spectrum

%% 4. RECONSTRUCTION & COMPARISON
% Convert filtered spectrum back to time domain and compare both signals.

signal_filtered = real(ifft(Y_filtered));   % Inverse FFT (keep only real part)

figure;
subplot(2,1,1)
plot(t, signal, 'LineWidth', 1.1)
title('Original Audio Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;

subplot(2,1,2)
plot(t, signal_filtered, 'LineWidth', 1.1)
title('Filtered Audio Signal (Low-Pass 1500 Hz)')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;

%% 5. SAVE FILTERED SIGNAL
% Save the filtered audio to a .wav file.

audiowrite('filtrelenmis_ses.wav', signal_filtered, Fs);
% sound(signal_filtered, Fs);   % Optional: Play the filtered audio

