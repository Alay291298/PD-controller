
% Given Parameters
Gp = tf([1], [1, 1, 0]); % Transfer function from equation
Wn = 5; % rad/s
Wn2 = 10; % rad/s
Mp = 0.05; % Maximum percent overshoot
Ts_max = 0.5; % Maximum settling time

% Question 1: For undamped natural frequency Wn = 5 rad/s
z1 = abs(log(Mp)) / sqrt(pi^2 + log(Mp)^2);
Ts1 = pi / (Wn * sqrt(1 - z1^2));

% PD Controller transfer function
Kp1 = 2 * z1 * Wn;
Kd1 = Wn^2;
Gc1 = tf([Kd1, Kp1], [1, 0]);

% Question 2: For Undamped Natural Frequency Wn = 10 rad/s
z2 = abs(log(Mp)) / sqrt(pi^2 + log(Mp)^2);
Ts2 = pi / (Wn2 * sqrt(1 - z2^2));

% PD Controller transfer function
Kp2 = 2 * z2 * Wn2;
Kd2 = Wn2^2;
Gc2 = tf([Kd2, Kp2], [1, 0]);

% Convert G(s) and C(s) to G(z) and C(z) using Tustin's method
Ts = 0.1; % Sample time
Gz1 = c2d(Gp, Ts, 'tustin');
Cz1 = c2d(Gc1, Ts, 'tustin');

Gz2 = c2d(Gp, Ts, 'tustin');
Cz2 = c2d(Gc2, Ts, 'tustin');



% Root Locus Plot
figure;
subplot(2, 1, 1);
rlocus(series(Gc1, Gp));
title('Root Locus (Wn = 5 rad/s)');

subplot(2, 1, 2);
rlocus(series(Gc2, Gp));
title('Root Locus (Wn2 = 10 rad/s)');

% Simulate the closed-loop system
System1 = feedback(series(Gc1, Gp), 1);
System2 = feedback(series(Gc2, Gp), 1);

% Plot the response
figure;
subplot(2, 1, 1);
step(System1);
title('Closed-Loop Response with (Wn = 5 rad/s)');

subplot(2, 1, 2);
step(System2);
title('Closed-Loop Response with (Wn = 10 rad/s)');

% Optional: Evaluate performance metrics
info1 = stepinfo(System1);
info2 = stepinfo(System2);

fprintf('System 1:\n');
disp(info1);

fprintf('System 2:\n');
disp(info2);

% Continuous-time step response
figure;
subplot(2, 2, 1);
step(Gp);
title('Continuous-Time Step Response (Gp)');

subplot(2, 2, 2);
step(Gc1);
title('Continuous-Time Step Response (Gc1)');

subplot(2, 2, 3);
step(System1);
title('Continuous-Time Closed-Loop Step Response (Wn = 5 rad/s)');

subplot(2, 2, 4);
step(System2);
title('Continuous-Time Closed-Loop Step Response (Wn = 10 rad/s)');

% Discrete-time step response
figure;
subplot(2, 2, 1);
step(Gz1);
title('Discrete-Time Step Response (Gz1)');

subplot(2, 2, 2);
step(Cz1);
title('Discrete-Time Step Response (Cz1)');

subplot(2, 2, 3);
step(feedback(Gz1*Cz1, 1));
title('Discrete-Time Closed-Loop Step Response (Wn = 5 rad/s)');

subplot(2, 2, 4);
step(feedback(Gz2*Cz2, 1));
title('Discrete-Time Closed-Loop Step Response (Wn = 10 rad/s)');

#Output of the project
System 1:
         RiseTime: 0.2202
    TransientTime: 10.8153
     SettlingTime: 10.8153
      SettlingMin: 0.3672
      SettlingMax: 1.8092
        Overshoot: 80.9206
       Undershoot: 0
             Peak: 1.8092
         PeakTime: 0.6309

System 2:
         RiseTime: 0.1077
    TransientTime: 8.8515
     SettlingTime: 8.8515
      SettlingMin: 0.2377
      SettlingMax: 1.8754
        Overshoot: 87.5390
       Undershoot: 0
             Peak: 1.8754
         PeakTime: 0.3143

