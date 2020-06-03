clear all;
format compact

rand('seed',10)

% parameters
Sf  = 1000;
dur = 30;

% colors and b parameter for 1/f^b
ccol = [0 151 204; 0 0 0; 204 8 118; 204 122 0] / 255;
b    = [-1 0 1 2];
lab  = {'Blue' 'White' 'Pink' 'Brown'};

% get signals, mse, spectrum
nsamps = round(10.^linspace(log10(50),log10(2000),60));
[y mse mspe mswpe SampEn pe wpe alpha] = deal([]);
for ii = 1 : length(b)
	y(:,ii)        = colored_noise(Sf,dur,b(ii));
	[mse(:,ii) sf] = MSE_Costa2005(y(:,ii),20,2,std(y(:,ii))*0.15);
	SampEn(ii)     = SampleEntropy(y(:,ii),2,std(y(:,ii))*0.15,0);
end

% time vector
t = (0:length(y)-1)/Sf;

% spectrum
[F xf] = spectra(y, Sf, Sf*10, @hann);

% plot spectra
figure, set(gcf,'Color',[1 1 1]), hold on
for ii = 1 : length(b)
	subplot(1,length(b),ii)
	set(gca,'FontSize',12)
	plot(xf,abs(F(:,ii)),'-','Color',ccol(ii,:))
	xlim([0 400])
	ylim([0 0.2])
	xlabel('Frequency (Hz)')
	if ii == 1
		ylabel('Amplitude (a.u.)')
	end
	title([lab{ii} ' noise (1/f^{' num2str(b(ii)) '})'])
end


% plot time course
figure, set(gcf,'Color',[1 1 1]), hold on
for ii = 1 : length(b)
	subplot(length(b),1,ii)
	set(gca,'FontSize',12)
	plot(t,y(:,ii),'-','Color',ccol(ii,:))
	ylim([-3 3])
	if ii == length(b)
		xlabel('Time (s)')
	end
	ylabel('Amp. (a.u.)')
	title([lab{ii} ' noise (1/f^{' num2str(b(ii)) '})'])
end


% plot mse
figure, set(gcf,'Color',[1 1 1]), hold on, pp = []; labfull = {};
set(gca,'FontSize',12)
for ii = 1 : length(b)
	pp(ii) = plot(sf,mse(:,ii),'-','Color',ccol(ii,:),'LineWidth',2);
	labfull{ii} = [lab{ii} ' noise (1/f^{' num2str(b(ii)) '})'];
end
ylim([0 3])
xlabel('Scale')
ylabel('SampEn')
title('Multi-scale entropy')
legend(pp,labfull)
legend('boxoff')


% plot sample entropy
figure, set(gcf,'Color',[1 1 1]), hold on, pp = []; labfull = {};
set(gca,'FontSize',12)
for ii = 1 : length(b)
	rectangle('Position',[ii 0 1 SampEn(ii)],'FaceColor',ccol(ii,:))
end
set(gca,'XTick',1.5:length(b)+0.5,'XTickLabel',lab)
xlim([0.8 length(b)+1.2])
ylim([0 3])
xlabel('Noise type')
ylabel('SampEn')
title('Sample entropy')


