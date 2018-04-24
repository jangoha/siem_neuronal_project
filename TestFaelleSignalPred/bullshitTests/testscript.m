clear;
clc;
tic
n = 200;
i = 4;
m = 56;
s = 1;
h = 999999;

x = linspace(-1,1,n);
y = sin(10*x+pi/2+1);
q = sinc(10*(x+0.3));
p = x.^2;


% for s=1:5
t1 = [y(s:s+i-1)'];
t2 = [q(s:s+i-1)'];
t3 = [p(s:s+i-1)'];
xp = [x(s:s+i-1)']; 


comp1 = [y(s+i+1:s+i+m)'];
comp2 = [q(s+i+1:s+i+m)'];
comp3 = [p(s+i+1:s+i+m)'];
xcomp = [x(s+i+1:s+i+m)'];

a = 30;
b = 60;
c = 80;

net1 = generate_tanh_feedforward([i,a,m],'Bias','active');
net2 = generate_tanh_feedforward([i,a,m],'Bias','active');
net3 = generate_tanh_feedforward([i,a,m],'Bias','active');


    net1 = train(net1,t1, comp1, 0.01,0.1, h);
    net1.TrainingStatus = 'untrained';
    net2 = train(net2,t2, comp2, 0.01,0.1, h);
    net2.TrainingStatus = 'untrained';
    net3 = train(net3,t3, comp3, 0.01,0.1, h);
    net3.TrainingStatus = 'untrained';
    
    

final1 = test_net(net1,t1);
final2 = test_net(net2,t2);
final3 = test_net(net3,t3);


clf(figure(1))
figure(1)
hold on
% grf(1) = figure(1);
pl1 = plot(xcomp',comp1','x',xcomp',final1','o');
pl2 = plot(x,y);
title({['Neuronales Netz an f=sin(5x+pi/2), bei ' ,num2str(h),' Iteration der BP'];['und Netzstruktur ',mat2str(net1.Structure)]});
legend('Zielpunkte', 'Punkte aus NN', 'Trainingsfunktion','location','northwest');

clf(figure(2))
figure(2)
hold on
% grf(2) = figure(2);
pl3 = plot(xcomp',comp2','x',xcomp',final2','o');
pl4 = plot(x,q);
title({['Neuronales Netz an f=sinc[10 (x+0.3)], bei ' ,num2str(h),' Iteration der BP'];['und Netzstruktur ',mat2str(net1.Structure)]});
legend('Zielpunkte', 'Punkte aus NN', 'Trainingsfunktion','location','northwest');


clf(figure(3))
figure(3)
hold on
% grf(3) = figure(3);
pl5 = plot(xcomp',comp3','x',xcomp',final3','o');
pl6 = plot(x,p);
title({['Neuronales Netz an f=x^2, bei ' ,num2str(h),' Iteration der BP'];['und Netzstruktur ',mat2str(net1.Structure)]});
legend('Zielpunkte', 'Punkte aus NN', 'Trainingsfunktion','location','southwest');
% end
toc
%%

test1 = [y(i+m+1:i+m+i)'];
test2 = [q(i+m+1:i+m+i)'];
test3 = [p(i+m+1:i+m+i)'];
xtest = [x(i+m+1:i+m+i)'];

compp1 = [y(i+m+i+1:i+m+i+m)'];
compp2 = [q(i+m+i+1:i+m+i+m)'];
compp3 = [p(i+m+i+1:i+m+i+m)'];
xcompp = [x(i+m+i+1:i+m+i+m)'];


finall1 = test_net(net1,test1);
finall2 = test_net(net2,test2);
finall3 = test_net(net3,test3);

% clf(figure(1))
figure(1)
hold on
% grf(1) = figure(1);
plot(xcompp',compp1','x',xcompp',finall1','o');
% pl2 = plot(x,y);
title({['Neuronales Netz an f=sin(5x+pi/2), bei ' ,num2str(h),' Iteration der BP'];['und Netzstruktur ',mat2str(net1.Structure)]});
legend('Zielpunkte', 'Punkte aus NN', 'Trainingsfunktion','location','northwest');

% clf(figure(2))
figure(2)
hold on
% grf(2) = figure(2);
 plot(xcompp',compp2','x',xcompp',finall2','o');
% pl4 = plot(x,q);
title({['Neuronales Netz an f=sinc[10 (x+0.3)], bei ' ,num2str(h),' Iteration der BP'];['und Netzstruktur ',mat2str(net1.Structure)]});
legend('Zielpunkte', 'Punkte aus NN', 'Trainingsfunktion','location','northwest');


% clf(figure(3))
figure(3)
hold on
% grf(3) = figure(3);
plot(xcompp',compp3','x',xcompp',finall3','o');
% pl6 = plot(x,p);
title({['Neuronales Netz an f=x^2, bei ' ,num2str(h),' Iteration der BP'];['und Netzstruktur ',mat2str(net1.Structure)]});
legend('Zielpunkte', 'Punkte aus NN', 'Trainingsfunktion','location','southwest');

%%

test1 = [y(i+m+1:i+m+i)'];
test2 = [q(i+m+1:i+m+i)'];
test3 = [p(i+m+1:i+m+i)'];
xtest = [x(i+m+1:i+m+i)'];

compp1 = [y(i+m+i+1:i+m+i+m)'];
compp2 = [q(i+m+i+1:i+m+i+m)'];
compp3 = [p(i+m+i+1:i+m+i+m)'];
xcompp = [x(i+m+i+1:i+m+i+m)'];

finall1 = test_net(net1,test1);
finall2 = test_net(net2,test2);
finall3 = test_net(net3,test3);

% clf(figure(1))
figure(1)
hold on
% grf(1) = figure(1);
plot(xcompp',compp1','x',xcompp',finall1','o');
% pl2 = plot(x,y);
title({['Neuronales Netz an f=sin(5x+pi/2), bei ' ,num2str(h),' Iteration der BP'];['und Netzstruktur ',mat2str(net1.Structure)]});
legend('Zielpunkte', 'Punkte aus NN', 'Trainingsfunktion','location','northwest');

% clf(figure(2))
figure(2)
hold on
% grf(2) = figure(2);
 plot(xcompp',compp2','x',xcompp',finall2','o');
% pl4 = plot(x,q);
title({['Neuronales Netz an f=sinc[10 (x+0.3)], bei ' ,num2str(h),' Iteration der BP'];['und Netzstruktur ',mat2str(net1.Structure)]});
legend('Zielpunkte', 'Punkte aus NN', 'Trainingsfunktion','location','northwest');


% clf(figure(3))
figure(3)
hold on
% grf(3) = figure(3);
plot(xcompp',compp3','x',xcompp',finall3','o');
% pl6 = plot(x,p);
title({['Neuronales Netz an f=x^2, bei ' ,num2str(h),' Iteration der BP'];['und Netzstruktur ',mat2str(net1.Structure)]});
legend('Zielpunkte', 'Punkte aus NN', 'Trainingsfunktion','location','southwest');
