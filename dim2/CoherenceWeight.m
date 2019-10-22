%(* ::Package:: *)

%    CoherenceWeight.m - computes the coherence weight of a quantum state.
%    This function has only one required argument:
%    rho: a pure state vector or a density matrix.
%
%   [Cw,W] = CoherenceWeight(Rho) is the coherence weight (as defined in [1]) of the quantum state (density matrix) Rho.
%	Cw is the numerical value of the coherence weight, and W is an optimal witness with zeros on its diagonal, 
%    all eigenvalues <= 1, and trace(rho*W) == Cw.
%
%   References: [1] K. Bu, N. Anand, and U. Singh. Asymmetry and coherence
%                   weight of quantum states. arXiv preprint, arXiv:1703.01266
%                   URL: https://arxiv.org/abs/1703.01266.

%   requires: CVX (http://cvxr.com/cvx/)
%   last updated: Januray 19, 2018

function [Cw,W] = CoherenceWeight(rho)

[m,n] = size(rho);

% Let the user enter either a pure state vector or a density matrix.
if(min(m,n) == 1) % it's a pure state vector
    rho = rho(:);
    rho = rho*rho';
    n = max(m,n); % update the size of the state
elseif(m ~= n) % it's neither a pure state vector nor a density matrix
    error('CoherenceWeight:InvalidDimensions','Rho must be either a vector or a square matrix.');
end

% If the state is pure we can compute it faster by recalling that coherence weight of a pure state is equal to 1.
if(min(m,n) == 1)
    Cw = 1;
    return
end

% In general, the coherence weight is computed by semidefinite programming.

%starting SDP
cvx_begin sdp quiet
cvx_precision best;

% Calculating C_w
variable W(n,n) hermitian;

% subject to:
maximize(trace(rho*W));
diag(diag(W)) <= 0;
W <= eye(n);

cvx_end

% storing optimal value in 'Cw', which is the coherence weight.
Cw=real(cvx_optval);
return
