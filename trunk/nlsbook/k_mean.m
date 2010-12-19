%k means algorithm. The distortion function does not monotonously decrease.
%The centroids oscillates.
A=double(imread('mandrill-small.tiff'));
a_r=A(:,:,1);
a_g=A(:,:,2);
a_b=A(:,:,3);
c=16;
u=255.*rand(c,3); %color centroids
dist=zeros(c,1); %the color distance to each cluster centroid
[m,n,l]=size(A);
lb=zeros(m,n); %color label for each pixel
df=10000;
df_old=-10000;
while abs(df-df_old)>df/5000
    df_old=df
    df=0;
    %label each pixel as its closest centroid 
    for i=1:m
        for j=1:n
            for k=1:c
                tmp=[A(i,j,1),A(i,j,2),A(i,j,3)]-u(k,:);
                dist(k)=tmp*tmp';
            end
            [my,mi]=min(dist);
            lb(i,j)=mi;
            df=df+my;
        end
    end
    %for each cluster, find its center
    s=zeros(c,3);
    cnt=zeros(c,1);
    for k=1:c
        lbk=(lb==k);
        cnt(k)=sum(sum(lbk));
        if cnt(k)==0
            u(k,:)=255.*rand(1,3);
            continue;
        end
        s(k,1)=sum(a_r(lbk));
        s(k,2)=sum(a_g(lbk));
        s(k,3)=sum(a_b(lbk));
        u(k,:)=s(k,:)./cnt(k);
    end
    cnt
    u
end
A=double(imread('mandrill-large.tiff'));
[m,n,l]=size(A);
    for i=1:m
        for j=1:n
            for k=1:c
                tmp=[A(i,j,1),A(i,j,2),A(i,j,3)]-u(k,:);
                dist(k)=tmp*tmp';
            end
            [my,mi]=min(dist);
            lb(i,j)=mi;
            A(i,j,1)=u(mi,1);
            A(i,j,2)=u(mi,2);
            A(i,j,3)=u(mi,3);
        end
    end
 %draw palete
 for i=1:4
     for j=1:4
         ri=1+10*(i-1):10*i;
         rj=1+10*(j-1):10*j;
         ic=(i-1)*4+j;
        A(ri,rj,1)=u(ic,1);
        A(ri,rj,2)=u(ic,2);
        A(ri,rj,3)=u(ic,3);
     end
 end
 imshow(uint8(round(A)));