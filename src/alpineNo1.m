function value = alpineNo1(c)
    value = sum(abs(c .* sin(c) + 0.1 * c), 2);
end