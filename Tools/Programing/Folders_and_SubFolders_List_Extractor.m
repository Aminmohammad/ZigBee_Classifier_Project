function [ names_of_all_Extracted_Folders_and_SubFolders ] = Folders_and_SubFolders_List_Extractor ( root_Folder_Name_or_Address )

% This program Lists all Folders and SubFolders in the 'root_Folder_Name_or_Address'

% Case 1: 'Full Input'
    %       If you write the full address of  root folder ( root_Folder_Name_or_Address ), 
    %       no matter where this folder is, this program will lsit all subfolders in that address.
    %
    %     For example: 
    %                   [ target_Folder_Address, Explanation ] = Folder_Address_Extractor ( 'U:\Matlab_2011' );

% Case 2: 'Root Name'    
    %       But, if you write just the name of root folder (root_Folder_Name_or_Address), this program searches for the 
    %       'root_Folder_Name_or_Address' in the address of 'current folder', and if there is no such address, it gives error.
    %
    %       For example: If this program is in the Follwoing branch: 
    %                    U:\MAHAB\Ph.D._Files\Matlab_Learning\Classification\Supervised\1_Bayesian_Decision_Method
    %                    and we just call the program:            Folder_Address_Extractor ( 'Matlab_Learning') 
    %                    This pro will list all the subfolders of 'Matlab_Learning' folder.

% Output:      
    %       How to Show the results of this Program:
    %              [ names_of_all_Extracted_Folders_and_SubFolders ] = Folder_Address_Extractor ( 'Matlab_Learning' );
    %              for index = 1 : size ( names_of_all_Extracted_Folders_and_SubFolders, 1 )
    %                  fprintf( '        %s\n', char(names_of_all_Extracted_Folders_and_SubFolders ( index, 1 ) ) );
    %            
    %              end


    %% Section 0: Preliminaries
        warning off MATLAB:namelengthmaxexceeded
        
    %% Section 1: Extraction of Root Folder Adress ( If User just Entered the Name of Folder, or left it empty, not the Address )
       if (  isempty ( strfind ( root_Folder_Name_or_Address, '\' ) ) == 1 )
            current_Address = pwd;
            
            if ( isempty ( root_Folder_Name_or_Address )  == 0 )
                root_Folder_Starting_Index = strfind( current_Address, root_Folder_Name_or_Address );
                            
                if ( isempty ( root_Folder_Starting_Index ) == 0 ) 
                    root_Folder_Name_or_Address = current_Address ( 1, 1 : root_Folder_Starting_Index + length ( root_Folder_Name_or_Address ) - 1  ); 

                else
                    error( 'Current Branch of this Program, Does not have the Mentioned Root Folder Name. ' )

                end
                
            else % in this case, user entered an emty string as 'root_Folder_Name_or_Address', then the Drive (eg. C:\ ) will be selected as the default 'root_Folder_Name_or_Address'
                indices_of_slashes = strfind ( current_Address, '\' );
                root_Folder_Name_or_Address =  current_Address( 1, 1 : indices_of_slashes ( 1, 1 ) );
                
            end

        end

    %% Section 2: Extraction of SubFolders of Current Folder    
        current_Folder_Address = root_Folder_Name_or_Address;
        is_the_Folder_Found = 0;
        is_the_loop_Finished = 0;
        
        the_Addresses_of_all_New_FoldersOrSubFolders_and_also_FoldersOrSubFolders_from_Previous_Runs_Which_are_not_Covered_Yet = cell( 0, 0 );
        names_of_all_Extracted_SubFolders_up_to_Now = cell(0,0);
        
        % Level 1: Selection of Subfolders and Files of Current Folder    
            while ( is_the_Folder_Found == 0) && ( is_the_loop_Finished == 0 )
                
                names_of_all_SubFolders_in_Current_Folder_Vector = cell(0,0);
                Files_and_SubFolders_of_Current_Folder = dir ( current_Folder_Address );

                % Stage 1: Saving the Extracted Addresses of all 'Folders' and 'Subfolders' up to Now
                    names_of_all_Extracted_SubFolders_up_to_Now = [ names_of_all_Extracted_SubFolders_up_to_Now; current_Folder_Address];
                    
                % Stage 2: all Subfolders and Files
                    for index_of_Files_and_SubFolders_of_Current_Folder = 1 : size ( Files_and_SubFolders_of_Current_Folder, 1 )

                        % Part 1: Current File or Folder: Check if this Name is a Valid SubFolder (and not a File)                        
                            if ( Files_and_SubFolders_of_Current_Folder( index_of_Files_and_SubFolders_of_Current_Folder, 1 ).isdir == 1 ) &&  ...
                               ( strcmp( Files_and_SubFolders_of_Current_Folder( index_of_Files_and_SubFolders_of_Current_Folder, 1 ).name, '.' ) == 0 ) && ...
                               ( strcmp( Files_and_SubFolders_of_Current_Folder( index_of_Files_and_SubFolders_of_Current_Folder, 1 ).name, '..' ) == 0 )     

                                % Devision 1: Storing the name of this SubFolder in the List of all SubFolders 
                                    names_of_all_SubFolders_in_Current_Folder_Vector( size(names_of_all_SubFolders_in_Current_Folder_Vector, 1) + 1, 1 ) = {Files_and_SubFolders_of_Current_Folder( index_of_Files_and_SubFolders_of_Current_Folder, 1 ).name};

                            end
                    end

                % Stage 3: Storing the Address of all Valid SubFolders                     
                        the_Addresses_of_all_Subfolders_in_Current_Folder     = strcat( sprintf( '%s\\', current_Folder_Address), names_of_all_SubFolders_in_Current_Folder_Vector );

                % Stage 4: Detecting the Indices of all New Addresses    
                        indices_of_Rows_Containing_the_Name_of_Current_Folder = strfind ( the_Addresses_of_all_New_FoldersOrSubFolders_and_also_FoldersOrSubFolders_from_Previous_Runs_Which_are_not_Covered_Yet, current_Folder_Address );
                    
                % Stage 5: Detecting the Addresses of all Extracted Indices                         
                        new_SubFolders_Addresses = cell(0,0);
                        for index = 1 : size ( indices_of_Rows_Containing_the_Name_of_Current_Folder, 1 )                             
                            if ( isa( indices_of_Rows_Containing_the_Name_of_Current_Folder( index, 1 ), 'double' )  )
                                if ( isempty(indices_of_Rows_Containing_the_Name_of_Current_Folder( index, 1 ) == 1 ) )
                                    new_SubFolders_Addresses ( size ( new_SubFolders_Addresses, 1 ) + 1, 1 ) = the_Addresses_of_all_New_FoldersOrSubFolders_and_also_FoldersOrSubFolders_from_Previous_Runs_Which_are_not_Covered_Yet( index, 1 );                      

                                end
                                
                            else
                                
                                if ( isempty(cell2mat(indices_of_Rows_Containing_the_Name_of_Current_Folder( index, 1 )) == 1 ) )
                                    new_SubFolders_Addresses ( size ( new_SubFolders_Addresses, 1 ) + 1, 1 ) = the_Addresses_of_all_New_FoldersOrSubFolders_and_also_FoldersOrSubFolders_from_Previous_Runs_Which_are_not_Covered_Yet( index, 1 );                      

                                end                                
                                
                            end

                        end

                % Stage 6: Writing The Address of all Valid Subfolders for next Iterations
                        if ( size( the_Addresses_of_all_Subfolders_in_Current_Folder, 1 ) == 1 )                            
                            string = char( the_Addresses_of_all_Subfolders_in_Current_Folder );

                            if ( strcmp ( string ( 1, end ), '\' ) == 1  ) % in this case, we just had an empty    address as next Subfolder 
                                the_Addresses_of_all_New_FoldersOrSubFolders_and_also_FoldersOrSubFolders_from_Previous_Runs_Which_are_not_Covered_Yet = new_SubFolders_Addresses;

                            else                                           % in this case, we      had a  Valid    address as next Subfolder 
                                the_Addresses_of_all_New_FoldersOrSubFolders_and_also_FoldersOrSubFolders_from_Previous_Runs_Which_are_not_Covered_Yet = vertcat ( new_SubFolders_Addresses, the_Addresses_of_all_Subfolders_in_Current_Folder );

                            end

                        else                                               % in this case, we      had many  Valid address as next Subfolders 
                            the_Addresses_of_all_New_FoldersOrSubFolders_and_also_FoldersOrSubFolders_from_Previous_Runs_Which_are_not_Covered_Yet = vertcat ( new_SubFolders_Addresses, the_Addresses_of_all_Subfolders_in_Current_Folder );

                        end

                % Stage 7: Extraction of Next SubFolder Address for next Iteration
                       if ( isempty ( the_Addresses_of_all_New_FoldersOrSubFolders_and_also_FoldersOrSubFolders_from_Previous_Runs_Which_are_not_Covered_Yet ) == 0 )
                            current_Folder_Address = char(the_Addresses_of_all_New_FoldersOrSubFolders_and_also_FoldersOrSubFolders_from_Previous_Runs_Which_are_not_Covered_Yet( 1, 1 ));

                       else
                            is_the_loop_Finished = 1;

                       end
                                     
            end
        
        % Level 2: Saving all Extracted Folder
            names_of_all_Extracted_Folders_and_SubFolders = names_of_all_Extracted_SubFolders_up_to_Now;             
            
    end