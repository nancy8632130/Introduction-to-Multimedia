function SAD_value= SAD(Target,Reference)
    SAD_value = sum(abs(Target(:) - Reference(:)));
end