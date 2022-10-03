clear all
dane_ucz = importdata("danedynucz45.txt");
dane_wer = importdata("danedynwer45.txt");

y_ucz = dane_ucz(:,2);
u_ucz = dane_ucz(:,1);

y_wer = dane_wer(:,2);
u_wer = dane_wer(:,1);

%Zmienne 
n = 3; %rząd dynamiki
kmax = length(y_ucz);
kmin = 1+n;

%Tworzenie macierzy M
M = ones(kmax-n, 2*n);

for i=1:n
   M(:,i) = u_ucz(kmin-i:kmax-i, 1);
end

for i=1:n
   M(:,i+n) = y_ucz(kmin-i:kmax-i, 1); 
end

%Obliczenie parametrów modelu
Y = y_ucz(n+1:kmax,:);
W = M \ Y;



%Model liniowy bez rekurencji 
y_ucz_no_rek = zeros(kmax,1);
y_wer_no_rek = zeros(kmax,1);
for k = n+1:kmax
   for i = 1:n
        y_ucz_no_rek(k) = y_ucz_no_rek(k) + W(i) * u_ucz(k-i)+ W(i+n) * y_ucz(k-i);  %dane uczące
        y_wer_no_rek(k) = y_wer_no_rek(k)+  W(i) * u_wer(k-i)+ W(i+n) * y_wer(k-i);  %dane weryfikujące
   end
end

%Model liniowy z rekurencją
y_ucz_rek = zeros(kmax, 1);
y_wer_rek = zeros(kmax, 1);

%iniclalizacja pierwszych wyrazów dla modelu z rekurencją
for i = 1:n
   y_ucz_rek(i) = y_ucz(i);
   y_wer_rek(i) = y_wer(i);
end

for kr = n+1:kmax
   for ir = 1:n
        y_ucz_rek(kr)=y_ucz_rek(kr)+ W(ir)*u_ucz(kr-ir)+ W(ir+n)*y_ucz_rek(kr-ir);  %dane uczące
        y_wer_rek(kr)=y_wer_rek(kr)+ W(ir)*u_wer(kr-ir)+ W(ir+n)*y_wer_rek(kr-ir);  %dane weryfikujące
   end
end

%Liczenie błędu uczącego
error_ucz_rek = (norm(y_ucz_rek(n+1:kmax,:)-Y()))^2;
error_ucz_no_rek = (norm(y_ucz_no_rek(n+1:kmax,:)-Y()))^2;

%Plot dane uczące:
figure;
plot(y_ucz);
hold on;
title("Wyjście modelu na tle danych uczących," + ...
    " Rząd = "+ n + newline + "Błąd rekurencji = " + error_ucz_rek + "   Błąd bez rekurencji = " + error_ucz_no_rek);
xlabel("k");
ylabel("");
plot(y_ucz_no_rek);
plot(y_ucz_rek,"black--");
legend("Y(u) dane uczące", "Model liniowy bez rekurencji", "Model liniowy z rekurencją", 'Location','best');
hold off;
name1 = "przebieg_na_tle_danych_ucz_rz_"+n;
% print(name1,'-dpng','-r400');

%Liczenie błędy weryfikacyjnego
Y_wer = y_wer(n+1:kmax,:);
error_wer_rek = (norm(y_wer_rek(n+1:kmax,:)-Y_wer()))^2;
error_wer_no_rek = (norm(y_wer_no_rek(n+1:kmax,:)-Y_wer()))^2;

%Plot dane weryfikujące
figure;
plot(y_wer);
hold on;
title("Wyjście modelu na tle danych weryfikujących," + ...
    " Rząd = "+ n + newline + "Błąd rekurencji = " + error_wer_rek + "   Błąd bez rekurencji = " + error_wer_no_rek);
xlabel("k");
ylabel("");
plot(y_wer_no_rek);
plot(y_wer_rek,"black--");
legend("Y(u) dane weryfikujące", "Model liniowy bez rekurencji", "Model liniowy z rekurencją", 'Location','best');
hold off;
name2 = "przebieg_na_tle_danych_wer_rz_"+n;
% print(name2,'-dpng','-r400');
