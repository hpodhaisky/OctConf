function panini2

%% Training:
%ort = ['.',filesep,'Spieler'];
ort = ['.',filesep,'Wikipediablank',filesep,'tmp'];
%ort = ['.',filesep,'Datenkomp',filesep,'Spieler'];     % "normierte" Bilder, aber: Haare,
%                                                       % Licht (und Hintergrund) nicht ganz 
%                                                       % gleich...
%ort = ['.',filesep,'Datenkomp',filesep,'VielGleiches'];
%ort = ['.',filesep,'Datenkomp',filesep,'SpielerSchwarz'];
%ort = ['.',filesep,'Datenkomp',filesep,'math'];
%ort = ['.',filesep,'Datenkomp',filesep,'HintergrundSauber'];
alles = dir(ort);
nalles = size(alles, 1);
%
datei = [ort,filesep,alles(3).name];
Bild = double(imread(datei));
if size(Bild,3) > 1
    Bild = sum(Bild,3)/3;
end
[M,N] = size(Bild);
%
summebilder = zeros(M,N);
Alles = zeros(M*N,nalles-2);
for i = 3 : nalles
    datei = [ort,filesep,alles(i).name];
    Bild = double(imread(datei));
    if size(Bild,3) > 1
        Bild = sum(Bild,3)/3;
    end
    summebilder = summebilder + Bild;
    Alles(:,i-2) = Bild(:);
end
summebilder = summebilder/(nalles-3);
figure;
imagesc(summebilder);
axis image;
colormap gray;
for i = 1 : nalles - 2
    Alles(:,i) = Alles(:,i) - summebilder(:);
end

%% Zerlegung:
%[U, S] = svd(Alles, 0);    % Matlab
[U, S, V] = svd(Alles, 0);  % Octave

% Plotte die 'eigenfaces'
figure;
for i = 1: min(16,nalles-2)
    subplot(4,4,i);
    imagesc(reshape(U(:,i),M,N));
    %imagesc(reshape(U(:,nalles-2-i),M,N));
    colormap gray
    axis image;
end

%% Bestimme fuer alle gespeicherten Bilder die Darstellung in y
yalles = zeros(nalles - 2);
for i = 3 : nalles
    datei = [ort,filesep,alles(i).name];
    Bild = double(imread(datei));
    if size(Bild,3) > 1
        Bild = sum(Bild,3)/3;
    end
    yalles(:,i-2) = U'*(Bild(:) - summebilder(:));
end
%figure;
%plot(yalles,'.-')


%% Zusammenstellung:
auswahl = 3; % 3,4,5,6,7
%orttest = ['.',filesep,'SpielerTest'];
orttest = ['.',filesep,'Wikipediablank',filesep,'tmp2'];
%orttest = ['.',filesep,'Datenkomp',filesep,'SpielerTest']; 
%orttest = ['.',filesep,'Datenkomp',filesep,'SpielerTestSchwarz']; 
%orttest = ['.',filesep,'Datenkomp',filesep,'sonst'];
allestest = dir(orttest);
datei = [orttest,filesep,allestest(auswahl).name]
disp(allestest(auswahl).name)
Bild = double(imread(datei));
if size(Bild,3) > 1
    Bild = sum(Bild,3)/3;
end
size(Bild)
size(U)
y = U'*(Bild(:) - summebilder(:));
tmp = zeros(M,N);

figure;
for i = 1 : nalles - 2
    tmp(:) = U(:,1:i)*y(1:i)+summebilder(:);
    imagesc(tmp);
    colormap gray
    axis image
    title(num2str(i));
    %pause(.1);
%    drawnow
end


%% Gesichtserkennung:
abweichung = zeros(nalles-2,1);
normadd = 2; % oder 'inf' oder 1 oder 'fro'
anfang = 1; % oder 2,3,4,5,...
ende = nalles-2;  % oder ... nalles - 4, nalles - 3, nalles - 2
for i = 1 : nalles - 2
    abweichung(i) = norm((y(anfang:ende)-yalles(anfang:ende,i))./diag(S(anfang:ende,anfang:ende)),normadd);
end
figure;
semilogy(3:nalles,abweichung,'.-','LineWidth',3,'MarkerSize',15)

[abweichung, indizes] = sort(abweichung);
fprintf('Ich denke, Du bist einer der Spieler:\n');
fprintf('\t%s\t mit %e\n', alles(indizes(1)+2).name, abweichung(1));
fprintf('\t%s\t mit %e\n', alles(indizes(2)+2).name, abweichung(2));
fprintf('\t%s\t mit %e\n', alles(indizes(3)+2).name, abweichung(3));


%figure;
%plot(y,'.-'); hold all;
%plot(yalles(:,indizes(1)),'o-');
%plot(yalles(:,indizes(2)),'*-');
%plot(yalles(:,indizes(3)),'s-');
