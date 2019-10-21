%Initialization
close all;
clc;

%=====Loading Data==========
pkg load io
dat = xlsread ('travel.xlsx', 'Worksheet');
% quarter   mode     age      duration   budget
visits = [dat(:,11)]
m = size(visits, 1);
num = [0 0 0 0 0 0 0 0 0 0];
for i = 1:m,
  if visits(i) < 500,
    X(i, 6) = 1;
    num(1) = num(1) + 1;
  elseif visits(i) >= 500 && visits(i) < 1000,
    X(i, 6) = 2;
    num(2) = num(2) + 1;
  elseif visits(i) >= 1000 && visits(i) < 1500,
    X(i, 6) = 3;
    num(3) = num(3) + 1;
  elseif visits(i) >= 1500 && visits(i) < 2000,
    X(i, 6) = 4;
    num(4) = num(4) + 1;
  elseif visits(i) >= 2000 && visits(i) < 2500,
    X(i, 6) = 5;
    num(5) = num(5) + 1;
  elseif visits(i) >= 2500 && visits(i) < 3500,
    X(i, 6) = 6;
    num(6) = num(6) + 1;
  elseif visits(i) >= 3500 && visits(i) < 4500,
    X(i, 6) = 7;
    num(7) = num(7) + 1;
  elseif visits(i) >= 4500 && visits(i) < 7000,
    X(i, 6) = 8;
    num(8) = num(8) + 1;
  elseif visits(i) >= 7000 && visits(i) < 10000,
    X(i, 6) = 9;
    num(9) = num(9) + 1;
  else,%     visits(i) >= 10000,
    X(i, 6) = 10; 
    num(10) = num(10) + 1;
  endif
endfor
