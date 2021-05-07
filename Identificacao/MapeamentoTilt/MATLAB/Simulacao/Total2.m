clear all
close all
clc


%%Simulação do Modelo Dinamico de 4 Barras
%Inicialização das variaveis
theta_servo=[];
alpha=[];
 
%Definição das dimensoes de cada barra do mecanismo
s = 1.6e-2;
w = 3.8e-2;
u = 1.8e-2;
v = 1.25e-2;
t = sqrt(u^2+v^2);
y = 1.95e-2;
x = 4.535e-2;
param1=[s w u v t y x]*1000;

% Definição dos Angulos Limites do Servo Motor [theta_min,theta_max] (Atuador do mecanismo Tilt)
theta_max= pi; % em radianos pi[rad] = 180 [degrees]
theta_min= 0;  % em radianos
 
 for theta = theta_min:0.005: theta_max;
      alpha_sup = sim4bar1(param1,theta);
      theta_servo = [theta_servo theta];
 
     alpha=[alpha alpha_sup];
 end

tservo2=[109.7214 114.3051 120.0347 124.6183 129.202 134.0721 145.8178 150.4014 156.131 161.5741 169.882 178.1899];
ppm=[1650:50:1900,2000:50:2250];
servo2alfa=polyfit(tservo2,ppm,2);
abc1=polyfit(ppm,tservo2,1);
abc2=polyfit(ppm,tservo2,2);

servo=[0,5,11,16,21,...
    26,31,37,43,47,...
    51,58,63.5,69,75,...
    80,85,91,97,102.5,...
    110,113.5,120,124,130,...
    135.5,140,144.5,150,156,...
    162,170,177];
ppmin=[650:50:2250];

coefs2=polyfit(servo,ppmin,2);
ppm2servo=polyfit(ppmin,servo,2);


figure
%plot(ppm,tservo2,'r*');
hold on
plot(ppmin, servo,'k*');
plot(ppmin,polyval(ppm2servo,ppmin));
legend={'Simulado','Experimental'}
xlabel('PPM [ms]')
ylabel('\theta_{servo} [\circ]')
clear legend
legend('Dados experimentais','Curva Ajustada','Interpreter','latex')

grid on

% ppm para theta servo
ppm2servo=polyfit(ppmin*1000,servo,2);
thetaservo=polyval(ppm2servo,ppmin*1000);

i=1
Xini=[650]*1000;
Xfim=[2250]*1000;
ndivx=[10]
figure
figura=gcf
plot(ppmin*1000,thetaservo);
xlabel('PPM [ms]')
axis([Xini(i) Xfim(i) 0 180])
figura.Children.XTick= linspace(Xini(i), Xfim(i),ndivx(i))
ylabel('\theta_{tilt} [\circ]')
grid on

figure
plot(rad2deg(theta_servo),rad2deg(alpha));
title("\theta_{servo}x\alpha");
xlabel("$\theta_{servo} [^\circ]$",'Interpreter','latex');
ylabel("$\alpha [^\circ]$",'Interpreter','latex');
axis([53 180 -5 91])
grid on
hold on
%====================
offset=  84.5; % Para qual valor de angulo de thetapot temos o angulo
%zero do tilt 2

load('dado_1_tilt2.mat');
load('dado_2_tilt2.mat');
load('dado_3_tilt2.mat');

dado_final=[dado1(:,1:13); dado2(:,1:13); dado3(:,1:13)];
dado_final=dado_final-offset*ones(size(dado_final));
thetaservo=polyval(ppm2servo,[1200:50:2250]*1000);
alfa=[82.19 75.5 68.61 61.56 58.65 53 48 44 38.6 mean(dado_final)];
plot(thetaservo,alfa,'*');
hold on
format long
servo2alfa = polyfit(thetaservo,alfa,2);
plot([54:1:175],polyval(servo2alfa,[54:1:175],'r--'));
clear legend
legend('Simulação','Dados experimentais','Curva Ajustada','Interpreter','latex')

