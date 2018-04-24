

clear
clc
tic
n = 200;
i = 4;
m = 1;
s = 5;
h = 200;

x = linspace(-1,1,n);
y = sin(10*x+pi/2);
q = sinc(10*(x+0.3));
p = x.^2;



t1 = [y(s:s+i)'];
t2 = [q(s:s+i)'];
t3 = [p(s:s+i)'];
xp = [x(s:s+i)']; 


comp1 = [y(s+i+1:s+i+m)'];
comp2 = [q(s+i+1:s+i+m)'];
comp3 = [p(s+i+1:s+i+m)'];
xcomp = [x(s+i+1:s+i+m)'];

a = 3;
b = 60;
c = 80;

gewichte=[-0.1,0.1];

net1 = generate_tanh_feedforward([i+1,a,m],gewichte,'Bias','inactive');
net2 = generate_tanh_feedforward([i+1,a,m],gewichte,'Bias','inactive');
net3 = generate_tanh_feedforward([i+1,a,m],gewichte,'Bias','inactive');



    net1 = train(net1,t1, comp1, 0.1,0.1, h);
    net1.TrainingStatus = 'untrained';
    net2 = train(net2,t2, comp2, 0.1,0.1, h);
    net2.TrainingStatus = 'untrained';
    net3 = train(net3,t3, comp3, 0.1,0.1, h);
    net3.TrainingStatus = 'untrained';
    
final1 = test_net(net1,t1);
final2 = test_net(net2,t2);
final3 = test_net(net3,t3);

figure(55)
clf(figure(55))
hold on
% grf(1) = figure(1);
pl1 = plot(xcomp',comp1','x',xcomp',final1','o');
pl2 = plot(x,y);
title({['Neuronales Netz an f=sin(5x+pi/2), bei ' ,num2str(h),' Iteration der BP'];['und Netzstruktur ',mat2str(net1.Structure)]});
legend('Zielpunkte', 'Punkte aus NN', 'Trainingsfunktion','location','northwest');


toc



