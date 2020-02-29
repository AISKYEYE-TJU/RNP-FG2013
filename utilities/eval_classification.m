function accuracy = eval_classification(result_file)

load(result_file);

correct = 0;
total = 0;
for i = 1 : length(classify_results)
    correct = correct+sum(classify_results{i}==i);
    total = total+length(classify_results{i});
end

accuracy = correct/total;