function output = Converter_to_Horizontal_or_Vertical_Vector ( input, selected_Horizontal_or_Vertical_Strategy, parameter_Name )

    % Section 1: Conversion of Matrix to Vector
        if     ( isempty ( input ) == 0 )  
            
            if ( strcmp ( selected_Horizontal_or_Vertical_Strategy, 'Horizontal' ) == 1 )
                
                output = reshape (input', 1, size(input ,1)*size(input, 2));
                
            elseif ( strcmp ( selected_Horizontal_or_Vertical_Strategy, 'Vertical' ) == 1 )
                output = reshape (input', size(input ,1)*size(input, 2), 1 );
                
            else
                error ( 'Selected Strategy "%s" for Converstion of Input of "%s" is not Clear!\n', selected_Horizontal_or_Vertical_Strategy, parameter_Name  );
                
            end
            
        elseif ( isempty ( input ) == 1 ) 
            error ( 'Input for the calculation of "%s" should be a " non-Empty Vector"\n', parameter_Name  );
            
        end

end