% Verscuh Input zu verdoppeln
% in = generate_common_weights(1,1,[-10,10]);
% [n_in, m, stdd] = gaussian_normalization(in);
diff=0;
vektor = -5:0.3:5;
faktor = 4;
schrittweite = 0.00001;
anzahlIterationen = 100000;
momentumsFaktor = 0.1;

gewichtsInitialBelegung = 1;

in = 0.333333333333;
comp = faktor*in;

ActivFunParameter = {6,0.6,0};


net = generate_tanh_feedforward([1,1],[gewichtsInitialBelegung,-gewichtsInitialBelegung],'Bias','inactive','ActivFunParameter',ActivFunParameter);
net.Activationfun = 'linear';

[net, delta_weights] = train(net,in, comp, schrittweite,momentumsFaktor, anzahlIterationen);

% net.Weights = {faktor/ActivFunParameter{1}^2};

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


netcomponents= give_all(net,in);
names = {'States','Activations'};
% asdasd=net.Weights

% for k=1:net.nLayers
%     k
%     table(netcomponents.internal_states{k},'VariableNames',names(1))
%     table(netcomponents.actvations{k},'VariableNames',names(2))
% end
% 
% table(out, comp, in,out, comp, in)
diff = diff + abs(faktor*vals-out);
if(faktor*vals-out> max(vektor)/2)
% disp([num2str(vals) ' berechnung ' num2str(out) ' abweichung ' num2str(faktor*vals-out)]);
end
end
disp([num2str(diff/numel(vektor)) ' Mittlere Abweichung über ' num2str(numel(vektor)) ' Werte ']);
