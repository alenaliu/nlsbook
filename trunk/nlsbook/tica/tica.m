debug=1;
X=sampleimages;
[Z,V]=whitening(X);
fsize=size(Z,1);
m=size(Z,2);
W=rand(fsize,fsize);
W=real((W*W')^-0.5)*W;
gridsize=round(fsize^0.5);
P=getNeighbourMap(fsize,2);
theta=W(:);
if(debug==1)
    [cost,grad]=ticaCost(theta,Z,P);
    numgrad = computeNumericalGradient(@(w) ticaCost(w,Z,P),theta);
    disp([numgrad grad]);
    diff = norm(numgrad-grad)/norm(numgrad+grad);
    disp(diff);
    return;
end
addpath minFunc/
options.Method = 'lbfgs';
options.maxIter = 1300;
options.display = 'on';
[opttheta, cost] = minFunc(@(w) ticaCost(w,Z,P),theta,options); 
W=reshape(opttheta,fsize,fsize);
W=W*V(1:fsize,:);
A=pinv(W);
display_network(A);