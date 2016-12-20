function bursts_Indices_Matrix = burst_Index_Extractor ( record, threshold )

    record = record (:)';
    record ( record <= threshold ) = 0;
    indices = 1 : size ( record, 2 );
    indices_of_nonZero_Elements = indices ( record ~= 0 );
    diff_of_Indices_of_nonZero_Elements = diff(indices_of_nonZero_Elements);
    indices = 1 : size ( diff_of_Indices_of_nonZero_Elements, 2 );
    temp = indices ( diff_of_Indices_of_nonZero_Elements ~= 1 );
    temp = [ 0 temp size(indices_of_nonZero_Elements, 2)];

    for index = 1 : size (temp, 2 ) - 1
        bursts_Indices_Matrix ( index , 1 ) = indices_of_nonZero_Elements(temp(index)+1);
        bursts_Indices_Matrix ( index , 2 ) = indices_of_nonZero_Elements(temp(index+1));
        
    end
end

