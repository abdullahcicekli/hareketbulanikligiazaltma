% @Author: Chen Zhiliang
% @creation date  : 2018/12/16
% @Arrangement : Abdullah �i�ekli
% @School : F�rat �niversitesi Adli Bili�im M�hendisli�i
% @Student ID: 170509051
% @E-mail: abdulahcicekli@gmail.com
% @date of arrangement : 2019/03/11

clc;clear;
close all;
warning off;

% Resmi Okuma
KaymisResim = imread('C:\Users\a\Desktop\a.jpg');

%% PARAMETRE AYARLARI

% Parametreleri belirlerken dikkat edilecek nokta resmin hangi y�ne do�ru
% ne uzunlukta kaym�� oldu�udur. Bunun i�in resmi inceleyin ve kayma y�n�n�
% belirledikten sonra ister ara� kullanarak ister g�z karar� kayma a��s�n�
% parametrelere yaz�n. Uzunlu�un piksel de�erini gene ister ara�larla ister
% yak�ndan inceleyip belirleyerek yaz�n ve kodu �al��t�r�n.

%Yineleme miktar� artt�k�a i�lem artar ve keskinlik artar. �al��man�za g�re
%ayarlayarak en iyi sonucu alabilirsiniz.

kaymauzunlugu = 60;       %Hareket Uzunlu�u (Piksel Olarak)
kaymaacisi = 45;    %Hareket A��s�
Yineleme = 30;   %Yineleme Miktar�

% D�zeltilmi� resmi fonksiyondan alma
duzeltilmis = duzelt(KaymisResim(:, :, 1), kaymauzunlugu, kaymaacisi, Yineleme);

%D�zeltilmi� Resmi ve Orjinal Resmi G�sterme
figure,imshow(cat(2,KaymisResim(:,:,1),duzeltilmis)),title('Kayma D�zeltme');

%% Alt Sat�r ��kt�y� Kaydetmek ��indir.
% imwrite(duzeltilmis,['results\\Deblur3_' num2str(len) '_' num2str(theta) '_' num2str(IterNum) '.png']);

function duzeltilmis = duzelt(KaymisResim, kaymauzunlugu, kaymaacisi, Yineleme)

    % Resim E�er Renkli �se Gri Tona �eviriyor
    if size(KaymisResim, 3) == 3
        KaymisResim = KaymisResim(:,:,1);
    end
    
    % PSF hesaplama
    PSF = fspecial('motion',kaymauzunlugu,kaymaacisi);

    % Kenar Buland�rma 
    KaymisResim = edgetaper(KaymisResim, PSF);

    % D�zeltme Fonksiyonu
    duzeltilmis = deconvlucy(KaymisResim,PSF,Yineleme);
    
end