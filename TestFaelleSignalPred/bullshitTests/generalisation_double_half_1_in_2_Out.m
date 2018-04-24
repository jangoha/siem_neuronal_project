% Verscuh Input zu verdoppeln
% in = generate_common_weights(1,1,[-10,10]);
% [n_in, m, stdd] = gaussian_normalization(in);
diff=0;
vektor = -2:0.1:2;
faktor1 = 0.5;
faktor2 = 2;
schrittweite = 0.1;
anzahlIterationen = 1250;
momentumsFaktor = 0.1;

tanhParameter = {22,0.095}; % {a,b} -> a*tanh(b*in)

gewichtsInitialBelegung = -0.1;

in = 0.333333333333;


% for(b = 1:5)
%     in = b;
    comp = [faktor1*in faktor2*in]';
    net = generate_tanh_feedforward([1,20,2],[gewichtsInitialBelegung,-gewichtsInitialBelegung],'Bias','inactive','ActivFunParameter',tanhParameter);
    net = train(net,in, comp, schrittweite,momentumsFaktor, anzahlIterationen);
% end

for(vals = vektor)
in = vals;
comp = in*faktor;
% n_comp = gaussian_normalization(comp,m,stdd);



% net.Weights =  {-3.5813};
OutputVorher = test_net(net,in);
% tic
% for k=1:length(in);

% end
% toc

out = test_net(net,in);
% out = reverse_gaussian_normalization(n_out,m,stdd);
% out2 = test_net(net,0.3)
% [out, compp, inn, comp, in]


netcomponents= give_all(net,in,'all');
names = {'States','Activations'};
% asdasd=net.Weights

% for k=1:net.nLayers
%     k
%     table(netcomponents.internal_states{k},'VariableNames',names(1))
%     table(netcomponents.actvations{k},'VariableNames',names(2))
% end
% 
% table(out, comp, in,out, comp, in)
diff = diff + abs(faktor1*vals-out(1))+abs(faktor2*vals-out(2));
% if(faktor*vals-out> max(vektor)/2)
% disp([num2str(vals) ' berechnung ' num2str(out(1)) ' '  num2str(out(2)) ' abweichung ' num2str(faktor1*vals-out(1)) ' ' num2str(faktor2*vals-out(2))]);
% end
end
disp([num2str(diff/numel(vektor)) ' Mittlere Abweichung über ' num2str(numel(vektor)) ' Werte ']);
