function [normalized_data, varargout] = gaussian_normalization(input,varargin)

% Normalisiere Input der Art, dass danach Mittelwert=0 und
% Standradabweichung=1 gilt.

args  = varargin;
nargs = length(args);

if isscalar(input) == 1 % Fall eines einfachen Skalars
     
    m=0;
    std_deviation = 1;
    
else
    
    if nargs == 0

        m             = mean(input);
        std_deviation = std(input);

    else 
            
        m = args{1};
        std_deviation = args{2};

    end
end

normalized_data = (input-m)./std_deviation;

varargout{1} = m;
varargout{2} = std_deviation;



