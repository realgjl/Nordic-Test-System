% start : step point : end
startingTime = 25;
endingTime = 240;

s1 = 'temp_display_';
s2 = 's';
s3 = '.cur';

figure();
hold on
KP = [];
KI = [];
DELAY = [];
SETTLINGTIME = [];

for kp = 0.1:5.0:345.1
    
    if kp == 0.1  % kp: 0.1
        coef = 3.0;
    end
    
    if kp>0.1 && kp<50.1  % kp: 5.1~45.1
        coef = 0.3;
    end

    if kp>=50.1 && kp<100.1  % kp: 50.1~95.1
        coef = 0.2415;
    end

    if kp>=100.1 && kp<150.1  % kp: 100.1~145.1
        coef = 0.1908;
    end

    if kp>=150.1 && kp<200.1  % kp: 150.1~195.1
        coef = 0.1339;
    end

    if kp>=200.1 && kp<250.1  % kp: 200.1~245.1
        coef = 0.0655;
    end

    if kp>=250.1 && kp<300.1  % kp: 250.1~295.1
        coef = 0.0444;
    end

    if kp>=300.1 && kp<=349.6  % kp: 300.1~345.1
        coef = 0.0337;
    end

    for ki = 0.1:1.0:coef*kp  % ki: 0.1-coef*kp, step: 1.0
        for delay = 0.01
            s = [s1 num2str(kp,'%.2f') '-' num2str(ki,'%.2f') '-' num2str(delay,'%.2f') s2 s3];
            a = importdata(s);
            t = a(:,1);
            f = a(:,4);
            txt = ['kp = ', num2str(kp,'%.2f'), ', ki = ', num2str(ki,'%.2f'), ', delay = ',num2str(delay,'%.2f')];
            plot(t, f, 'DisplayName',txt,'LineWidth',1)
        end
    end
end
hold off

legend show
theTitle = ['Machine g2 (Nordic: 0.998 ~ 1.002): AGC starting from ' num2str(startingTime) ' sec, system ending at ' num2str(endingTime) ' sec'];
title(theTitle)
xlabel('t(s)')
ylabel('Omega(p�)')
xlim([0 369]);
ylim([0.99 1.01]);
grid on


