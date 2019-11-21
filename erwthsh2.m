clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATA
PA=0.5;         % a priori probability of class A
PB=0.5;         % a priori probability of class A

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


xA = A(:,1);              %figure 2 plotting class A & B data
yA = A(:,2);
xB = B(:,1);
yB = B(:,2);
figure('Name','Class A & B data','NumberTitle','on');
scatter(xA,yA);
hold on
scatter(xB,yB);
xlabel('x1');
ylabel('x2');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculations
muA = mean(A)';         %arithmetic mean calc
muB = mean(B)';

xmuA=muA(1,1);          %figure 2 plotting mu values for classes A & B
ymuA=muA(2,1);
xmuB=muB(1,1);
ymuB=muB(2,1);

sz=100;
scatter(xmuA,ymuA,sz,'*');
scatter(xmuB,ymuB,sz,'*');
legend({'Class A','Class B', 'muA', 'muB'},'Location','northwest','Orientation','horizontal')
hold off


CovA = cov(A);          %joint covariance matrix calc in block form
CovB = cov(B);


DCA=det(CovA);      %Determinant calc for Covariance matrices A&B 
DCB=det(CovB);
DCAsqrt = DCA^0.5;
DCBsqrt = DCB^0.5;

pA=CovA(1,2)/(CovA(1,1)*CovA(2,2));
pB=CovA(1,2)/(CovA(1,1)*CovA(2,2));

% Calculating the coefficients for the discriminant function
% d(x)=gA(x)-gB(x)

C1 = (inv(CovA)*muA)';
C2 = (-0.5)*muA'*(inv(CovA)*muA) +log((PA)/(PB));
C3 = -(inv(CovB)*muB)';
C4 = 0.5*muB'*(inv(CovB))*muB;

%To calculate the decision area; we need: d(x)=0
%Defining a vector X=(xA xB)' the dimensions decrease to 1-D


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = -3:0.2:3;              % defining a meshgrid for figure 1
x2 = -3:0.2:3;
[X1,X2] = meshgrid(x1,x2);

X = [X1(:) X2(:)];
y1 = mvnpdf(X,muA',CovA);
y1 = reshape(y1,length(x2),length(x1));
y2 = mvnpdf(X,muB',CovB);
y2 = reshape(y2,length(x2),length(x1));

               %plotting the two probability density functions for classes A&B
figure('Name','pdf for classes A & B','NumberTitle','on');
surf(x1,x2,y1)
caxis([min(y1(:))-0.5*range(y1(:)),max(y1(:))])
hold on
surf(x1,x2,y2)
caxis([min(y2(:))-0.5*range(y2(:)),max(y2(:))])
axis([-3 3 -3 3 0 0.4])
xlabel('x1')
ylabel('x2')
zlabel('Probability Density')
