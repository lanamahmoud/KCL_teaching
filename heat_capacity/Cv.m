% Simple MATLAB code to calculate the heat capacities

T=[280,298,320]
% We have molecular dynamics simulations at 3 temperatures
%%
d1=load('280K.dat'); % loading the data with all energy components
e1=d1(300:end,13); % extracting the total energies (col 13) only
%%
d2=load('298K.dat');
e2=d2(300:end,13);
d3=load('320K.dat');
e3=d3(300:end,13);
%%
n1=size(e1,1); % Number of data points for simulation at T1 
n2=size(e2,1);
n3=size(e3,1);
%%
figure
plot((1:n1),e1,(1:n2),e2,(1:n3),e3,'LineWidth',2) % Plot the energies vs time
xlabel('Time steps (ps)')
ylabel('Energy (kcal/mol)')
legend('T_1','T_2','T_3')
%%
[mu(1),s(1)]=normfit(e1) % fit binomial distribution
%%
[mu(2),s(2)]=normfit(e2) % mu is the mean, s is the standard deviation
%%
[mu(3),s(3)]=normfit(e3)
%%
numbins=60; % number of bins to histogram the energy values
figure
histfit(e1,numbins) % Plot the histogram and the fit
hold on
%plot(x,c1*exp(-(x-mu(1)).^2./s(1)))
%%
figure
histfit(e2,numbins)
%%
figure
histfit(e3,numbins)
%%
figure
hold on
plot(T,mu,'r-','LineWidth',2)
plot(T,mu,'bo','LineWidth',2)
xlabel('Temperature (K)')
ylabel('Average energy (kcal/mol)')
p=polyfit(T,mu,1) % linear fit to the mean energy vs temperature plot
%%
figure
hold on
plot(T,s,'r-','LineWidth',2)
plot(T,s,'bo','LineWidth',2)
xlabel('Temperature (K)')
ylabel('Standard deviation (kcal/mol)')
%%
R=1.987/1000; % Boltzmann constant
% Calculate Cv using the dE/dT formula:
cV=p(1)   % Cv obtained from the slope of the linear fit for Energy vs T
%%
% Calculate Cv from the fluctuations at the three temperatures:
Cv_fluc=s.^2./R./T.^2 % . defined point-wise operation for each three T values


