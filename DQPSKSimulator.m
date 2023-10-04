function [bit_err, theoretic_err, output_audio] = DQPSKSimulator(bit_seq, phase, coding, Eb, N0)
%QPSKSIMULATOR Simulates the QPSK with the given information
% Encoding with the given coding
bits_encoded = bit_seq;
if isequal(coding, 'plain')
    bits_encoded = bit_seq;
elseif isequal(coding, '15-11')
    bits_encoded = EncodeBCH11(bit_seq);
    N0 = N0 * 15 / 11;
elseif isequal(coding, '15-7')
    bits_encoded = EncodeBCH7(bit_seq);
    N0 = N0 * 15 / 7;
end

% QPSK Modulation
bits_modulated = DQPSKModulation(bits_encoded, Eb);

% Channel
bits_received = Channel(bits_modulated, N0, phase);

% QPSK Demodulation
bits_demodulated = DQPSKDemodulation(bits_received, isequal(mod(length(bits_encoded), 2), 1));
% biterr(bits_encoded=='1', bits_demodulated=='1')
% Decoding
if isequal(coding, 'plain')
    bits_decoded = bits_demodulated;
elseif isequal(coding, '15-11')
    bits_decoded = DecodeBCH11(bits_demodulated);
elseif isequal(coding, '15-7')
    bits_decoded = DecodeBCH7(bits_demodulated);
end

bits_decoded = bits_decoded(1:length(bit_seq));

% Bit Error
bit_err = biterr(bit_seq=='1', bits_decoded=='1')/length(bit_seq);
theoretic_err = (1 - (1 - qfunc(sqrt(2*Eb/N0)))^2)/2;

if isequal(coding, '15-11')
    p = theoretic_err;
    theoretic_err = 0;
    for i=2:15
        theoretic_err = theoretic_err + nchoosek(15, i)*p^i*(1-p)^(15-i)*i/15;
    end
elseif isequal(coding, '15-7')
    p = theoretic_err;
    theoretic_err = 0;
    for i=3:15
        theoretic_err = theoretic_err + nchoosek(15, i)*p^i*(1-p)^(15-i)*i/15;
    end
end

output_audio = ConvertBits(bits_decoded);
end

