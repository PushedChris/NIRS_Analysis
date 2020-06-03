function SampEn = SampleEntropy(x,m,r,sflag)

% SampEn = SampleEntropy(x,m,r,sflag)
%
% Obligatory inputs:
%	x - input signal vector (e.g., EEG signal or sound signal)
%
% Optional inputs (defaults):
%	m     = 2;   % template length (epoch length)
%	r     = 0.2; % matching threshold (default r=.2), when standardized: defined the tolerance as r times the standard deviation
%	sflag = 1;   % 1 - standardize signal (zero mean, std of one), 0 - no standarization
%
% Output:
%	SampEn - sample entropy estimate (for a sine tone of 1s (Fs=44100) and r=0.2, m=2, the program needed 3.3min)
%
% References:
% Richman JS, Moorman, JR (2000) Physiological time series analysis using approximate 
%	   entropy and sample entropy. Am J Physiol 278:H2039-H2049
% Abasolo D, Hornero R, Espino P, Alvarez D, Poza J (2006) Entropy analysis of the EEG
%	   background activity in Alzheimer’s disease patients. Physioogical Measurement 27:241–253.
% Molina-Pico A, Cuesta-Frau D, Aboy M, Crespo C, Miró-Martínez P, Oltra-Crespo S (2011) Comparative
%	   study of approximate entropy and sample entropy robustness to spikes. Artificial Intelligence
% 	 in Medicine 53:97–106.
%
% The first reference introduces the method and provides all formulas. But see also these two references, 
% because they depict the formulas much clearer. If you need a standard error estimate have a look at (or the papers):
% http://www.physionet.org/physiotools/sampen/
%
% Description: The program calculates the sample entropy (SampEn) of a given signal. SampEn is the negative 
% logarithm of the conditional probability that two sequences similar for m points remain similar at the next
% point, where self-matches are not included in calculating the probability. Thus, a lower value of SampEn
% also indicates more self-similarity in the time series.
%
% ---------
%
%    Copyright (C) 2012, B. Herrmann
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
% -----------------------------------------------------------------------------------------------------
% B. Herrmann, Email: herrmann.b@gmail.com, 2012-01-15

% check inputs
SampEn = [];
if nargin < 1 || isempty(x), fprintf('Error: x needs to be defined!\n'), return; end
if ~isvector(x), fprintf('Error: x needs to be a vector!\n'), return; end
if nargin < 2 || isempty(m), m = 2; end
if nargin < 3 || isempty(r), r = 0.2; end
if nargin < 4 || isempty(sflag), sflag = 1; end

% force x to be column vector
x = x(:);
N = length(x);

 % normalize/standardize x vector
if sflag > 0, x = (x - mean(x)) / std(x); end  

% obtain subsequences of the signal
Xam = zeros(N-m,m+1); Xbm = zeros(N-m,m);
for ii = 1 : N-m                   % although for N-m+1 subsequences could be extracted for m,
	Xam(ii,:) = x(ii:ii+m);          % in the Richman approach only N-m are considered as this gives the same length for m and m+1
	Xbm(ii,:) = x(ii:ii+m-1);
end

% obtain number of matches
B = zeros(1,N-m); A = zeros(1,N-m);
for ii = 1 : N-m
	% number of matches for m
	d = abs(bsxfun(@minus,Xbm((1:N-m)~=ii,:),Xbm(ii,:)));
 	B(ii) = sum(max(d,[],2) <= r);
 	
	% number of matches for m+1
	d = abs(bsxfun(@minus,Xam((1:N-m)~=ii,:),Xam(ii,:)));
 	A(ii) = sum(max(d,[],2) <= r);
end

% get probablities for two sequences to match
B  = 1/(N-m-1) * B;                  % mean number of matches for each subsequence for m
Bm = 1/(N-m) * sum(B);               % probability that two sequences will match for m points (mean of matches across subsequences)
A  = 1/(N-m-1) * A;                  % mean number of matches for each subsequence for m+1
Am = 1/(N-m) * sum(A);               % probability that two sequences will match for m+1 points (mean of matches across subsequences)

cp = Am/Bm;                          % conditional probability
SampEn = -log(cp);                   % sample entropy


