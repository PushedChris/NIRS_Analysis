function [F xf] = spectra(X, Sf, nfft, win)

% [F xf] = spectra(X, Sf, nfft, win)
%
% Obligatory inputs:
%	X  - signal matrix (fft is done along the first dimension)
%	Sf - sampling frequency
%
% Optional inputs (defaults):
%	nfft = size(X,1); % length of samples in FFT (can be used for zero-padding)
%	win  = @hann; % @blackmanharris, @rectwin, @hann, @hamming, @blackman % window function applied to the data
%
% Outputs:
%	F  - fourier spectrum (amplitude normalized to reflect time domain units)
%	xf - x-axis for power/amplitude spectrum
%
% Description: The program computes the fouier spectrum along the first 
% dimension of a given matrix X. Gives only one half of the spectrum.
%
% References:
% van Drongelen W (2007) Signal processing for neuroscientists:
%	Introduction to the analysis of physiological signals. Amsterdam and
%	others: Academic Press.
%
% For infos on windowing see also: http://zone.ni.com/devzone/cda/tut/p/id/4844
%
% ---------
%
%    Copyright (C) 2012, B. Herrmann, M. Henry
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
% -----------------------------------------------------------------------
% B. Herrmann, M. Henry, Email: herrmann.b@gmail.com, 2012-02-02

% check inputs
if nargin < 2, error('Error: Wrong number of inputs!\n'); end;
if nargin < 3 || isempty(nfft), nfft = size(X,1); end;
if nargin < 4 || isempty(win),  win = @hann; end;
if nfft < size(X,1); fprintf('Info: nfft < size(X,1)! Using nfft = size(X,1).\n'); nfft = size(X,1); end;

% reshape multidimensional data into 2-d matrix
siz = size(X);
n = siz(1); nrest = siz(2:end);
X = reshape(X,[n prod(nrest)]);

% get window function and multiply it with the data
xwin = window(win,n);
X = bsxfun(@times,X,xwin);

% compute FFT, F - complex numbers, fourier matrix
F = fft(X,nfft,1)*2/sum(xwin);

% get frequency axis
xf = (0:nfft/2)*(Sf/nfft);

% shorten matrix by half
F = F(1:length(xf),:);

% put data back into multi-d matrix
F = reshape(F,[size(F,1) nrest]);
