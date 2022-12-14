% clear all
dane_ucz = importdata("danedynucz45.txt");
dane_wer = importdata("danedynwer45.txt");

y_ucz = dane_ucz(:,2);
u_ucz = dane_ucz(:,1);

y_wer = dane_wer(:,2);
u_wer = dane_wer(:,1);

%Zmienne 
n = 3; %rząd dynamiki
s = 4; %rząd wielomianu


kmax = length(y_ucz);
kmin = 1+n;

%Tworzenie macierzy M
M=ones(length(dane_ucz)-n, 2*n*s);
for i=1:n
    for j=1:s
        M(:,s*i-s+j)= u_ucz((n-(i-1)):(kmax-i),1).^j;
        M(:,s*i-s+j+n*s)=y_ucz((n-(i-1)):(kmax-i),1).^j;
    end
end


%Obliczenie parametrów modelu
Y = y_ucz(n+1:kmax,:);
W = M \ Y;



y_ucz_rek = zeros(kmax,1);
y_wer_rek = zeros(kmax,1);

M_ucz_no_rek = zeros(kmax,1);
M_wer_no_rek = zeros(kmax,1);
M_ucz_rek = zeros(kmax,1);
M_wer_rek = zeros(kmax,1);


%iniclalizacja pierwszych wyrazów
for i = 1:n
   y_ucz_rek(i) = y_ucz(i);
   y_wer_rek(i) = y_wer(i);
end


%Liczenie wartości modelu
i_u = 1;
i_y = 1;
for k = kmin:kmax
   for nk = 1:n
        for sk = 1:s
            M_ucz_no_rek(k,i_u) = u_ucz(k-nk)^sk;
            M_wer_no_rek(k,i_u) = u_wer(k-nk)^sk;
            M_ucz_rek(k,i_u) = u_ucz(k-nk)^sk;
            M_wer_rek(k,i_u) = u_wer(k-nk)^sk;
            i_u = i_u + 1;
        end
   end 
   for nk = 1:n
        for sk = 1:s
            M_ucz_no_rek(k,i_y+n*s) = y_ucz(k-nk)^sk;
            M_wer_no_rek(k,i_y+n*s) = y_wer(k-nk)^sk;
            M_ucz_rek(k,i_y+n*s) = y_ucz_rek(k-nk)^sk;
            M_wer_rek(k,i_y+n*s) = y_wer_rek(k-nk)^sk;
            i_y = i_y + 1;
        end
   end
   i_u = 1;
   i_y = 1;
   y_ucz_rek(k) = M_ucz_rek(k,:)* W;
   y_wer_rek(k) = M_wer_rek(k,:)* W;
end
y_ucz_no_rek =  M_ucz_no_rek * W;
y_wer_no_rek = M_wer_no_rek * W;


%Liczenie błędu uczącego
Y = y_ucz(n+1:kmax,:);
error_ucz_rek = (norm(y_ucz_rek(n+1:kmax,:)-Y()))^2;
error_ucz_no_rek = (norm(y_ucz_no_rek(n+1:kmax,:)-Y()))^2;

% %Liczenie błędy weryfikacyjnego
Y_wer = y_wer(n+1:kmax,:);
error_wer_rek = (norm(y_wer_rek(n+1:kmax,:)-Y_wer()))^2;
error_wer_no_rek = (norm(y_wer_no_rek(n+1:kmax,:)-Y_wer()))^2;


%Wykres dane uczące
figure;
plot(y_ucz);
hold on;
title("Wyjście modelu nieliniowego na tle danych uczących," + ...
    " Rząd = "+ n + newline + "Stopień = " +s+  " Błąd rekurencji = " + error_ucz_rek + "   Błąd bez rekurencji = " + error_ucz_no_rek);
xlabel("k");
ylabel("");
plot(y_ucz_no_rek, 'Color',[1.0 0.0 0.2]);
plot(y_ucz_rek,'Color',[0.0 0.4 0.2]);
legend("Wyjście danych uczących", "Model bez rekurencji", "Model z rekurencją", 'Location','best');
hold off;
name1 = "przebieg_na_tle_danych_ucz_rz_"+n+"_st_"+s;
% print(name1,'-dpng','-r400');


%Wykres dane weryfikujące
figure;
plot(y_wer);
hold on;
title("Wyjście modelu nieliniowego na tle danych weryfikujących," + ...
    " Rząd = "+ n + newline + "Stopień = " + s + " Błąd rekurencji = " + error_wer_rek + "   Błąd bez rekurencji = " + error_wer_no_rek);
xlabel("k");
ylabel("");
plot(y_wer_no_rek,'Color',[1.0 0.0 0.2]);
plot(y_wer_rek,'Color',[0.0 0.4 0.2]);
legend("Wyjście danych weryfikujących", "Model bez rekurencji", "Model z rekurencją", 'Location','best');
hold off;
name2 = "przebieg_na_tle_danych_wer_rz_"+n+"_st_"+s;
% print(name2,'-dpng','-r400');



