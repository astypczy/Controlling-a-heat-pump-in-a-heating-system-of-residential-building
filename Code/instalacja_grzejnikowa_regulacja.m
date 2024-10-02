clear all;
close all;

czas = 600000;
skok_czas = 200000;
skok_czas2 = 230000;
delay = 1000;


cp = 1000;   %ciepło wlaściwe powietrza
pp = 1.2;    %gęstość powietrza
cpw = 4175;  %ciepło wlaściwe wody
pw = 960;    %gęstość wody
cps = 840;   %ciepło wlaściwe betonu komórkowego
ps = 800;    %gęstość betonu komórkowego
TzewN = -9; %°C nominalna
TwewN = 20;  %°C
TgzN = 45;   %°C
TkzN = 45;   %temp wody wyplywajacej z kotla nominalna
TrzN = TkzN;
TgpN = 35;   %°C 
TrpN = TgpN;
TkpN = 35;   %temp wody wplywajacej do kotla nominalna
TsN = 5;     %°C temp. ścian \
qgN = 7000;  %W zapotrzebowanie pokoju 
qbN = 2700;  %W bojlera
qkN = 1*qgN+1*qbN; %W moc kotla
qtN = 0;     %W
qtbN = 0;
qtb2N = 0;
TcwuN = 15; 

Vp = 7.5*10*2.5;      %objętość pokoju
Vs = (7.5+0.5)*10.5*3-Vp; %objętość ścian
Vg = 60*0.001;      %objętość grzejnika 60 litrów wody
Vk = 120*0.001;     %pojemność kotła 120l
Vb = 100*0.001; %objętość bojlera 100litrów
Vr = 3.14*(31.75*0.001)^2*2.6; % pojemność wody w wężownicy

fmgN = qgN/(cpw*(TgzN-TgpN));
% fmgN = qkN/(cpw*(TgzN-TgpN));
fmbN = qbN/(cpw*(TrzN-TrpN));
fmkN = fmgN + fmbN;

Kcw = (qgN+qtN)/(TwewN - TsN);
Kcs = (qgN+qtN)/(TsN-TzewN);
Kcg = qgN/(TgpN - TwewN);
Kcr = cpw*fmbN*(TrzN - TrpN)/(TrpN - TcwuN);


Cvw = cp*pp*Vp;   %pojemność cieplna powietrza w pomieszczeni7u
Cvg = cpw*pw*Vg;  %pojemność cieplna wody w grzejniku 
Cvk = cpw*pw*Vk;  %pojemność cieplna wody w kotle 
Cvs = cps*ps*Vs;
Cvr = cpw*pw*Vr;  %pojemność cieplna wody w wężownicy
Cvcwu = cpw*pw*Vb;  %pojemność cieplna wody w bojlerze 

Tgp0 = TgpN;
Twew0 = TwewN;
Tkz0 = TkzN;
Ts0 = TsN;
Tcwu0 = TcwuN;
Trp0 = TrpN;
Tset_cwu = 45; 
% Tgp0 = fmgN/fmkN*qkN*(1/Kcg+1/Kcw+1/(Kcs+1-Kcw))+Kcs/(Kcs+1-Kcw)*TzewN;
% Tkz0 = (qkN+cpw*fmkN*Tgp0)/(cpw*fmkN); %może do poprawy
% Ts0 = (cpw*fmgN*(Tkz0-Tgp0)+Kcs*TzewN)/(Kcs+1-Kcw);
% Twew0 = (cpw*fmgN*(Tkz0-Tgp0)+Kcw*Ts0)/Kcw;

% Tgp0 = qgN*(1/Kcg+1/Kcw+1/(Kcs+1-Kcw))+Kcs/(Kcs+1-Kcw)*TzewN;
% Tkz0 = (qgN)/(cpw*fmgN) +Tgp0; %może do poprawy
% Ts0 = (cpw*fmgN*(Tkz0-Tgp0)+Kcs*TzewN)/(Kcs+1-Kcw);
% Twew0 = (cpw*fmgN*(Tkz0-Tgp0)+Kcw*Ts0)/Kcw;
% Tcwu0 = TcwuN;
% Trp0 = TrpN;

dqt = 0;
dTzew = 0;
dfmg = 0*fmgN;
dfmb = 0;
dqtb = 0; %ujemny skok symuluje utratę ciepła (wypływ ciepłej wody)
dqtb2 = 0;
dTset_cwu = 0;
qk_skok = 0*qgN;
dspr = 0;

% kp = 449.7158;
% ki = 0.01751;
% kp = 0.030264;
% ki = 4.0359e-06;

kp = 0.064245;
ki = 2.5015e-06;
% TwewK = 20;
TwewK = 20;
model = "sim_instalacja_grzejnikowa_regulacja_pokojowa.slx";

sim(model,czas);
figure(1);
plot(ans.tout,ans.Twew,'r'),hold on, grid on;
plot(ans.tout,ans.Tgp,'g'),hold on, grid on;
plot(ans.tout,ans.Ts,'b'),hold on, grid on;
plot(ans.tout,ans.Tkz,'m'),hold on, grid on;
plot(ans.tout,ans.Trp,'k'),hold on, grid on;
plot(ans.tout,ans.Tcwu,'c'),hold on, grid on;
legend('Twew','Tgp','Ts','Tkz','Trp','Tcwu');

figure(2);
plot(ans.tout,ans.qk),hold on, grid on;
legend('qk po spr');

figure(3);
plot(ans.tout,ans.kw),hold on, grid on;
plot(ans.tout,ans.kw_q_grz),hold on, grid on;
legend('kw pompa', 'kw q grz');

figure(4);
plot(ans.tout,ans.sprezarka),hold on, grid on;
legend('spr');

figure(5);
plot(ans.tout,ans.CV),hold on, grid on;
legend('CV');

figure(6);
plot(ans.tout,ans.f_pompa,'r'),hold on, grid on;
plot(ans.tout,ans.f_dom,'g'),hold on, grid on;
plot(ans.tout,ans.f_bojler,'b'),hold on, grid on;
legend('f pompa','f dom','f bojler');


Dkwh = sum(ans.kw)/length(ans.kw);
fprintf('heat pump alone: Average energy consumption kwh: %i \n', Dkwh);

Dkwh = sum(ans.kw+ans.kw_q_grz)/length(ans.kw);
fprintf('heat pump and heater: Average energy consumption kwh: %i \n', Dkwh);

% Dkwh = 0;
% for i = 1:length(ans.COP)
%     Dkwh = Dkwh + ans.qk(i)/ans.COP(i);
% end
% Dkwh = Dkwh/length(ans.COP);
% fprintf('COP average energy consumption kwh: %i \n', Dkwh);