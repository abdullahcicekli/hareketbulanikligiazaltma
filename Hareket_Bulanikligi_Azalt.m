% @Author: Chen Zhiliang
% @creation date  : 2018/12/16
% @Arrangement : Abdullah Çiçekli
% @School : Fýrat Üniversitesi Adli Biliþim Mühendisliði
% @Student ID: 170509051
% @E-mail: abdulahcicekli@gmail.com
% @date of arrangement : 2019/03/11

clc;clear;
close all;
warning off;

% Resmi Okuma
KaymisResim = imread('C:\Users\a\Desktop\a.jpg');

%% PARAMETRE AYARLARI

% Parametreleri belirlerken dikkat edilecek nokta resmin hangi yöne doðru
% ne uzunlukta kaymýþ olduðudur. Bunun için resmi inceleyin ve kayma yönünü
% belirledikten sonra ister araç kullanarak ister göz kararý kayma açýsýný
% parametrelere yazýn. Uzunluðun piksel deðerini gene ister araçlarla ister
% yakýndan inceleyip belirleyerek yazýn ve kodu çalýþtýrýn.

%Yineleme miktarý arttýkça iþlem artar ve keskinlik artar. Çalýþmanýza göre
%ayarlayarak en iyi sonucu alabilirsiniz.

kaymauzunlugu = 60;       %Hareket Uzunluðu (Piksel Olarak)
kaymaacisi = 45;    %Hareket Açýsý
Yineleme = 30;   %Yineleme Miktarý

% Düzeltilmiþ resmi fonksiyondan alma
duzeltilmis = duzelt(KaymisResim(:, :, 1), kaymauzunlugu, kaymaacisi, Yineleme);

%Düzeltilmiþ Resmi ve Orjinal Resmi Gösterme
figure,imshow(cat(2,KaymisResim(:,:,1),duzeltilmis)),title('Kayma Düzeltme');

%% Alt Satýr Çýktýyý Kaydetmek Ýçindir.
% imwrite(duzeltilmis,['results\\Deblur3_' num2str(len) '_' num2str(theta) '_' num2str(IterNum) '.png']);

function duzeltilmis = duzelt(KaymisResim, kaymauzunlugu, kaymaacisi, Yineleme)

    % Resim Eðer Renkli Ýse Gri Tona Çeviriyor
    if size(KaymisResim, 3) == 3
        KaymisResim = KaymisResim(:,:,1);
    end
    
    % PSF hesaplama
    PSF = fspecial('motion',kaymauzunlugu,kaymaacisi);

    % Kenar Bulandýrma 
    KaymisResim = edgetaper(KaymisResim, PSF);

    % Düzeltme Fonksiyonu
    duzeltilmis = deconvlucy(KaymisResim,PSF,Yineleme);
    
end