clear all
dane_ucz = importdata("danedynucz45.txt");
dane_wer = importdata("danedynwer45.txt");

y_ucz = dane_ucz(:,2);
u_ucz = dane_ucz(:,1);

y_wer = dane_wer(:,2);
u_wer = dane_wer(:,1);

%Wykres dane uczące
figure;
plot(u_ucz);
hold on;
plot(y_ucz, "r");
title("Uczące dane dynamicznie")
legend("sygnał wejściowy u(k)", "sygnał wyjściowy y(k)")
xlabel("k - numer próbki")
hold off;
% print('dane_dyn_ucz','-dpng','-r400');


%Wykres dane weryfikujące
figure;
plot(u_wer);
hold on;
plot(y_wer, "r");
title("Weryfikujące dane dynamicznie")
legend("sygnał wejściowy u(k)", "sygnał wyjściowy y(k)")
xlabel("k - numer próbki")
hold off;
% print('dane_dyn_wer','-dpng','-r400');


%Y(s) dane uczące
figure;
plot(u_ucz, y_ucz,"b.");
title("Uczące dane dynamiczne charkterystyka y(u)");
xlabel("u");
ylabel("y");
% print('y_u_dyn_ucz','-dpng','-r400');


%Y(s) dane weryfikujące
figure;
plot(u_wer, y_wer,"b.");
title("Weryfikujące dane dynamiczne charkterystyka y(u)");
xlabel("u");
ylabel("y");
% print('y_u_dyn_wer','-dpng','-r400');