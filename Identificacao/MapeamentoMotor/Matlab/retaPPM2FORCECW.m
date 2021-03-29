% Universidade Federal de Uberl�ndia
% Faculdade de Engenharia Mecanica
% Curso de Engenharia Mecatronica 
%   
% Retas resultantes da regressao linear do Motor 2
% O motor com tampa preta que gira no sentido anti-horario chamado motor 2
% Aluno: Gabriel Costa e Silva
% =================================

close all
clear all
clc

% Constantes
rpm_2_rads=((2*pi)/60);
Kg_2_N=(9.81);
Ts=0.012;

filename1='MPRETO_1.txt';
filename2='MPRETO_2.txt';
filename3='MPRETO_2.txt';

txtfile = dlmread(filename1);
ForcaPPM1 = iddata((txtfile(1:4874,3)*Kg_2_N),txtfile(1:4874,2),Ts,'ExperimentName','Forca por PPM');
ForcaPPM1.OutputName = {'Force'};
ForcaPPM1.OutputUnit = {'Newtons'};
ForcaPPM1.InputName = {'PPM'};
ForcaPPM1.InputUnit = {'milliseconds'};

txtfile = dlmread(filename2);
ForcaPPM2 = iddata((txtfile(1:4874,3)*Kg_2_N),txtfile(1:4874,2),Ts,'ExperimentName','Forca por PPM');
ForcaPPM2.OutputName = {'Force'};
ForcaPPM2.OutputUnit = {'Newtons'};
ForcaPPM2.InputName = {'PPM'};
ForcaPPM2.InputUnit = {'milliseconds'};

txtfile = dlmread(filename3);
ForcaPPM3 = iddata((txtfile(:,3)*Kg_2_N),txtfile(:,2),Ts,'ExperimentName','Forca por PPM');
ForcaPPM3.OutputName = {'Force'};
ForcaPPM3.OutputUnit = {'Newtons'};
ForcaPPM3.InputName = {'PPM'};
ForcaPPM3.InputUnit = {'milliseconds'};

col1=[];
col2=[];
col3=[];
col4=[];
col5=[];

for i = 1:length(ForcaPPM1.u)
    if(ForcaPPM1.u(i)==1400)
        col1=[col1;ForcaPPM1.y(i)];
    elseif(ForcaPPM1.u(i)==1450)
        col2=[col2;ForcaPPM1.y(i)];
    elseif(ForcaPPM1.u(i)==1500)
        col3=[col3;ForcaPPM1.y(i)]; 
    elseif(ForcaPPM1.u(i)==1550)
        col4=[col4;ForcaPPM1.y(i)];
    elseif(ForcaPPM1.u(i)==1600)
        col5=[col5;ForcaPPM1.y(i)];
    end
end
dado1=[col1(1:250) col2(1:250) col3(1:250) col4(1:250) col5(1:250)];


col1=[];
col2=[];
col3=[];
col4=[];
col5=[];

for i = 1:length(ForcaPPM2.u)
    if(ForcaPPM2.u(i)==1400)
        col1=[col1;ForcaPPM2.y(i)];
    elseif(ForcaPPM2.u(i)==1450)
        col2=[col2;ForcaPPM2.y(i)];
    elseif(ForcaPPM2.u(i)==1500)
        col3=[col3;ForcaPPM2.y(i)]; 
    elseif(ForcaPPM2.u(i)==1550)
        col4=[col4;ForcaPPM2.y(i)];
    elseif(ForcaPPM2.u(i)==1600)
        col5=[col5;ForcaPPM2.y(i)];
    end
end
dado2=[col1(1:250) col2(1:250) col3(1:250) col4(1:250) col5(1:250)];


col1=[];
col2=[];
col3=[];
col4=[];
col5=[];

for i = 1:length(ForcaPPM3.u)
    if(ForcaPPM3.u(i)==1400)
        col1=[col1;ForcaPPM3.y(i)];
    elseif(ForcaPPM3.u(i)==1450)
        col2=[col2;ForcaPPM3.y(i)];
    elseif(ForcaPPM3.u(i)==1500)
        col3=[col3;ForcaPPM3.y(i)]; 
    elseif(ForcaPPM3.u(i)==1550)
        col4=[col4;ForcaPPM3.y(i)];
    elseif(ForcaPPM3.u(i)==1600)
        col5=[col5;ForcaPPM3.y(i)];
    end
end

dado3=[col1(1:250) col2(1:250) col3(1:250) col4(1:250) col5(1:250)];

dado_final=[dado1;dado2;dado3];


figure
errorbar([40,45,50,55,60],mean(dado_final),std(dado_final),'*')
title("Mapeamento Estatico do Motor M2 (Rotacao Horaria)");
xlabel("PPM [%]")
ylabel("Forca [N]")
hold on

ppm = [40*ones(750,1);45*ones(750,1);50*ones(750,1);55*ones(750,1);60*ones(750,1)];
f=[dado_final(:,1);dado_final(:,2);dado_final(:,3);dado_final(:,4);dado_final(:,5)];

%%Regress�o Linear sobre os dados
format long
coefs = polyfit(ppm,f,1);
%coefs=round(coefs,6);
ppm1=linspace(40,60,1000);
plot(ppm1,polyval(coefs,ppm1));

leg1=legend('Dados experimentais','Curva Ajustada - $F[PPM]=0.0887*PPM-2.2374$')

set(leg1,'Interpreter','latex')
yticks([1:0.25:3.5])
grid on
print('MotorCW_grau1','-dpdf','-bestfit')

figure
errorbar([40,45,50,55,60],mean(dado_final),std(dado_final),'*')
title("Mapeamento Estatico do Motor M2 (Rotacao Horaria)");
xlabel("PPM [%]")
ylabel("Forca [N]")
hold on
coefs = polyfit(ppm,f,2);
ppm1=linspace(40,60,1000);
plot(ppm1,polyval(coefs,ppm1));

leg1=legend('Dados experimentais','Curva Ajustada - $F[PPM]=0.000797*PPM^2+0.00904*PPM-0.285380$')

set(leg1,'Interpreter','latex')
yticks([1:0.25:3.5])
grid on
print('MotorCW_grau2','-dpdf','-bestfit')
