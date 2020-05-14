
function scaled=scale(data,lower,upper)


if (nargin < 3)
    lower=-1;
    upper=1;
elseif (lower > upper)
    disp('lower value cannot be higher than upper')
end

[maxv, i]=max(data);
[minv, i]=min(data);

[r c]=size(data);

scaled=(data-ones(r,1)*minv).*(ones(r,1)*((upper-lower)*ones(1,c)./(maxv-minv)))+lower;