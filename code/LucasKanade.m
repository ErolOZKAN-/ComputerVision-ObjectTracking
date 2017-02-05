function [u, v] = LucasKanade(It, It1, rect)

u = 0;
v = 0;
tol = 0.01;

It = double(It);
It1 = double(It1);

x = rect(1):rect(3);
y = rect(2):rect(4);

rectangle = double(It(y,x));
[dX,dY] = gradient(double(rectangle));

rectangleGrad = double([dX(:),dY(:)]);
H = rectangleGrad'*rectangleGrad;

for i=1:100
    x = (rect(1)+u):(rect(3)+u);
    y = (rect(2)+v):(rect(4)+v);
    [X,Y] = meshgrid(x,y);
    warpedIt1 = interp2(It1, X, Y);
    
    deltaIt = double(rectangle - warpedIt1);
    deltaIt = deltaIt(:);
    delta_p = H\(rectangleGrad'*deltaIt);
    u = u + delta_p(1);
    v = v + delta_p(2);
    
	if (norm(delta_p) < tol)
        break
	end
end

end 
