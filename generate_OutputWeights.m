function weights = generate_OutputWeights (net,varargin)

% generiert Gewichte der Outputschicht je nach argument in varargin.
% Im Normalfall werden in generate_tanh_feedforward die Gewichte auf 'identitiy' gesetzt.

% % % % Diese Methode ist bisher nicht in dem Netz aungebaut, da sich das 
% % % % ledigliche Abgreifen der Aktivierung der Outputneuronen als hinreichend erwiesen hat. 

args = varargin; 
nargs= length(args);

for i=1:2:nargs
 switch args{i},
      case 'identity', weights = 'identity';
      case 'weight_range',
          range = args{i+1};
          weights = generate_common_weights(net.nOutputUnits, net.nOutputUnits, range);
          
      otherwise error('Choosen option does not exist'); 
 end      
end