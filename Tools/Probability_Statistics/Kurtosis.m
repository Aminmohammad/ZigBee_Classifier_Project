function kurtosis = Kurtosis ( input_Sample, new_Theta_Value )

    %% Section 0: Preliminaries
        % Level 1: Management of Input
            input_Sample = Converter_to_Horizontal_or_Vertical_Vector ( input_Sample, 'Horizontal', 'Kurtosis' );
                
    %% Sectrion 1: Initial Parameters  Extraction
        numinator_Coefficient = size ( input_Sample, 2 );

    %% Section 2: Decrement of 'Mean' of 'sequence_of_Samples'
        X_Mean_Value = mean ( input_Sample );
        input_Sample = input_Sample - X_Mean_Value;    % This should be mean, even if we are getting the bias of skewness/ kurtosis/ Variance. 
    
    %% Section 3: Decrement of 'Theta' of 'sequence_of_Samples'        
        input_Sample = input_Sample - new_Theta_Value;
    
    %% Section 4: Formation of Numinator     
        numinator  = input_Sample.^4;
        numinator     = sum ( numinator );
        
    %% Section 5: Formation of 'Denuminator'
        denuminator = input_Sample.^2;
        denuminator = sum ( denuminator);
        denuminator = denuminator ^ 2;
    
    %% Section 5: Calculation of 'skewness'        
        kurtosis = numinator_Coefficient * ( numinator /denuminator );
    
end