function all_im = convert_point( data,voros , t, psi)
%CONVERT_TO_IM return all isoaltion set by voros
%% 
num_bag = size(data,1);
voro_num = size(voros,3);
cache_size = floor(num_bag/100);
cache = zeros(cache_size, psi*voro_num);
all_im = [];
for c=0:98
    bias = c*cache_size;
    for s=1:cache_size
        i = bias+s;
        im = zeros(t,psi);
        index = voros(i,1,:);
        index = reshape(index,1,t);
        index_t = 1:t;
        linear_index = sub2ind(size(im),index_t,index);
        similarity = voros(i,3,:);
        im(linear_index) = similarity;
        im = reshape(im,1,psi*voro_num);
        cache(s,:)=im;
    end
    cache_c = sparse(cache);
    all_im = [all_im;cache_c];
end
cache = zeros(num_bag-cache_size*99, psi*voro_num);
bias = 99*cache_size;
for s=1:size(cache,1)
    i = bias+s;
    im = zeros(t,psi);
    index = voros(i,1,:);
    index = reshape(index,1,t);
    index_t = 1:t;
    linear_index = sub2ind(size(im),index_t,index);
    similarity = voros(i,3,:);
    im(linear_index) = similarity;
    im = reshape(im,1,psi*voro_num);
    cache(s,:)=im;
end
cache = sparse(cache);
all_im = [all_im;cache];
end

