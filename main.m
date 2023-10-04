clc; 
clear; 
close all;

%% Initialization of the audio file
[x, fs] = audioread('dc-voice.wav');
x = x(:,1); % using only one channel
x = RemoveZeros(x);
[~, x_seq] = ReduceBits(x, 7); % binary sequence
snr_list = 0:5:15;

file = sprintf('results/error-probability.txt');    
if isfile(file)
    delete(file)
end
fileID = fopen(file, 'a');

%% QPSK without Phase Ambiguity
Eb = 1;
fprintf(fileID, '\n-----------------\n\nQPSK without Phase Ambiguity\n');
for j = 1:3
    if isequal(j,1)
        coding = 'plain';
    elseif isequal(j,2)
        coding = '15-11';
    elseif isequal(j,3)
        coding = '15-7';
    end
    
    if isequal(coding, 'plain')
        codingname = 'No Coding';
    elseif isequal(coding, '15-11')
        codingname = 'BCH(15,11)';
    elseif isequal(coding, '15-7')
        codingname = 'BCH(15,7)';
    end
       
    fprintf(fileID, '--- Coding = %s\n', codingname);
    
    for snr=snr_list
        sprintf('Calculating for snr=%d and coding=%s', snr, codingname)
        N0 = Eb / 10^(snr/10);
        audio_file = sprintf('results/voice/qpsk/coding=%s-snr=%d.wav', codingname, snr);
        [bit_err, theoretic_err, output_audio] = QPSKSimulator(x_seq, 0, coding, Eb, N0);
       
        if isequal(coding, '15-11')
            N0 = N0 * 15 / 11;
        elseif isequal(coding, '15-7')
            N0 = N0 * 15 / 7;
        end
        
        % saving the outputs
        
        fprintf(fileID, '------ SNR/bit = %0.3fdB\n', 10 * log10(Eb/N0));
        fprintf(fileID, '--------- Practical BER: %d\n', bit_err);
        fprintf(fileID, '--------- Theoretical BER: %d\n\n', theoretic_err);
        
        audiowrite(audio_file, output_audio, fs);
        
    end
end

%% QPSK with Phase Ambiguity
Eb = 1;
fprintf(fileID, '\n-----------------\n\nQPSK with Phase Ambiguity\n');
for j = 1:3
    if isequal(j,1)
        coding = 'plain';
    elseif isequal(j,2)
        coding = '15-11';
    elseif isequal(j,3)
        coding = '15-7';
    end
    
    if isequal(coding, 'plain')
        codingname = 'No Coding';
    elseif isequal(coding, '15-11')
        codingname = 'BCH(15,11)';
    elseif isequal(coding, '15-7')
        codingname = 'BCH(15,7)';
    end
    
    fprintf(fileID, '--- Coding = %s\n', codingname);
    
    for snr=snr_list
        sprintf('Calculating for snr=%d and coding=%s', snr, codingname)
        N0 = Eb / 10^(snr/10);
        audio_file = sprintf('results/voice/qpsk/coding=%s-snr=%d.wav', codingname, snr);
        [bit_err, theoretic_err, output_audio] = QPSKSimulator(x_seq, 1, coding, Eb, N0);
       
        if isequal(coding, '15-11')
            N0 = N0 * 15 / 11;
        elseif isequal(coding, '15-7')
            N0 = N0 * 15 / 7;
        end
        
        % saving the outputs
        
        fprintf(fileID, '------ SNR/bit = %0.3fdB\n', 10 * log10(Eb/N0));
        fprintf(fileID, '--------- Practical BER: %d\n', bit_err);
        fprintf(fileID, '--------- Theoretical BER: %d\n\n', theoretic_err);
        
        audiowrite(audio_file, output_audio, fs);
        
    end
end

%% DQPSK with Phase Ambiguity
Eb = 1;
fprintf(fileID, '\n-----------------\n\nDQPSK with Phase Ambiguity\n');
for j = 1:3
    if isequal(j,1)
        coding = 'plain';
    elseif isequal(j,2)
        coding = '15-11';
    elseif isequal(j,3)
        coding = '15-7';
    end
    
    if isequal(coding, 'plain')
        codingname = 'No Coding';
    elseif isequal(coding, '15-11')
        codingname = 'BCH(15,11)';
    elseif isequal(coding, '15-7')
        codingname = 'BCH(15,7)';
    end
    
    fprintf(fileID, '--- Coding = %s\n', codingname);
    
    for snr=snr_list
        sprintf('Calculating for snr=%d and coding=%s', snr, codingname)
        N0 = Eb / 10^(snr/10);
        audio_file = sprintf('results/voice/dqpsk/coding=%s-snr=%d.wav', codingname, snr);
        [bit_err, theoretic_err, output_audio] = DQPSKSimulator(x_seq, 1, coding, Eb, N0);
       
        if isequal(coding, '15-11')
            N0 = N0 * 15 / 11;
        elseif isequal(coding, '15-7')
            N0 = N0 * 15 / 7;
        end
        
        % saving the outputs
        fprintf(fileID, '------ SNR/bit = %0.3fdB\n', 10 * log10(Eb/N0));
        fprintf(fileID, '--------- Practical BER: %d\n', bit_err);
        fprintf(fileID, '--------- Theoretical BER: %d\n\n', theoretic_err);
        
        audiowrite(audio_file, output_audio, fs);
        
    end
    
end
fclose(fileID);
