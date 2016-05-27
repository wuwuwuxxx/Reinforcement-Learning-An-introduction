function [ tiles ] = Get_tiles(num_tilings, sts,memory_size,hash1,hash2,hash3)
%
% Function to replace the tiles.c function created by Richard Sutton
% for the gradient descent mountain car example
%
%   ----- created by -------
%   J. Rosado            14-6-2012
%   comments, sugestions and bugs report to jfr@isec.pt 
%   

% original function: 
% void Get_Tiles(
% int tiles, 
% int num_tilings, 
% float variables[]
% int num_variables
% int memory_size,
% int hash1,
% int hash2,
% int hash3)

%   Matlab variable     ---------      c code variable
%     sts               ---------        float variables[]

% all other variables have the same name

MAX_NUM_VARS=20;
qstate=zeros(MAX_NUM_VARS,1);
base=zeros(MAX_NUM_VARS,1);
coordinates=zeros(MAX_NUM_VARS+4,1);  % one interval number per rel dimension 
first_call=1;

if (nargin<4)
    hash1=-1;
    hash2=-1;
    hash3=-1;
end
if (nargin<5)
    hash2=-1;
    hash3=-1;
end
if (nargin<6)
    hash3=-1;
end;
[~,num_variables]=size(sts);
if(hash1==-1)
    num_coordinates=num_variables+1;        % no additional hashing corrdinates
elseif (hash2==-1)
    num_coordinates=num_variables+2;        % one additional hashing coordinates
    coordinates(num_variables+1)=hash1; 
elseif (hash3==-1)
    num_coordinates=num_variables+3;        % two additional hashing coordinates
    coordinates(num_variables+1)=hash1;
    coordinates(num_variables+2)=hash2;
else
    num_coordinates=num_variables+4;        % three additional hashing coordinates
    coordinates(num_variables+1)=hash1;
    coordinates(num_variables+2)=hash2;
    coordinates(num_variables+3)=hash3;
end

% quantize state to integers (henceforth, tile widths == num_tilings)

for i=1:num_variables
    qstate(i)=floor(sts(i)*num_tilings);
    base(i)=0;
end;

% compute the tile numbers 
for j=1:num_tilings
    % loop over each relevant dimension
    for i=1:num_variables
        if(qstate(i)>=base(i))
            coordinates(i)=qstate(i)-rem(qstate(i)-base(i),num_tilings);
        else
            coordinates(i)=qstate(i)+1+rem(base(i)-qstate(i)-1,num_tilings)-num_tilings;
        end
        % compute displacement of next tiling in quantitazed space
        base(i)=base(i)+1+(2*i);
    end
    % add additional indices for tiling and hashing_set so they hash diferently
    coordinates(i+1)=j;
    
    % the orignal tiles.c code has coordinates[i++]=j, but this does not
    % make much sense, since with i++, the valor of i is only updated after
    % the assigment and is ver used again, since the for resets the i value
    % to 0 again (??)?
    % i=i+1;
    tiles(j)=hash_coordinates(coordinates,num_coordinates,memory_size);
    
end
end
% hash_coordinates
%   Takes an array of integer coordinates and returns the corresponding tile after hashing 
function [tiles]=hash_coordinates(coordinates,num_coordinates,memory_size)

    sum=0;
    persistent first_call;
    if isempty(first_call)
        first_call=1;
    end;
    persistent rndseq;
    if isempty(rndseq)
        rndseq=zeros(2048,1);
    end;
    % if first call to hashing, initialize table of random numbers
    if (first_call==1)
        for k=1:2048
            for i=1:16
                rndseq(k)=bitor(bitshift(rndseq(k),8),bitand(ceil(rand*32767),255));
            end
        end
        first_call=0;
    end
    
    for i=1:num_coordinates
        % add random table offset for this dimension and wrap around
        index=coordinates(i);
        index=index+(449*i);
        index=rem(index,2048);
        while(index<0)
            index=index+2048;
        end
        
        sum=sum + rndseq(index);
    end
    index=rem(sum,memory_size);
    while(index<0)
           index=index+memory_size;
    end
    tiles=index;   
end

