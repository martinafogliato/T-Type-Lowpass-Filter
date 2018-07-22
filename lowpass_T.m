clear all, clc, close all
Z0=50;
fc= 2.4e9;  wc=2*pi*fc; f=(1e9:1e7:6e9);
N=5;    g1=1.7058;   g2=1.2296;   g3=2.5408;   g4=g2;  g5=g1;  g6=1;
%% T  network
Lt(1)= Z0*g1/wc,   Ct(1)=g2/(Z0*wc),  Lt(2)=Z0*g3/wc,    Ct(2)=g4/(Z0*wc), Lt(3)=Z0*g5/wc,

LP_T_filter = rfckt.lclowpasstee('L',Lt,'C',Ct);
analisys_T  = analyze(LP_T_filter,f);
% dati_rf_T   = rfdata.data;
figure, hold on
semilogy(LP_T_filter,'S21') % blue one
semilogy(LP_T_filter,'S11') % blue one
ylabel('T-network');

%% pi Network
Cp(1)=g1/(Z0*wc),  Lp(1)=Z0*g2/wc,   Cp(2)=g3/(Z0*wc),  Lp(2)=Z0*g4/wc,   Cp(3)=g5/(Z0*wc),

LP_pi_filter = rfckt.lclowpasspi('L',Lp,'C',Cp);
analisys_pi  = analyze(LP_pi_filter,f);
% dati_rf_pi   = rfdata.data;

figure, hold on
semilogy(LP_T_filter,'S21') % red one
semilogy(LP_T_filter,'S11') % red one
ylabel('pi-network');


