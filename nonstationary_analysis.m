clc
clear all
close all

files = dir('P:\G\1.1 research\analysis\NSGEV\*.csv');
fullpaths = fullfile({files.folder}, {files.name});
%% store data
for ii = 1:length(fullpaths)
    data{ii}=readtable(fullpaths{ii}); %to ignore headers
    model{ii} =  data{ii}.model(1);
end
%% calculate hyper parameters of NSGEV models G(x; μ, σ, ε)=exp⁡{-〖[1+ε ̂((x- μ)/σ)]〗^((-1)/ε)}
load("P:\G\1.1 research\mat_dataset\3 indices data.mat");

m = 1:1:length(model);
for i = 1:4964
    for t1 = 1:71
        %% stationary NSGEV, μ= μ_0; σ= σ_0; ε= ε_0

        for m = 1
            loc{m}(i,t1) = data{m}.mu0(i);
            shape{m}(i,t1) = data{m}.sh0(i);
            scale{m}(i,t1) = data{m}.si0(i);
        end
         %% Linear in location - Time, PDO, ONI, NAO, DMI; μ= μ_0 + μ_1 (P); σ= σ_0; ε= ε_0
        for m=2:6
            loc{m}(i,t1) = data{m}.mu0(i) + data{m}.mu1(i)*ind{3}.(m-1)(t1);
            shape{m}(i,t1) = data{m}.sh0(i);
            scale{m}(i,t1) = data{m}.si0(i);
        end

        %% Linear in location and scale μ= μ_0 + μ_1 (P); σ= σ_0+ σ_1 (P); ε= ε_0

        a=1;
        for m = 12:16
            loc{m}(i,t1) = data{m}.mu0(i) + data{m}.mu1(i)*ind{3}.(a)(t1);
            scale{m}(i,t1) = exp(data{m}.si0(i) + data{m}.si1(i)*ind{3}.(a)(t1));
            shape{m}(i,t1) = data{m}.sh0(i);
            a=a+1;
        end
        a=1;
        for m = 7:11
            loc{m}(i,t1) = data{m}.mu0(i) + data{m}.mu1(i)*ind{3}.(a)(t1);
            scale{m}(i,t1) = data{m}.si0(i) + data{m}.si1(i)*ind{3}.(a)(t1);
            shape{m}(i,t1) = data{m}.sh0(i);
            a=a+1;
        end

        %% Quadratic in location - Time; μ= μ_0+ μ_1 (P)+  μ_2 (P)^2; σ= σ_0; ε= ε_0
        a=1;
        for m=17:21
            loc{m}(i,t1) = data{m}.mu0(i) + data{m}.mu1(i)*ind{3}.(a)(t1) + data{m}.mu2(i)*((ind{3}.(a)(t1))^2);
            shape{m}(i,t1) = data{m}.sh0(i);
            scale{m}(i,t1) = data{m}.si0(i);
            a=a+1;
        end
        %% hybrid - time, PDO, ONI, NAO, DMI
        %% μ= μ_0+ μ_1 (P1) +μ_2 (P2)+ μ_3 (P3) + μ_4 (P4) + μ_5 (P5); σ= σ_0; ε= ε_0
        for m = 22
            loc{m}(i,t1) = data{m}.mu0(i) + data{m}.mu1(i)*ind{3}.(1)(t1) + data{m}.mu2(i)*ind{3}.(2)(t1) + data{m}.mu3(i)*ind{3}.(3)(t1) + data{m}.mu4(i)*ind{3}.(4)(t1) + data{m}.mu5(i)*ind{3}.(5)(t1);
            shape{m}(i,t1) = data{m}.sh0(i);
            scale{m}(i,t1) = data{m}.si0(i);
        end
        %% hybrid Linear in location and exp(scale)
        %% μ= μ_0+ μ_1 (P1) +μ_2 (P2)+ μ_3 (P3) + μ_4 (P4) + μ_5 (P5); σ= exp⁡(σ_0+ σ_1 (P1)+ σ_2 (P2)+ σ_3 (P3) + σ_4 (P4)+ σ_5 (P5)); ε= ε_0
        for m =23
            loc{m}(i,t1) = data{m}.mu0(i) + data{m}.mu1(i)*ind{3}.(1)(t1) + data{m}.mu2(i)*ind{3}.(2)(t1) + data{m}.mu3(i)*ind{3}.(3)(t1) + data{m}.mu4(i)*ind{3}.(4)(t1) + data{m}.mu5(i)*ind{3}.(5)(t1);
            shape{m}(i,t1) = data{m}.sh0(i);
            scale{m}(i,t1) = exp(data{m}.si0(i) + data{m}.si1(i)*ind{3}.(1)(t1) + data{m}.si2(i)*ind{3}.(2)(t1) + data{m}.si3(i)*ind{3}.(3)(t1) + data{m}.si4(i)*ind{3}.(4)(t1) + data{m}.si5(i)*ind{3}.(5)(t1));
        end

    end
  