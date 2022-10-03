clear all
filename = "danestat45.txt";
data = importdata(filename);
y = data(:,2);
u = data(:,1);

indeksy_ucz = importdata("indeksy_uczace_dane_stat.txt");
indeksy = false(200, 2);
indeksy(indeksy_ucz, :) = true;

dane_u = data(indeksy);
dane_ucz = [dane_u(1:100,1),dane_u(101:200,1)]; %Dane uczące

dane_w =  data(~indeksy);
dane_wer = [dane_w(1:100,1),dane_w(101:200,1)]; %Dane weryfikujące


%Wykres łącznych danych dla obu danych

% plot(u);
% hold on;
% plot(y, "r");
% title("Dane statyczne")
% legend("sygnał wejściowy u(k)", "sygnał wyjściowy y(k)")
% xlabel("k - numer próbki")
% hold off;
% print('dane_statyczne','-dpng','-r400');


%Charakterystyka y(u):

% plot(u, y,"b.");
% title("Dane statyczne charkterystyka y(u)");
% xlabel("u");
% ylabel("y");
% print('y_u_dane_stat','-dpng','-r400');


%Plot dane uczące

% plot(dane_ucz(:,1));
% hold on;
% plot(dane_ucz(:,2),"r");
% title('Dane uczące');
% legend('sygnał wejściowy u(k)', 'sygnał wyjściowy y(k)');
% xlabel("k - numer próbki");
% hold off;
% print('dane_ucz_stat','-dpng','-r400');


%Plot y(s) dane uczące

% plot(dane_ucz(:,1), dane_ucz(:,2),".r")
% title("Dane uczące y(u)");
% xlabel("u");
% ylabel("y");
% print('dane_ucz_y_u','-dpng','-r400');


%Plot dane weryfikujące

% plot(dane_wer(:,1));
% hold on;
% plot(dane_wer(:,2),"r");
% title('Dane weryfikujące');
% legend('sygnał wejściowy u(k)', 'sygnał wyjściowy y(k)');
% xlabel("k - numer próbki");
% hold off;
% print('dane_wer_stat','-dpng','-r400');


%Plot y(s) dane weryfikujące

% plot(dane_wer(:,1), dane_wer(:,2),".r")
% title("Dane weryfikujące y(u)");
% xlabel("u");
% ylabel("y");
% print('dane_wer_y_u','-dpng','-r400');


%Metoda najmniejszych kwadratów

stopien = 5; %dla funkcji liniowej stopien = 1, dla nieliniowych inny
M = ones(100, stopien+1);
Y_ucz = dane_ucz(:,2);
U_ucz = dane_ucz(:,1);
for i=1:stopien
    M(:,i+1) = U_ucz.^i;
end
W = M \ Y_ucz;

%Błędy (bledy jeszcze raz napiac) oraz wykresy

Y_mod_ucz = M * W;
error_ucz = (norm(Y_mod_ucz - Y_ucz))^2;

M_wer = ones(100, stopien+1);
for i=1:stopien
    M_wer(:,i+1) = dane_wer(:,1).^i;
end

Y_mod_wer = M_wer * W;
error_wer = (norm(Y_mod_wer - dane_wer(:,2)))^2;

%Przyszykowanie prostej y(u)
u_plot = [-1:0.01:1];
y_plot = W(1);
for j = 1:stopien
    y_plot = y_plot + W(j+1)*u_plot.^j;
end

%Plot dane weryfikujące:
figure;
plot(dane_wer(:,1), dane_wer(:,2),".r")
title("Wyjście modelu na tle danych weryfikujących," + ...
    " Stopień = " +stopien + " Błąd = " + error_wer);
xlabel("u");
ylabel("y");
hold on;
plot(u_plot, y_plot, "b");
legend("Y(u) dane weryfikujące", "Y(u) modelu")
hold off;
name1 = "char_na_tle_danych_wer_st_"+stopien;

% print(name1,'-dpng','-r400');


%Plot dane uczące:
figure;
plot(dane_ucz(:,1), dane_ucz(:,2),".r")
title("Wyjście modelu na tle danych uczących," + ...
    " Stopień = "+ stopien + " Błąd = " + error_ucz);
xlabel("u");
ylabel("y");
hold on;
plot(u_plot, y_plot, "b");
legend("Y(u) dane uczące", "Y(u) modelu")
hold off;
name2 = "char_na_tle_danych_ucz_st_"+stopien;

% print(name2,'-dpng','-r400');

