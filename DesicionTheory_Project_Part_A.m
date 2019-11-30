clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATA part 1-3 %
PA=0.5;         % a priori probability of class A
PB=0.5;         % a priori probability of class B

a0 = [0;0];
a1 = [0;1];
a2 = [2;2];
a3 = [3;1];
a4 = [3;2];
a5 = [3;3];
A = [a0,a1,a2,a3,a4,a5]'; % concaterated 2-d data @class A

b0 = [6;9];
b1 = [8;9];
b2 = [9;8];
b3 = [9;9];
b4 = [9;10];
b5 = [8;11];
B = [b0,b1,b2,b3,b4,b5]'; % concaterated 2-d data @class B



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculations %
muA = mean(A)';         %arithmetic mean calc
muB = mean(B)';

CovA = cov(A);          %covariance matrices calc 
CovB = cov(B);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = -1:0.5:11;              %defining a meshgrid for the 3d pdfs' figure
x2 = -1:0.5:11;
[X1,X2] = meshgrid(x1,x2);

X = [X1(:) X2(:)];
y1 = mvnpdf(X,muA',CovA);
y1 = reshape(y1,length(x2),length(x1));
y2 = mvnpdf(X,muB',CovB);
y2 = reshape(y2,length(x2),length(x1));

xmuA=muA(1,1);              %plotting mu values for classes A & B
ymuA=muA(2,1);
xmuB=muB(1,1);
ymuB=muB(2,1);

xA = A(:,1);                %plotting class A & B training data
yA = A(:,2);
xB = B(:,1);
yB = B(:,2);

xx = -2:.1:11;              %x axis 
yy = -2:.1:12;              %y axis

[XX YY] = meshgrid(xx,yy);  %all combinations of x, y - meshgrid for the contour plots
Z1 = mvnpdf([XX(:) YY(:)],muA',CovA); %compute Gaussian pdf
Z1 = reshape(Z1,size(XX));  %put into same size as X, Y

Z2 = mvnpdf([XX(:) YY(:)],muB',CovB); %compute Gaussian pdf
Z2 = reshape(Z2,size(XX));  %put into same size as X, Y


figure('Name','Q3')
t=tiledlayout(2,1);
nexttile;

%plotting the two probability density functions for classes A&B
surf(x1,x2,y1)
caxis([min(y1(:))-0.5*range(y1(:)),max(y1(:))])
hold on
surf(x1,x2,y2)
caxis([min(y2(:))-0.5*range(y2(:)),max(y2(:))])
axis([-1 11 -1 11 0 0.5])
xlabel('characteristic_x')
ylabel('characteristic_y')
zlabel('pdf')
title('Fig1: Probability density functions for classes A & B')

nexttile;

scatter(xA,yA);
hold on
scatter(xB,yB);

sz=100;
scatter(xmuA,ymuA,sz,'*');
scatter(xmuB,ymuB,sz,'*');
ezplot('0.17*x^2+0.95*y^2-1.9*x*y+12.26*x+15.98*y-136.05',[-3,11,-2,12]);
contour(XX,YY,Z1);
contour(XX,YY,Z2);  %'-.'
legend({'Class A','Class B', 'muA', 'muB', 'Decision boundary'},'Location','northwest','Orientation','horizontal','NumColumns',2)
legend('boxon')
title('Fig2: Training Data Set for Classes A & B, Decision Boundary')
xlabel('characteristic_x')
ylabel('characteristic_y')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%data for part 6.2(d)
mA=[4 11];
mB=[10 3];
covariance=eye(2);



xx1 = 0:.1:15;              %x axis 
yy1 = 0:.1:15;              %y axis
[XX1 YY1] = meshgrid(xx1,yy1);  %all combinations of x, y - meshgrid for the contour plots
ZZ1 = mvnpdf([XX1(:) YY1(:)],mA,covariance); %compute Gaussian pdf
ZZ1 = reshape(ZZ1,size(XX1));  %put into same size as X, Y
ZZ2 = mvnpdf([XX1(:) YY1(:)],mB,covariance); %compute Gaussian pdf
ZZ2 = reshape(ZZ2,size(XX1));  %put into same size as X, Y

figure('Name','Q6.2.ii')
contour(XX1,YY1,ZZ1);
hold on
contour(XX1,YY1,ZZ2,'-.');
hold on
xorio=-2:0.1:16;
yorio=(12/16*xorio)+(27.73/16);
plot(xorio,yorio);
title('Fig3: Contour plots for classes A & B pdfs, with the desicion boundary')
legend({'Class A','Class B',},'Location','northwest','Orientation','horizontal','NumColumns',1)
hold off
