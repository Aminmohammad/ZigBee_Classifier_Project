function vertical_Structure_of_Output_IQ_Component = InPhase_Quadrature_Calculator (    input_Sample,                                                              ...
                                                                                                                                    Sampling_Frequency,                                                  ...
                                                                                                                                    bandwidth_Decrement_Factor,                                      ...
                                                                                                                                    frequency_Multiplication_Factor_for_Modulation,            ...
                                                                                                                                    ...                                                                                 
                                                                                                                                    do_You_Want_Discretization_and_Digitization_Horizontal_Vector,              ...                                                                      
                                                                                                                                    discretizing_Factor,                                                     ...
                                                                                                                                    number_of_Quantization_Levels,                                   ...
                                                                                                                                    minimum_Level_for_Quantization,                                ...
                                                                                                                                    maximum_Level_for_Quantization)                               ...      Quantization Strategy :: [ index, quantized_Values ] = quantiz ( signal, partition, codeBook )
                                                                                                                                                                                                                       %                                                                      partition:                a1          a2          a3
                                                                                                                                                                                                                       %                                                                      codeBook:      b1          b2           b3           b4    
                                                                                                                                                                                                                       %                                                                                           x  <=  a1  =>   quantized_Value ( x ) = b1
                                                                                                                                                                                                                       %                                                                                   a1 < x  <=  a2  =>   quantized_Value ( x ) = b2
                                                                                                                                                                                                                       %                                                                                   a2 < x  <=  a3  =>   quantized_Value ( x ) = b3
                                                                                                                                                                                                                       %                                                                                   a3 < x              =>   quantized_Value ( x ) = b4

    %% Section 0: Preliminaries
        
    %% Section 1: Extraction of Essential Parameters
        % Level 1: Management of 'Input Sample'
            input_Sample = Converter_to_Horizontal_or_Vertical_Vector ( input_Sample, 'Horizontal', 'IQ Calculator' );

        % Level 2: Determination of 'Bandwidth' of 'input_Signal'
            [ frequency_Values_Horizontal_Vector, FFT_Horizontal_Vector] = Spectrum_Calculator_function ( input_Sample, Sampling_Frequency );

    %% Section 2: Extraction of 'Bandwidth' of 'input_Signal'   
    	low_Frequency_Values_Indices = find ( FFT_Horizontal_Vector < ( bandwidth_Decrement_Factor * max ( FFT_Horizontal_Vector ) ) ) ;     
        double_Sided_BandWidth_Frequency_Indices =  find ( diff ( low_Frequency_Values_Indices )  > 1 ) ;
        bandWidth_LowerBound = frequency_Values_Horizontal_Vector ( 1, low_Frequency_Values_Indices ( double_Sided_BandWidth_Frequency_Indices ( 1, 1 ) )  );
        bandWidth_UpperBound = frequency_Values_Horizontal_Vector ( 1, low_Frequency_Values_Indices ( double_Sided_BandWidth_Frequency_Indices ( 1, end ) )  );
        input_Signal_Double_Sided_BandWidth = bandWidth_UpperBound - bandWidth_LowerBound;
        
    %% Section 3: Modulating the 'Input_Signal'       
        time = 0 : 1/Sampling_Frequency : (size ( input_Sample, 2 ) / Sampling_Frequency) - (1/Sampling_Frequency) ;
        selected_Modulation_Frequency      = frequency_Multiplication_Factor_for_Modulation * input_Signal_Double_Sided_BandWidth;

        in_Phase_Element     = input_Sample .* cos ( 2 * pi * selected_Modulation_Frequency * time  );
        quadrature_Element = input_Sample .* sin ( 2 * pi * selected_Modulation_Frequency * time  );
        
        
    %% Section 4: Digitizing 'Input Signal'
        % Level 1: Discretizing
            if ( do_You_Want_Discretization_and_Digitization_Horizontal_Vector ( 1, 1 ) == 1 )
                discretized_Modulated_InPhase_Input_Signal     = downsample ( in_Phase_Element, discretizing_Factor );
                discretized_Modulated_Quadrature_Input_Signal = downsample ( quadrature_Element, discretizing_Factor );
                
                in_Phase_Element   = discretized_Modulated_InPhase_Input_Signal;
                quadrature_Element = discretized_Modulated_Quadrature_Input_Signal;
                
            end
            
        % Level 1: Quantizing
            quantization_Levels = minimum_Level_for_Quantization : ( maximum_Level_for_Quantization - minimum_Level_for_Quantization ) / number_of_Quantization_Levels : maximum_Level_for_Quantization;
            partitions = quantization_Levels ( 1, end - 1 ) ;
            if ( do_You_Want_Discretization_and_Digitization_Horizontal_Vector ( 1, 2  ) == 1 ) 
                quantized_Modulated_InPhase_Input_Signal     = quantiz ( discretized_Modulated_InPhase_Input_Signal,     partitions ,quantization_Levels );
                quantized_Modulated_Quadrature_Input_Signal     = quantiz ( discretized_Modulated_Quadrature_Input_Signal, partitions ,quantization_Levels );
                
                in_Phase_Element   = quantized_Modulated_InPhase_Input_Signal;
                quadrature_Element = quantized_Modulated_Quadrature_Input_Signal;
                
            end    
            
    %% Section 5: Collecting the 'Output IQ Component'            
            vertical_Structure_of_Output_IQ_Component. in_Phase_Element   = in_Phase_Element;
            vertical_Structure_of_Output_IQ_Component. quadrature_Element = quadrature_Element;
            
end
            