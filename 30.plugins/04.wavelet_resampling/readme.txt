MATLAB Compiler

1. Prerequisites for Deployment 

. Verify the MATLAB runtime is installed and ensure you    
  have installed version 8.4 (R2014b).   

. If the MATLAB runtime is not installed, do the following:
  (1) enter
  
      >>mcrinstaller
      
      at MATLAB prompt. The MCRINSTALLER command displays the 
      location of the MATLAB runtime installer.

  (2) run the MATLAB runtime installer.

Or download the Linux 64-bit version of the MATLAB runtime for R2014b 
from the MathWorks Web site by navigating to

   http://www.mathworks.com/products/compiler/mcr/index.html
   
   
For more information about the MATLAB runtime and the MATLAB runtime installer, see 
Distribution to End Users in the MATLAB Compiler documentation  
in the MathWorks Documentation Center.    


2. Files to Deploy and Package

Files to package for Standalone 
================================
-generate_surrogates 
-run_generate_surrogates.sh (shell script for temporarily setting environment variables 
                             and executing the application)
   -to run the shell script, type
   
       ./run_generate_surrogates.sh <mcr_directory> <argument_list>
       
    at Linux or Mac command prompt. <mcr_directory> is the directory 
    where version 8.4 of the MATLAB runtime is installed or the directory where 
    MATLAB is installed on the machine. <argument_list> is all the 
    arguments you want to pass to your application. For example, 

    If you have version 8.4 of the MATLAB runtime installed in 
    /mathworks/home/application/v84, run the shell script as:
    
       ./run_generate_surrogates.sh /mathworks/home/application/v84
       
    If you have MATLAB installed in /mathworks/devel/application/matlab, 
    run the shell script as:
    
       ./run_generate_surrogates.sh /mathworks/devel/application/matlab
-MCRInstaller.zip
   -if end users are unable to download the MATLAB runtime using the above  
    link, include it when building your component by clicking 
    the "Runtime downloaded from web" link in the Deployment Tool
-This readme file 

3. Definitions

For information on deployment terminology, go to 
http://www.mathworks.com/help. Select MATLAB Compiler >   
Getting Started > About Application Deployment > 
Application Deployment Terms in the MathWorks Documentation 
Center.


4. Appendix 

A. Linux x86-64 systems:
   On the target machine, add the MATLAB runtime directory to the environment variable 
   LD_LIBRARY_PATH by issuing the following commands:

        NOTE: <mcr_root> is the directory where MATLAB runtime is installed
              on the target machine.         

            setenv LD_LIBRARY_PATH
                $LD_LIBRARY_PATH:
                <mcr_root>/v84/runtime/glnxa64:
                <mcr_root>/v84/bin/glnxa64:
                <mcr_root>/v84/sys/os/glnxa64:
                <mcr_root>/v84/sys/opengl/lib/glnxa64
            setenv XAPPLRESDIR <mcr_root>/v84/X11/app-defaults

   For more detail information about setting the MATLAB runtime paths, see Distribution 
   to End Users in the MATLAB Compiler documentation in the MathWorks Documentation 
   Center.


     
        NOTE: To make these changes persistent after logout on Linux 
              or Mac machines, modify the .cshrc file to include this  
              setenv command.
        NOTE: The environment variable syntax utilizes forward 
              slashes (/), delimited by colons (:).  
        NOTE: When deploying standalone applications, it is possible 
              to run the shell script file run_generate_surrogates.sh 
              instead of setting environment variables. See 
              section 2 "Files to Deploy and Package".    






