
    %% Section 0: Preliminaries
        % Level 1: Screen and Ram Cleaning
            clc;
            clear all;
    
        % Level 1: Matlab Warnings
            warning off Matlab:namelengthexceeded
            
        % Level 2: Adding Essential Passes
            Add_Pather ( 'ZigBee_Classifier_Project' );
            
    %% Section 1: Calling 'FingerPrint_Production_Manager'
    
vertical_Cell_of_Instantaneous_Elements_Names = {'Amplitude_Element', 'Phase_Element', 'Amplitude_Element'};
vertical_Cell_of_Statistics_Names = {'Skewness', 'Variance', 'Mean'};
selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst = 'Skewness';

% Generation of By=ursts
    for device_Index = 1 : 100
        for burst_Index = 1 : 5

            for number_of_subRegions = 1 : 33
                if ( number_of_subRegions ~= 33)
                    vertical_Structure_of_a_Single_Burst( number_of_subRegions, 1 ).subRegion = rand ( 1, 100 );
                else
                    vertical_Structure_of_a_Single_Burst( number_of_subRegions, 1 ).subRegion = rand ( 1, 3200 );
                end
            end

            Vertical_Structure_of_all_Bursts ( burst_Index, 1 ). a_Single_Burst = vertical_Structure_of_a_Single_Burst;

        end  

        Vertical_Structure_of_all_Devices ( device_Index, 1 ).a_Single_Device = Vertical_Structure_of_all_Bursts;

    end
    
    
        vertical_Structure_of_FingerPrintf_all_Devices = FingerPrint_Production_Manager (   vertical_Cell_of_Instantaneous_Elements_Names,                ...
                                                                                             vertical_Cell_of_Statistics_Names,                            ...
                                                                                             selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst,  ...
                                                                                             Vertical_Structure_of_all_Devices);
                                                                                         
                                                                                         