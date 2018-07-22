fc=2.4e9;
wc=2*pi*fc;
f=4.8e9;
c=3e8;
f_int=[1e9:4e6:6e9];
R0=50;
g1=1.7058;
g2=1.2296;
g3=2.5408;
g5=g1;
g4=g2;
L1=(g1*R0)/wc
L3=(g3*R0)/wc
L5=L1
C2=g2/(wc*R0)
C4=C2

% %% lumped element T lowpass filter
% 
% LP_t_filter=rfckt.lclowpasstee;
% LP_t_filter.L=[L1 L3 L5];
% LP_t_filter.C=[C2 C4];
% an_LP=analyze(LP_t_filter,f_int);


%% microstrip lowpass filter

w1=0.0005818; w2=0.0146734;
er=4; h=0.002;
e_eff1=(er+1)/2+(er-1)/2*1/(sqrt(1+12*h/w1));
e_eff2=(er+1)/2+(er-1)/2*1/(sqrt(1+12*h/w2));
Z_inf_l=20;
Z_inf_h=120;
k1=2*pi/c*sqrt(e_eff1)*fc;
k2=2*pi/c*sqrt(e_eff2)*fc;
l1= (g1*R0)/(Z_inf_h*k1)
l2= (g2*Z_inf_l)/(R0*k2)
l3= (g3*R0)/(Z_inf_h*k1)
l5=l1;
l4=l2;

microstrip1=rfckt.microstrip('EpsilonR',er,'Height',h,'Linelength',l1,'Width',w1);
microstrip2=rfckt.microstrip('EpsilonR',er,'Height',h,'Linelength',l2,'Width',w2);
microstrip3=rfckt.microstrip('EpsilonR',er,'Height',h,'Linelength',l3,'Width',w1);
microstrip4=rfckt.microstrip('EpsilonR',er,'Height',h,'Linelength',l4,'Width',w2);
microstrip5=rfckt.microstrip('EpsilonR',er,'Height',h,'Linelength',l5,'Width',w1);

net=rfckt.cascade;
net.Ckts={microstrip1,microstrip2,microstrip3,microstrip4,microstrip5};
an_net=analyze(net,f_int);

%% plots
figure, hold on
%plot(LP_t_filter,'S21') %blu curve
plot(net,'S21') %red curve
plot(net,'S11') %red curve

ylabel('Magnitude (dB)');
xlabel('Frequency (GHz)');

legend( 'Microstrip');


