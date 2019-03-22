% start : step point : end

s1 = 'temp_display_';
s2 = 's';
s3 = '.cur';
figure();
hold on
KP = [];
KI = [];
DELAY = [];
SETTLINGTIME = [];
for kp = 0.1:0.5:20.1
    for ki = 0.1:0.5:20.1
        for delay = 0.01
            s = [s1 num2str(kp,'%.2f') '-' num2str(ki,'%.2f') '-' num2str(delay,'%.2f') s2 s3];
            a = importdata(s);
            t = a(:,1);
            f = a(:,4);
            info = stepinfo(f,t,1.0); % set y_final to nominal value.
            %if info.SettlingMax < 1.01 && info.SettlingMin > 0.99 &&
            %max(f) < 1.01 && min(f) > 0.99
            txt = ['kp = ', num2str(kp,'%.2f'), ', ki = ', num2str(ki,'%.2f'), ', delay = ',num2str(delay,'%.3f')];
            plot(t, f, 'DisplayName',txt)
            settlingTime = info.SettlingTime;
            if max(t) < 499
                settlingTime = 999999999;
            end
            KP = [KP; kp];
            KI = [KI; ki];
            DELAY = [DELAY; delay];
            SETTLINGTIME = [SETTLINGTIME; settlingTime];
            %end
        end
    end
end
T = table(KP, KI, DELAY, SETTLINGTIME);
xlsx_dic = '/Users/realgjl/Dropbox/Nordic/search-space/delay_0.01s/rank.xlsx'; % save to a dictionary
writetable(T,xlsx_dic);
hold off

legend show
theTitle = 'Machine g2';
title(theTitle)
xlabel('t(s)')
ylabel('Omega(p�)')
xlim([0 600]);
ylim([0.99 1.01]);
grid on