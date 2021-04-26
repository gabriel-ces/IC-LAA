%ConfigurarImagem

%Configurando a imagem
%Abra a imagem depois rode o seguinte comando
figura=gcf
i=2
ndivy=[9; 9];
ndivx=[7; 7]; 
Xini=[0;0];
Xfim=[3.5;3.5];

Yini=[0;0];
Yfim=[0.8;0.8];
text=['$\alpha_1';'$\alpha_2'];

%Arrumando a Legenda
%ligando a legenda
legend('Resultado experimental','Modelo ajustado')
legend('Interpreter','latex')
legend('location','northeast')
%Tamanho da fonte
fs=27.25;
figura.Children(2).FontSize=fs
%Arrumando Title Labels
figura.Children(2).Title.String=''
figura.Children(2).Title.Interpreter='latex'
%Arrumando tick interpreter
figura.Children(2).TickLabelInterpreter='latex'
%Arrumando o eixo X
figura.Children(2).XGrid=1
% xtick=linspace(Xini(i), Xfim(i),ndivx(i));
% for j=1:size(xtick,2)
%  xticklabel{j} = sprintf(x_formatstring, xtick(j));
% end
% figura.Children(2).XTickLabel=xticklabel
%figura.Children(2).XLim= [Xini(i) Xfim(i)]
figura.Children(2).XLabel.String='Tempo\hspace{0.5em}[s]'
figura.Children(2).XLabel.Interpreter='latex'
%Arrumando o eixo Y
figura.Children(2).YGrid=1
figura.Children(2).YTick= linspace(Yini(i),Yfim(i),ndivy(i))
figura.Children(2).YLim= [Yini(i) Yfim(i)]
figura.Children(2).YLabel.String=strcat(text(i,:),'\hspace{0.5em}[rad]$')
figura.Children(2).YLabel.Interpreter='latex'
figura.Children(2).Children(1).Color ='black'
figura.Children(2).Children(2).Color ='red'