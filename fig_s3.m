clear all

%theoritical average ACF and PCF values
Asize_th=[1,0.485871368530153,0.214756597933967,0.0462683367484491,-0.0376653103045752,-0.0795962949810703,-0.0783001384376846,-0.0562392225454530,-0.0294258551375105,-0.00795162850861979,0.00474616426300858,0.00628178604020999,1.89898050419730e-05,-0.00802588716972369,-0.0128770368670846,-0.0127240409404881,-0.00787819320846138,-0.000398190814442887,0.00687819925331638,0.0116259629114865];
Psize_th=[1,0.559367190728788,0.278942311712538,0.175512489299485,0.120290301433042,0.0890996012591128,0.0699961899583479,0.0576739218611817,0.0479130085378019,0.0398546580001766,0.0336022800492939,0.0289674214719590,0.0251754882540045,0.0217170814064957,0.0185956110857983,0.0159456158656158,0.0137102515132569,0.0117309720917168,0.00993979953951173,0.00837526887319294];

lambda_=[-0.437780951465632,0.543223919308705,0.491705682171214,0.510002402848451,0.277106039145459,0.876293443001876,0.432469567863018,0.382698873535758,-0.105727605440777,-0.111500279410179,0.304717368236691,0.779797937607448,-0.135651513613118,-0.0755138261482009,0.220896874944972,0.169600877587669,0.806124904539496,-0.0501514732073554,-0.0771625831353898,0.164627965334365,-0.241918862648952,-0.102068287457606,0.331196403424680,0.120696372510684,-0.187414104600272,0.213434384065664,0.907030217501140,0.0190825788749806,0.0922462362403883,0.765788443221611,-0.197528698619080,0.882914449117073,-0.311563120687630,0.0400409008476898,0.143223603689618,-0.204966799662734,-0.160888430938644,0.588303186464706,0.494710569438774,0.746247239420961,0.351224204771623,0.816032182575252,0.239690835145394,0.668847458852496,0.155034337120964,0.202595983827993,-0.0771993427365235,0.124870777307344,0.749180236119475,0.134630497776678,0.162399914893539,0.817325186061683,-0.0304075685381979,0.347356892504376,-0.0422603157160499,0.481168858743087,0.261843506841815,0.0588883134205661,0.569284739307737,0.147092988394364,0.769872935051852,0.0506372204983407,0.880991406269317,0.0107941783303201,-0.0172676877178747,0.201525636515528,0.829773495517545,0.584474291128834,0.844148003797666,-0.0696261143114802,0.0712439670761336];
beta_=[0.549466002901528,0.373981248925379,0.498304935738359,0.197616493928081,0.880905220609813,0.323665289340457,0.427058635022059,0.458737034172928,0.535583582062743,0.459362784794398,0.497402976010104,0.298134585811216,0.852843181810566,0.538009150521373,0.710466390060368,0.737883368911383,0.134008395550596,0.808940097201161,0.937113218875582,0.728167326640657,0.653667695102673,0.731882945991276,0.436461384797921,0.588234331842361,0.680157782437219,0.790289849472628,0.0746427491634596,1.06699008408951,0.456356921534495,0.177424316567449,0.754901647864043,0.456667216714259,0.514174380546500,0.665280596450006,0.620190275946179,0.674889418407946,0.480385511537217,0.396719462346884,1.64547272067817,0.283494909253543,0.590657357476155,0.138208768518789,0.555771965375739,0.202616836845256,0.381954315978349,0.605057741875549,0.979509832302303,0.906707481449065,0.254280911974601,0.548984865314682,0.596820359034682,0.210490329116379,0.708627736323756,0.562108866323305,0.390189199429945,0.403507759478918,0.518049795377186,0.492262593354846,0.235756491819735,0.662563952607395,0.147104766744389,0.611165391949975,0.0794783205684400,0.648889016180874,0.791104723834943,0.474744738292321,0.345344377644506,0.292705020821675,0.343185422291386,0.493212607750699,0.559512601672749];
Nt=300;Ntpre=200;Nz=500;t=(0:1:Nt-1);epsilon=zeros(Ntpre,Nz);epsilon1=zeros(Nt+Ntpre,Nz);epsilon2=zeros(Nt+Ntpre,Nz);
I=((0.2)^2);Is=((0.3)^2);delta=zeros(Ntpre,Nz);delta1=zeros(Nt+Ntpre,Nz);delta2=zeros(Nt+Ntpre,Nz);

%tau_=[0.1,1,2,4];
sig_=[0.01,0.1,1,2];
figure(1)
clf
for i_=1:length(sig_)
tau=0.1;
sig=sig_(i_); %characteristic time of the ornstein uhlenbeck process
theta=1/tau;dt=0.01;t_=0:dt:Nt+Ntpre;
beta_t=zeros(length(t_),length(lambda_));beta_t(1,:)=beta_;
lambda_t=zeros(length(t_),length(lambda_));lambda_t(1,:)=lambda_;

for m=1:length(lambda_)
    lambda=lambda_(m);
    beta=beta_(m);
    mu_beta=beta;mu_lambda=lambda;

for k=1:Nz
    for i=1:length(beta_t)-1
        dw1=sqrt(dt)*randn;dw2=sqrt(dt)*randn;
        beta_t(i+1,m)=beta_t(i,m)+theta*(mu_beta-beta_t(i,m))*dt+sig*dw1;
        lambda_t(i+1,m)=lambda_t(i,m)+theta*(mu_lambda-lambda_t(i,m))*dt+sig*dw2;
    end
for q=1:Ntpre
    %sisters
    eta=sqrt(Is)*randn;zeta=sqrt(I)*randn; %draw noises
    epsilon(q+1,k)=epsilon(q,k)+delta(q,k)+eta;
    delta(q+1,k)=-beta_t(q/dt,m)*epsilon(q+1,k)+lambda_t(q/dt,m)*delta(q,k)+zeta;
end

    epsilon1(1:Ntpre+1,k)=epsilon(:,k);epsilon2(1:Ntpre+1,k)=epsilon(:,k);
    delta1(1:Ntpre+1,k)=delta(:,k);delta2(1:Ntpre+1,k)=delta(:,k);

for p=1:Nt
    eta1=sqrt(Is)*randn;eta2=sqrt(Is)*randn;zeta1=sqrt(I)*randn;zeta2=sqrt(I)*randn;
    epsilon1(Ntpre+p+1,k)=epsilon1(Ntpre+p,k)+delta1(Ntpre+p,k)+eta1;
    epsilon2(Ntpre+p+1,k)=epsilon2(Ntpre+p,k)+delta2(Ntpre+p,k)+eta2;
    delta1(Ntpre+p+1,k)=-beta_t((p+Ntpre)/dt,m)*epsilon1(Ntpre+p+1,k)+lambda_t((p+Ntpre)/dt,m)*delta1(Ntpre+p,k)+zeta1;
    delta2(Ntpre+p+1,k)=-beta_t((p+Ntpre)/dt,m)*epsilon2(Ntpre+p+1,k)+lambda_t((p+Ntpre)/dt,m)*delta2(Ntpre+p,k)+zeta2;
end
end

for n=1:Nt
    %ACF and PCF for size, sisters
    Psize(n,m)=mean((epsilon1(Ntpre+n,:)).*(epsilon2(Ntpre+n,:)))/std((epsilon1(Ntpre+n,:)),0,'all')/std((epsilon2(Ntpre+n,:)),0,'all');
    Asize(n,m)= mean(mean((epsilon1(Ntpre+1:end-n+1,:)).*(epsilon1(Ntpre+n:end,:))))./mean(mean((epsilon1(Ntpre+1:end,:)).*(epsilon1(Ntpre+1:end,:))));
end
end

Asize_av=mean(Asize,2);
Psize_av=mean(Psize,2);

subplot(1,4,i_)
hold on
plot(t,Asize_av,'--Ok',t,Psize_av,'--^g','linewidth',1.5)
plot((0:length(Asize_th)-1),Asize_th,'k',(0:length(Psize_th)-1),Psize_th,'g','linewidth',1.5)
plot(t,Asize_av*0,'k')
xlim([0,12])
pbaspect([1 1 1])
set(gca,'FontSize',20)
xlabel('gen.')
ylabel('Correlations')
legend('ACF sm','PCF sm','ACF th', 'PCF th')
title("\tau="+tau+" gen. and \sigma="+sig);
end