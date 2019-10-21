function [all_theta] = oneVsAll(X, y, num_labels, lambda)

m = size(X, 1);
n = size(X, 2);

all_theta = zeros(num_labels, n + 1);

X = [ones(m, 1) X];

init_theta = zeros(n + 1, 1);

opt = optimset('GradObj', 'on', 'MaxIter', 50);

for c = 1:num_labels
  [theta] = fmincg (@(t)(lrCostFunction(t, X, (y == c), lambda)), init_theta, opt);
  all_theta(c, :) = theta';
end

end