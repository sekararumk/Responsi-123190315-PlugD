opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (3:5);
data1 = readmatrix('Real estate valuation data set.xlsx', opts);
opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (8);
data2 = readmatrix('Real estate valuation data set.xlsx', opts);

data = [data1 data2];
data = data(1:50,:);

x = data;
%data rating kecocokan dari masing-masing alternatif
k = [0,0,1,0];
%atribut tiap-tiap kriteria, dimana nilai 1 = atribut keuntungan, dan 0 = atribut biaya 
w = [3,5,4,1];
%Nilai bobot tiap kriteria (1 = sangat buruk, 2 =buruk, 3 = cukup, 4 = tinggi, 5 = sangat tinggi)

%tahapan pertama, perbaikan bobot
[m n]=size (x); %inisialisasi ukuran x
w=w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n,
    if k(j)==0, w(j)=-1*w(j);
    end;
end;
for i=1:m,
    S(i)=prod(x(i,:).^w);
end;

%tahapan ketiga, proses perangkingan
V= S/sum(S);

Vtranspose=V.';
opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (1);
result = readmatrix('Real estate valuation data set.xlsx',opts);
result = result(1:50,:);
result = [result Vtranspose];
result = sortrows(result,-2);
result = result(1:5,1);

disp ('Rekomendasi berdasarkan nomor Real Estate = ')
disp (result);