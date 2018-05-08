function get_review_output(review, trigger, simple_out, wahl)

string = sprintf('Review of %d net output set(s) :\n',length(wahl));
disp(string);

for i = 1 : length(wahl)
    time_per_cell(i) = ( trigger(i).marker.x_values(length(cell2mat(review.distances(i)))) / length(cell2mat(review.distances(i))) );
    str_ = sprintf('Output %d : Das Netz hat %dmal getriggert.\nDer mittlere Abstand der Netztrigger zum vorgegebenen Standard ist %f Zeiteinheiten.', i, sum(cell2mat(simple_out(i))), review.average_distance(i)*time_per_cell(i));    disp(str_)
end

end
