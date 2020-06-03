function [mse sf] = MSE_Costa2005(x,nSf,m,r)

% [mse sf] = MSE_Costa2005(x,nSf,m,r)
%
% x   - input signal vector (e.g., EEG signal or sound signal)
% nSf - number of scale factors
% m   - template length (epoch length); Costa used m = 2 throughout 
% r   - matching threshold; typically chosen to be between 10% and 20% of
%       the sample deviation of the time series; when x is z-transformed:
%       defined the tolerance as r times the standard deviation
%
% mse - multi-scale entropy
% sf  - scale factor corresponding to mse
%
% Interpretation: Costa interprets higher values of entropy to reflect more
% information at this scale (less predictable when if random). For 1/f
% pretty constant across scales.
%
% References:
% Costa et al. (2002) Multiscale Entropy Analysis of Complex Physiologic
%    Time Series. PHYSICAL REVIEW LETTERS 89
% Costa et al. (2005) Multiscale entropy analysis of biological signals.
%    PHYSICAL REVIEW E 71, 021906.
%
% Requires: SampleEntropy.m
%
% Description: The script calculates multi-scale entropy using a
% coarse-graining approach.
%
% ---------
%
%    Copyright (C) 2017, B. Herrmann
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
% ----------------------------------------------------------------------
% B. Herrmann, Email: herrmann.b@gmail.com, 2017-05-06

% pre-allocate mse vector
mse = zeros([1 nSf]);

% coarse-grain and calculate sample entropy for each scale factor
for ii = 1 : nSf
	% get filter weights
	f = ones([1 ii]);
	f = f/sum(f);

	% get coarse-grained time series (i.e., average data within non-overlapping time windows)
	y = filter(f,1,x);
	y = y(length(f):end);
	y = y(1:length(f):end);
	
	% calculate sample entropy
	mse(ii) = SampleEntropy(y,m,r,0);
end

% get sacle factors
sf = 1 : nSf;
