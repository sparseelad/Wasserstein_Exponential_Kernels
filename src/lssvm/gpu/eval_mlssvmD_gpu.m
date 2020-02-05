function varargout = eval_mlssvmD_gpu(varargin)
%Evaluates a multi-class LSSVM (dual with kernel) in the one-against-all
%framework.
%
%labels = EVAL_MULTI_LSSVM(model, K)
%
%INPUT
%   model:  LSSVM multi-class model (generated by compute_multi_lssvm.m)
%   K:      kernel matrix between training and test elements (s_tr*s_test)
%
%OUTPUT
%   labels: evaluated labels
%
%Author: HENRI DE PLAEN
%Date: March 2019
%Copyright: KU Leuven

%% PRELIMINARIES
assert(nargin==2,  'Wrong number of uinput arguments') ;
assert(nargout==1, 'Wrong number of output arguments') ;

model = varargin{1} ;
K = varargin{2} ;
K = K(model.idx,:) ;
clear varargin

%% EVAL
Y = K'*model.HT + repmat(model.bT,size(K,2),1) ;

%% OUTPUT
varargout{1} = sign(Y) ;

end

% %% OLD
% model = varargin{1} ;
% alpha = model.alpha ;
% intercept = model.intercept ;
% y = model.y ;
% 
% K = varargin{2} ;
% nte = size(K,2) ;
% %assert(ntr==length(ulabs), 'Kernel matrix and model not consistent') ;
% 
% %% EVALUATE
% vals = (y.*alpha)'*K+repmat(intercept,1,nte) ;
% 
% %% OUTPUT
% varargout{1} = sign(vals') ;