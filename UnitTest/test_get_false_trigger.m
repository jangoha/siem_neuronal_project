%   Test 1 :
test_out = [5 6 7 8 9];

test_trig = [1 5 10];

assert (get_false_trigger(test_trig, test_out) == 1);


%   Test 2 :
test_out = [ 4 5 6 13 14 18 20 25];

test_trig = [3 15 30];

assert (get_false_trigger(test_trig, test_out) == 0);

%   Test 3 :
test_out = [4 5 6 7 8 9];

test_trig = [5 100 200];

assert (get_false_trigger(test_trig, test_out) == 2);





        % plot(ausgabeReview,'-.')
        % legend('trigger','netzausgabe','ausgabeReview');
        % assert(sum(ausgabeReview)==3+2);
        % title('testfall 1')