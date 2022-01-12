int mat(N)(N) = input("enter a 4x4 matrix:");
disp(determinantOfMatrix(mat, N));
function getCofactor(mat,temp,p,q,n)
	i = 0;
	j = 0;
    for row = 0:n
        for col = 0:n
            if row~= p && col ~= q 
                temp(i)(j++) = mat(row)(col);
                if j == n - 1
                    j = 0;
                    i++;
                end
            end
        end
    end
end
 
function v=determinantOfMatrix(mat,n)
    D = 0;
    if (n == 1)
        v=mat(0)(0);
	end 
	sign = 1;
    for f = 0:n
        getCofactor(mat, temp, 0, f, n);
        D=D+sign * mat(0)(f)*determinantOfMatrix(temp, n - 1);
        sign = -sign;
    end
    v=D;
end

function display(mat,row,col)
    for i = 0:row
        for j = 0:col
            disp(mat(i)(j));
		end
    end
end
