%Initialization
close all;
clc;

%=====Loading Data==========
pkg load io
dat = xlsread ('travel.xlsx', 'Worksheet');
% quarter   mode     age      duration   budget        visits
X=[dat(:,2) dat(:,4) dat(:,8) dat(:,10) dat(:,13)/1000];

y = [dat(:,5)] - 9;
%========Data Processing=========
%Feature 5 - budget
budget = [X(:, 5)];
m = size(X, 1);
for i = 1:m,
  if budget(i) < 500,
    X(i, 5) = 1;
  elseif budget(i) >= 500 && budget(i) < 1500,
    X(i, 5) = 2;
  elseif budget(i) >= 1500 && budget(i) < 3000,
    X(i, 5) = 3;
  elseif budget(i) >= 3000 && budget(i) < 5000,
    X(i, 5) = 4;
  else,%     budget(i) >= 5000,
    X(i, 5) = 5; 
  endif
endfor

%======Training Data========
lambda = 0;
num_labels = 83
[all_theta] = oneVsAll(X, y, num_labels, lambda);


%======Testing============
pred = predictOneVsAll(all_theta, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

