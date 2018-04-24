clear
clc

x = linspace(-1,1,100);
y = sin(10*x+pi/2);
fst_y_values = y(1:5);
% weight_range = [-1,1];
% nEndNods = 1;
% nStartingNods = 6;
% fst_y_values = weight_range(1) + (weight_range(2)-weight_range(1)).*rand(nEndNods,nStartingNods);
tic
[new_y myNet] = adaptive_plotting(x,fst_y_values,1000);
toc


figure(5)
plot(x,y,x,new_y,'+');

%%
% myNet.TrainingStatus='trained';
% y = sinc(10*(x+0.3));
% 
% for(a=50+(1:10))
%     outputNet(a)=test_net(myNet,y((a-48:a))');
% end
% 
% toc