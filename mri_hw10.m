img = phantom(256);
imshow(img);
thing1 = zeros(256);
thing2 = zeros(256);
for i = 1 : size(img , 1)
    for j = 1 : size(img , 2)
        if(abs(img(i,j) - 0.2) <= 0.0001 )
            thing1(i,j) = 0.2;
        end
        if(abs(img(i,j) - 0.3) <= 0.0001 )
            thing2(i,j) = 0.3;
        end
    end
end
figure();
imshow(thing1);
figure();
imshow(thing2);
%---k space-----------------------------------------------------------------------------
k1 = fftshift(fft2(fftshift(thing1)));
k2 = fftshift(fft2(fftshift(thing2)));
figure();
imshow(abs(k1),[]);
figure();
imshow(abs(k2),[]);
%---signal/lowpass------------------------------------------------------------------------------
T1 = 100;
T2_1 = 200;
T2_2 = 20;
TE = 5;
TR = 1500;
dfreq = 5;
ETL = 256;
[Msig1,Mss1] = sesignal(T1,T2_1,TE,TR,dfreq,ETL);
c1 = abs(Msig1);
[Msig2,Mss2] = sesignal(T1,T2_2,TE,TR,dfreq,ETL);
c2 = abs(Msig2);
low_f1 = zeros(1,256);
low_f1(129:256) = c1(1:2:255);
low_f1(128:-1:1) = c1(2:2:256);
low_f1 = (low_f1)' * ones(1,256);
k1 = k1.*low_f1;

low_f2 = zeros(1,256);
low_f2(129:256) = c2(1:2:255);
low_f2(128:-1:1) = c2(2:2:256);
low_f2 = (low_f2)' * ones(1,256);
k2 = k2.*low_f2;

all = k1 + k2;
blur = ifftshift(ifft2(ifftshift(all)));
figure();
imshow(abs(blur));
