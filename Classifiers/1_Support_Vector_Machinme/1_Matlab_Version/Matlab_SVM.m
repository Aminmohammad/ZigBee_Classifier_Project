function Matlab_SVM (                 input_DataSet,                                                            ... should be (d+1) x n >> [   [X]:dxn  ;  [y]:1xn  ]; 
                                               selected_Kernel_Function,                                            ...
                                               drawing_Graph_Strategy                                               ... true or false  (Default: false)
                                               )

    %% Section 0 : Preliminaries
    if       ( nargin < 1 )
        error ( 'Input for the "Matlab_SVM" function should be at least 1: "DataSet" and "Labels".' )
        
    elseif ( nargin < 2 ) 
        selected_Kernel_Function = 'Linear';
        drawing_Graph_Strategy = 1;        
        
    elseif ( nargin < 3 ) 
        drawing_Graph_Strategy = false; 
        
    end

    %% Section 1: Extraction of Initial Parameters
        % Level 1: Inputs
            matrix_of_DataPoints            = input_DataSet ( 1: end - 1, : );     % This matrix is (dxn)
            hosizontal_Vector_of_Labels     = input_DataSet (        end, : );     % This Vector is (1xn)            
        
    %% Section 2: Calculation of Classifier, with 'Support Vector Machine' (SVM) from Matlab
%     fitcecoc(matrix_of_DataPoints,hosizontal_Vector_of_Labels)
        svmtrain ( matrix_of_DataPoints, hosizontal_Vector_of_Labels, 'showplot', drawing_Graph_Strategy, 'kernel_Function', selected_Kernel_Function )
title ( selected_Kernel_Function )
end

