function plot_variables = compute_plotvariables(net,test_samples,method,smooth)

% erzeugt aus testdatensätzen Werte die geplottet werden können. Dabei
% werden entweder alle test-daten eingespeist ('continuous feed')oder das Netz nutzt seinen
% eigenen Output als Input ('self propagation')und versucht so, einmalig von startwerten ausgehen, Vorraussagen etc. zu treffen.
% Zusätzlich kann mit Smooth der Output der Daten noch um den
% Mittelwertgestaucht oder gestreckt werden.

% Wertegenerierung
switch method
    case 'continuous feed'
        
        
        loops = test_samples.number_samples;
        plot_variables.x_values = cell(1,loops);
        plot_variables.y_values = cell(1,loops);
        
        for j=1:loops
            in = test_samples.y_values{j};
            start_index = test_samples.signal_indices{j}(2)+1;
            end_index   = start_index+net.nOutputUnits-1;
            plot_variables.x_values{j} = test_samples.original_x_values(start_index:end_index);
            plot_variables.y_values{j} = test_net(net,in)';
        end
        
    case 'self propagation'
        
        loops = test_samples.number_samples;
        plot_variables.x_values = cell(1,loops);
        plot_variables.y_values = cell(1,loops);
        
        shift = net.nOutputUnits;
        delta = net.nOutputUnits-net.nInputUnits;
        
        in = test_samples.original_y_values(1:net.nInputUnits);
        
        for j=1:loops
            
            para1= j-1;
            para2= shift*para1;
            start_index = 1+net.nInputUnits+para2;
            end_index = net.nInputUnits+net.nOutputUnits+para2;
            
            plot_variables.x_values{j} = test_samples.original_x_values(start_index:end_index);
            plot_variables.y_values{j} = test_net(net,in)';
            
            
            in = [in,plot_variables.y_values{j}];
            in = in(net.nInputUnits+delta+1:end);
            
            
        end
       
        
    case 'both'
        
        plot_variables.continuous_feed = compute_plotvariables(net,test_samples,'continuous feed',smooth);
        plot_variables.self_propagation = compute_plotvariables(net,test_samples,'self propagation',smooth);
        return
end

% Smoothing der y-Werte
switch smooth
    case 'smooth on'
        loops = test_samples.number_samples;
        for k=1:loops
            
            smoothed_y = plot_variables.y_values{k};
            middle = mean(smoothed_y);
            smoothed_y = 0.5*(smoothed_y-middle)+middle;
            plot_variables.y_values{k} = smoothed_y;
                
        end
        
    otherwise
        
end


