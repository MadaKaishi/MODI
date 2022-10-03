%Wybieranie indeksów służących dla danych uczących
%Indeksy zostaną zapisane w pliku "indeksy_uczace_dane_stat.txt"

random = randperm(200,100);
for i =1:100
    indeksy_ucz(i,:)=random(i);
end
sortowanie = sort(indeksy_ucz);

%zapisanie danych do pliku
%dlmwrite("indeksy_uczace_dane_stat.txt", sortowanie);
