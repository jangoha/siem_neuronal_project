function signal = cut_signal(signal,startIndex,percent)

signal = signal(startIndex:end);
stopper = floor(length(signal)*percent);
signal = signal(1:stopper);