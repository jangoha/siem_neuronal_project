% Verscuh Input zu verdoppeln
in = generate_common_weights(1,1,[-10,10]);
% [n_in, m, stdd] = gaussian_normalization(in);

comp = in;
% n_comp = gaussian_normalization(comp,m,stdd);


net = generate_tanh_feedforward([1,1],'Bias','unactive');

tic
% for k=1:length(in);
net = train(net,in, comp, 0.1,0.1, 1000);
% end
toc

n_out = test_net(net,in);
% out = reverse_gaussian_normalization(n_out,m,stdd);
% out2 = test_net(net,0.3)
% [out, compp, inn, comp, in]


netcomponents= give_all(net,in,'all');
names = {'States','Activations'};

for k=1:net.nLayers
    k
    table(netcomponents.internal_states{k},'VariableNames',names(1))
    table(netcomponents.actvations{k},'VariableNames',names(2))
end

% table(out, comp, in,n_out, n_comp, n_in)

