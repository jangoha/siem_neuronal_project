length = 10;
testInput = zeros(length,1);
testInput(2)= 1;
testInput(10)= 1;

testInput(3)=1;

trigger  = zeros(length,1);
trigger(5)= 1;
trigger(10)= 1;

figure(888);
hold off
plot(trigger, '-x');
hold on
plot(testInput,'-o');
triggerInCell = struct('marker',struct('y_values',trigger));
ausgabeReview = cell2mat(review_net_output(mat2cell(testInput,numel(testInput)),triggerInCell,1));

plot(ausgabeReview,'-.')
legend('trigger','netzausgabe','ausgabeReview');
assert(sum(ausgabeReview)==3+2);
title('testfall 1')
clear all;

length = 10;
testInput = zeros(length,1);
% testInput(2)= 1;
% testInput(6)= 1;
% testInput(3)=1;
testInput(10)= 1;

trigger  = zeros(length,1);
trigger(5)= 1;
trigger(8)= 1;
trigger(9)= 1;

figure(8888);
hold off
plot(trigger, '-x');
hold on
plot(testInput,'-o');
triggerInCell = struct('marker',struct('y_values',trigger));
ausgabeReview = cell2mat(review_net_output(mat2cell(testInput,numel(testInput)),triggerInCell,1));

plot(ausgabeReview,'-*')
legend('trigger','netzausgabe','ausgabeReview');
title('testfall 2')
assert(sum(ausgabeReview)==1);

