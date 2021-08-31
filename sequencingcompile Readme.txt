Converting sequencing BAM files to Excel data (updated 6/8/2021)

1. Place .bam and .bam.bai files onto a PC with Matlab installed.
   - The .bam and .bambai files are located in the “Alignment” folder:\Data\Intensities\BaseCalls\Alignment.
   - Move these files into the “Illumina scripts” folder in the Documents\Matlab directory.

2. Create .mat files for all 24 samples in Matlab
   - Open Matlab and make sure the Current Directory is set to the scripts folder and that the sequencingcompile.m script is listed at this level.
   - Run the script for each sample by typing (exactly) in the Command Window: sequencingcompile(‘YOURSAMPLE1.bam’); and hitting return.
   - After a delay (up to 20 min), the computer will beep and the script will output a ANS file in the Workspace, which contains coordinates for all reads.
   - Rename ANS to the corresponding sample name, then save as YOURSAMPLE1 selecting the .mat file format. Matlab files cannot have spaces or hyphens- in their names, so use underscores_.
   - Clear the Workspace by typing: clear all in the Command Window.
   - Repeat until you have .mat files for all 24 samples. 

3. Create a single Excel file with read counts in Matlab
   - Make sure the sequencingcompile2.m script and all 24 .mat files are listed in the Current Directory.
   - Load the 24 samples into the Workspace by double-clicking each of them.
   - Type sequencingcompile2(); into the Command Window.
   - The script will output an Excel file listing the read counts in 1 kb bins for all 24 samples.
