% =============================================================================
% Script      : signal_gen.m
% Description : Generates a noisy sine wave, converts it to 16-bit signed
%               binary format, and saves it as 'signal.data' for use as
%               input to the Verilog FIR filter testbench.
%
% Output      : signal.data  — 32 binary values (16-bit signed, 2's complement)
%
% Steps:
%   1. Generate a clean sine wave
%   2. Add random noise to it
%   3. Normalise and scale to 16-bit fixed-point integers
%   4. Convert to binary (2's complement) and save to file
%
% Author      : Hari Kumar (2022UGEC018)
% Institute   : NIT Jamshedpur
% Tool        : MATLAB 2018b
% =============================================================================

close all; clear all; clc;

%% ------- Step 1: Generate Sine Wave ----------------------------------------

fs   = 5;            % Sampling frequency (Hz)
Amp  = 1;            % Amplitude
t    = 0:1/fs:2*pi;  % Time vector

sine_wave = Amp * sin(t);

figure(1);
plot(t, sine_wave, 'b', 'LineWidth', 1.5);
xlabel('\bf Time (s)');
ylabel('\bf Amplitude');
title('\bf Clean Sine Wave');
grid on;

%% ------- Step 2: Add Random Noise ------------------------------------------

noise_amp  = 0.1;    % Noise amplitude limit
noise      = noise_amp * rand(1, length(sine_wave));
sine_noise = sine_wave + noise;

% Normalise to [-1, 1]
sine_norm = sine_noise / max(abs(sine_noise));

figure(2);
plot(1:length(sine_norm), sine_norm, 'r', 'LineWidth', 1.5);
xlabel('\bf Sample Index');
ylabel('\bf Amplitude');
title('\bf Sine Wave + Noise (Normalised)');
grid on;

%% ------- Step 3: Scale to 16-bit Fixed-Point Integer -----------------------

total_wordlength = 16;   % Total bit width
scaling          = 7;    % Fractional bits (scale factor = 2^7 = 128)

sine_noise_integers = round(sine_norm .* (2^scaling));

figure(3);
stem(1:length(sine_noise_integers), sine_noise_integers, 'filled');
xlabel('\bf Sample Index');
ylabel('\bf Amplitude (Integer)');
title('\bf Sine + Noise : Scaled to 16-bit Integer');
grid on;

%% ------- Step 4: Convert to Binary (2's Complement) and Save ---------------

% Wrap negative values using modulo for 2's complement representation
sine_noise_binary = dec2bin(mod(sine_noise_integers, 2^total_wordlength), total_wordlength);

yy  = cellstr(sine_noise_binary);
fid = fopen('signal.data', 'wt');
fprintf(fid, '%s \n', yy{:});
fclose(fid);

disp('signal.data generated successfully.');
disp(['Total samples written: ', num2str(length(yy))]);
