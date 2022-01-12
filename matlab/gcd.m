function v=hcf(c,d)
    if d==0
        v=c;
    else
        v=hcf(d,mod(c,d));
    end
end