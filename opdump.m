function s = OPDUMP(C)
% OPDUMP format a matrix as an operator polynomial, with a for creation operators and A for annihilation.

sep = '';  s = '';
if C(1,1)
	s = num2str(C(1,1));
	sep = ' + ';
end
for j = 2:size(C,2), for i = 1:min(size(C,1), 2^(j-1))
	if C(i,j)
		t = dec2bin(i-1,j-1);
		t(t=='0') = 'A';
		t(t=='1') = 'a';
		s = [s sep num2str(C(i,j)) '*' t];
		sep = ' + ';
end, end, end
			

end