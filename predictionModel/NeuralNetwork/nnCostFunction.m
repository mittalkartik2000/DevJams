function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);     
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% forward propagation

a1 = [ones(m,1) X];

z2 = (a1*Theta1');
a2 = [ones(size(z2,1),1) sigmoid(z2)];

h_theta = sigmoid(a2*Theta2');
a3 = h_theta;

y_matrix = eye(num_labels)(y,:);
%------------------------------------
%yb = zeros(m,num_labels);
%for i=1:m
% yb(i,y(i)) = 1;
%end 
%------------------------------------
J = (-sum(sum(y_matrix.*log(h_theta))) - sum(sum((1-y_matrix).*(log(1-h_theta)))))/m;

% REGULARIZATION
regularization_term = (lambda/(2*m))*((sum(sum(Theta1(:,2:end).^2))) + sum(sum(Theta2(:,2:end).^2)));
J = J + regularization_term;

% BACK PROPOGATION

%================================================================
%Sample by sample
%for t = 1:m
%    % Forward to calculate error for sample t
%    a_1 = X(t,:)';
%    a_1 = [1; a_1];
%           
%    z_2 = Theta1 * a_1;
%    
%    a_2 = sigmoid(z_2);
%    a_2 = [1; a_2];
%    
%    z_3 = Theta2 * a_2;
%    
%    a_3 = sigmoid(z_3);
%    
%    % Error
%    yt = y_matrix(t,:)';
%    delta_3 = a_3 - yt; 
%    
%    % Propagate error backwards
%    delta_2 = (Theta2' * delta_3) .* sigmoidGradient([1; z_2]);
%    delta_2 = delta_2(2:end);
%
%    dt2 = delta_3 * a_2';
%    dt1 = delta_2 * a_1';
% 
%    Theta2_grad = Theta2_grad + dt2;
%    Theta1_grad = Theta1_grad + dt1;
%end

%Theta1_grad = (1/m)*Theta1_grad;
%Theta2_grad = (1/m)*Theta2_grad;
%===============================================================

%===============================================================
%Without for-loop
d3 = a3 - y_matrix;                                             % has same dimensions as a3
d2 = (d3*Theta2).*[ones(size(z2,1),1) sigmoidGradient(z2)];     % has same dimensions as a2

D1 = d2(:,2:end)' * a1;    % has same dimensions as Theta1
D2 = d3' * a2;             % has same dimensions as Theta2

Theta1_grad = Theta1_grad + (1/m) * D1;
Theta2_grad = Theta2_grad + (1/m) * D2;
%===============================================================

% REGULARIZATION OF THE GRADIENT

Theta1_grad(:,2:end) = Theta1_grad(:,2:end) + (lambda/m)*(Theta1(:,2:end));
Theta2_grad(:,2:end) = Theta2_grad(:,2:end) + (lambda/m)*(Theta2(:,2:end));

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
