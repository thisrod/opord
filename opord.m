function U = opord(C, s, t)
%OPORD commute an operator polynomial into a standard order
%
% OPORD(C) returns an upper-triangular matrix with the coefficients of C in normal order.
% OPORD(C, S) uses the order S, with the -1, 0, 1 convention.
% OPORD(U, S, T) takes an upper-triangular matrix with coefficients in order T.
%
% The element U(m+1,n+1) is the coefficient of the term, in the relevant order, with n factors of a+ and m factors of a.  U(1,1) is the constant term.
% Column n+1 of C stores the coefficents of terms that are a product of n operators.  The coefficient stored in C(r+1,n+1) is for the term obtained by writing r as an n-digit binary number, and replacing the 0s with a+ and the 1s with a.  Normal ordering reduces r, as does replacing an annihilation operator with a creation operator.

if nargin > 1
	error 'Implementation restriction: opord can only convert to normal order.'
end

U = zeros(size(C,2));

for j = size(C,2):-1:1
	for i = size(C,1):-1:1
		if C(i,j)
			t = dec2bin(i-1,j);	% add an extra leading zero 
			k = strfind(t, '10');
			if k
				n = bin2dec([t(1:(k-1)) '01' t((k+2):end)]) + 1;
				C(n,j) = C(n,j) + C(i,j);
				keyboard
				n = bin2dec(t([1:(k-1) (k+2):end])) + 1;
				C(n,j-2) = C(n,j-2) + C(i,j);
				keyboard
			else
				U(nnz(t=='1')+1, nnz(t=='0')) = C(i,j);
			end
		end
	end
end

end