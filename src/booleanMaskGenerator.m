function mask = booleanMaskGenerator(size, ones)
%BOOLEANMASKGENERATOR Generates a Boolean Mask Matrix of size @size with
%exactly @ones amount of 1s.

R = zeros(size);  % set all to zero
ix = randperm(numel(R)); % randomize the linear indices
ix = ix(1:ones); % select the first 
R(ix) = 1; % set the corresponding positions to 1

mask = logical(R);

% courtesy of @Jos (10584)
% https://www.mathworks.com/matlabcentral/answers/1202-randomly-generate-a-matrix-of-zeros-and-ones-with-a-non-uniform-bias#answer_1737
end

