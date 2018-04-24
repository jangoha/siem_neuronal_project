
diff=0;
vektor = -2:0.003:2;
faktor1 = 0.5;
faktor2 = 2;
schrittweite = 0.001;
anzahlIterationen = 300;
momentumsFaktor = 0.1;

tanhParameter = {3,0.6,0}; % {a,b} -> a*tanh(b*in)

gewichtsInitialBelegung = -1;

in1 = 0.3;

strc = [1,50,2];

    comp = [faktor1*in1 faktor2*in1]';
    net = generate_tanh_feedforward(strc,[gewichtsInitialBelegung,-gewichtsInitialBelegung],'Bias','inactive','ActivFunParameter',tanhParameter);
    net = train(net,in1, comp, schrittweite,momentumsFaktor, anzahlIterationen);

% [n_vektor,meann,stdd] = gaussian_normalization(vektor);

for(vals = vektor)
in = vals;
% comp = in*faktor;





% OutputVorher = test_net(net,in);

out = test_net(net,in);

% vals = reverse_gaussian_normalization(vals,meann,stdd);


diff = diff + abs(faktor1*vals-out(1))+abs(faktor2*vals-out(2));

end
disp([num2str(diff/numel(vektor)) ' Mittlere Abweichung über ' num2str(numel(vektor)) ' Werte ']);

netcomponents = give_all(net,in1)
netcomponents.activations{3}


