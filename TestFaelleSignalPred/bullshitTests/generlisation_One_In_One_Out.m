% Verscuh Input zu verdoppeln
% in = generate_common_weights(1,1,[-10,10]);
% [n_in, m, stdd] = gaussian_normalization(in);
for(vals = -3:0.1:3)
in = vals;
comp = in*0.5;
% n_comp = gaussian_normalization(comp,m,stdd);


net = generate_tanh_feedforward([1,1],[-2,2],'Bias','inactive');
% net.Weights =  {-3.5813};
OutputVorher = test_net(net,in);
% tic
% for k=1:length(in);
net = train(net,in, comp, 0.1,0.1, 150);
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
disp([num2str(vals) ' berechnung ' num2str(out) ' abweichung ' num2str(0.5.*vals-out)]);
end