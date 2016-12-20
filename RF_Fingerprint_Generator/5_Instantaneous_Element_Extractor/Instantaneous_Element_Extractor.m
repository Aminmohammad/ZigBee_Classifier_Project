function vertical_Structure_of_Selected_Instantaneous_Elements_for_Mentioned_Single_sub_Region = Instantaneous_Element_Extractor ( input_Single_sub_Region,                                                                                                    ...  used in:  'selected_Instantaneous_Element_Function'
                                                                                                                                                                                                         input_Single_sub_Region_or_Input_Single_sub_Region_IQ_Component,                                  ...  used in: 'selected_Instantaneous_Element_Function'
                                                                                                                                                                                                         vertical_Cell_of_Instantaneous_Elements_Names                                                                   ... used here
                                                                                                                                                                                                         )

    %% Section 0: Preliminaries
        % Level 1: Management of Input
            vertical_Cell_of_Instantaneous_Elements_Names = Converter_to_Horizontal_or_Vertical_Vector ( vertical_Cell_of_Instantaneous_Elements_Names, 'Vertical', 'Instantaneous Element' );                

    %% Section 2: Calling Selected Instantaneous Elements
        for vertical_Cell_of_Instantaneous_Elements_Names_Index = 1 : size ( vertical_Cell_of_Instantaneous_Elements_Names, 1 )
            selected_Instantaneous_Element_Function                    = str2func ( char ( vertical_Cell_of_Instantaneous_Elements_Names ( vertical_Cell_of_Instantaneous_Elements_Names_Index, 1 ) ) );
            selected_Instantaneous_Element_Value                        = selected_Instantaneous_Element_Function( input_Single_sub_Region, input_Single_sub_Region_or_Input_Single_sub_Region_IQ_Component );  % selected_Instantaneous_Element_Function: like ( Amplitude, Phase, Frequency ) 
            
            vertical_Structure_of_Selected_Instantaneous_Elements_for_Mentioned_Single_sub_Region ( vertical_Cell_of_Instantaneous_Elements_Names_Index, 1 ) . instantaneous_Elment_Name = char ( vertical_Cell_of_Instantaneous_Elements_Names ( vertical_Cell_of_Instantaneous_Elements_Names_Index, 1 ) );
            vertical_Structure_of_Selected_Instantaneous_Elements_for_Mentioned_Single_sub_Region ( vertical_Cell_of_Instantaneous_Elements_Names_Index, 1 ) . instantaneous_Elment_Value = selected_Instantaneous_Element_Value;
            
        end

end