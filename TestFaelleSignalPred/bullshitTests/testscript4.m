x=linspace(-1,1,15);
y=x.^2;
nIn = 4;
nOut= 2;
net = generate_tanh_feedforward([nIn,nOut]);
in=y(1:nIn)';
trainmaterial=y(nIn+1:nIn+nOut)';
xp=x(nIn+1:nIn+nOut);
learningparameter = 0.01;
nIterations = 9999;


tic
net = deltaRegel(net,in,trainmaterial,learningparameter,nIterations);

z=test_net(net,in);
toc


in2=y(8:11)';
z2 = test_net(net,in2)';
comp = y(12:13);
xp2=x(12:13);


plot(x,y,xp,z,'o',xp,trainmaterial,'x',xp2,z2,'o',xp2,comp,'x');shg
