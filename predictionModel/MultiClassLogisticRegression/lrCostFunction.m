function [J, grad] = lrCostFunction(theta, X, y, lambda)

m = length(y);

J = 0;
grad = zeros(size(theta));

hx = sigmoid(X*theta);
reg_term = (lambda/(2*m))*(sum(theta.^2) - theta(1).^2);

se = y.*log(hx) + (1-y).*log(1-hx);
J = (-1/m)*sum(se) + reg_term;


grad = (1/m)*(X')*(hx - y);
temp = theta;

temp(1) = 0;
grad = grad + (lambda/m)*temp;

grad = grad(:);

end
