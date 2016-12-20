function output = Project_Manager ( varargin )

% do_You_Want_to_Make_new_DataBase
do_You_Want_to_Make_new_DataBase = 0;
selected_DataBase_File_Name = 'DataSet.mat';

vertical_Cell_of_Instantaneous_Elements_Names = {'Amplitude_Element', 'Phase_Element', 'Amplitude_Element'};
vertical_Cell_of_Statistics_Names = {'Skewness', 'Variance', 'Mean'};
selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst = 'Skewness';
selected_Kernel_Function = 'RBF';
drawing_Graph_Strategy = 'on';
    %% Section 0: Preliminaries
        % Level 1: Cleaning
            clc;
            close all;
        
        % Level 2: Adding Essential Parameters           
            Add_Pather ( 'ZigBee_Classifier_Project' )
            
    %% Section 1: Extraction of Essential Paramters
%         input_Arguments = inputparser();
%         
%         input_Arguments.parse (varargin{:});
%         
        
    %% Section 2: Data Loading
        if ( exist ( selected_DataBase_File_Name, 'file' ) == 0 ) || ...
           ( do_You_Want_to_Make_new_DataBase == 1 )
            Address;
            load ( selected_DataBase_File_Name );
            
        else
            load ( selected_DataBase_File_Name );
            
        end

    %% Section 3: Preprocessing
    
    %% Section 4: Feature Extraction
        vertical_Structure_of_FingerPrintf_DataBank_for_all_Devices = FingerPrint_Production_Manager (   vertical_Cell_of_Instantaneous_Elements_Names,                ...
                                                                                                         vertical_Cell_of_Statistics_Names,                            ...
                                                                                                         selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst,  ...
                                                                                                         Vertical_Structure_of_all_Devices);
vertical_Structure_of_FingerPrintf_DataBank_for_all_Devices = vertical_Structure_of_FingerPrintf_DataBank_for_all_Devices ( 1 : 2, 1 );
    %% Section 5: Post Processing   
        % Level 1: Convert the DataBank Structure to the Matrix
            matrix_of_FingerPrintf_DataBank_for_all_Devices = DataBank_Structure_to_DataBank_Matrix_Converter ( vertical_Structure_of_FingerPrintf_DataBank_for_all_Devices );
    
            
            
            
matrix_of_FingerPrintf_DataBank_for_all_Devices
matrix_of_FingerPrintf_DataBank_for_all_Devices = abs (matrix_of_FingerPrintf_DataBank_for_all_Devices);     
    %% Section 6: Classification        
    
            % Level 1: SVM
                % Stage 1: Matlab_SVM
                    Matlab_SVM (  matrix_of_FingerPrintf_DataBank_for_all_Devices,                     ... should be (d+1) x n >> [   [X]:dxn  ;  [y]:1xn  ]; 
                                           selected_Kernel_Function,                                            ...
                                           drawing_Graph_Strategy                                               ... true or false  (Default: false)
                                           )

                % Stage 2: Faradars SVM          
            
