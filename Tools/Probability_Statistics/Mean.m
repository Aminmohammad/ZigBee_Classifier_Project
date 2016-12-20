function mean = Mean ( input_Sample, new_Theta_Value )

    %% Section 0: Preliminaries
        % Level 1: Management of Input
            input_Sample = Converter_to_Horizontal_or_Vertical_Vector ( input_Sample, 'Horizontal', 'Mean' );
                
    %% Sectrion 1: Initial Parameters  Extraction
        coefficient = 1 / size ( input_Sample, 2 );

    %% Section 2: Decrement of 'Theta' of 'sequence_of_Samples'        
        input_Sample = input_Sample - new_Theta_Value;
    
    %% Section 3: Calculation of 'skewness'        
        mean = coefficient * sum( input_Sample );
   
end