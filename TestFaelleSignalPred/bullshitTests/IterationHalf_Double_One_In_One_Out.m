% Verscuh Input zu verdoppeln
% in = generate_common_weights(1,1,[-10,10]);
% [n_in, m, stdd] = gaussian_normalization(in);
diff=0;
vektor = -6:0.01:6;
faktor = 0.5;
schrittweite = 0.1;
anzahlIterationen = 50;
momentumsFaktor = 0.1;

gewichtsInitialBelegung = -1.;
for(vals = vektor)
in = vals;
comp = in*faktor;
% n_comp = gaussian_normalization(comp,m,stdd);


net = generate_tanh_feedforward([1,1],[gewichtsInitialBelegung,-gewichtsInitialBelegung],'Bias','active');
% net.Weights =  {-3.5813};
OutputVorher = test_net(net,in);
% tic
% for k=1:length(in);
net = train(net,in, comp, schrittweite,momentumsFaktor, anzahlIterationen);
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
diff = diff + abs(faktor*vals-out);
if(faktor*vals-out> max(vektor)/2)
% disp([num2str(vals) ' berechnung ' num2str(out) ' abweichung ' num2str(faktor*vals-out)]);
end
end
disp([num2str(diff/numel(vektor)) ' Mittlere Abweichung über ' num2str(numel(vektor)) ' Werte ']);
