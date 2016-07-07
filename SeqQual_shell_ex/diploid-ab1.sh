#!/bin/sh

echo SeqQual processing for diploid *.ab1 chromatogram data.
    # Quality information from the *.phd.1 files will be added to output alignments
perl ~/SeqQual/checkdir_Output.pl
mkdir Output
cd Output
mkdir aln
cd ..

echo ======================================================================
echo Do alignment and create working directories/files.
echo ======================================================================
    # "inputfile" is the txt file containing the subdir or list of subdir where the *.ab1/abd/scf
    # files are located (& eventually users' own *.phd.1/*.poly files).
    # all "inputfile" parameters which follow are the same.
    # The first 2 Values after "inputfile" are those of two parameters related to the polyphred file, in order:
    # the polymorphism_score of the polyphred output file (see help for more)
    # the trim_quality_score in the same file, should be below phred score
    # Values after those first two are for the following parameters of the Phrap software, in order: 
    # default_qual
    # trim_start 
    # force_level
    # bypass_level
    # maxgap
    # repeat_stringency (RS)
    # nodeseg
    # nodespace
    # qual_show
    # max_subclone_size
    # trim_score
    # trim_penalty
    # trim_qual
    # confirm_length
    # confirm_trim
    # confirm_penalty
    # confirm_score
    # Indexwordsize
    # most do not need to be changed, except RS (default 0.7) which can be lowered to force alignment
    # and maxgap (default 30) which can be increased to force alignment in case of large indels. refer to SeqQual helpfile 
    # or the Phrap documentation for further details

perl ~/SeqQual/print_source-aln-diploid-ab1.pl inputfile 60 20 15 0 0 1 100 0.5 8 4 20 5000 20 -2 13 8 1 -5 30 10 > source-aln.txt
source source-aln.txt
     # All same values here than above need to be put before ">>"
perl ~/SeqQual/print_log-aln-diploid-ab1.pl 60 20 15 0 0 1 100 0.5 8 4 20 5000 20 -2 13 8 1 -5 30 10 >> log.txt

     # Option which allows the user to use its own *.phd.1/*.poly files instead of producing them by 
     # the phred/polyphred softwares. If some *.phd.1/*.poly files are missing, the ones produced automatically will be used
     # so that the analysis does not stop.
 #echo ======================================================================
 #echo Insert user phd and poly files.
 #echo ======================================================================
#perl ~/SeqQual/print_source-userphd-diploid-ab1.pl inputfile > source-userphd.txt
#source source-userphd.txt
#perl ~/SeqQual/print_log-userphd-diploid-ab1.pl >> log.txt

     # option below can be used if "own phd.1/poly" have been used and this will rename any phd.1 file
     # which does not have the correct abd/ab1/scf extension  
 #echo ======================================================================
 #echo Rename phd files.
 #echo ======================================================================
#perl ~/SeqQual/print_source-renamephd.pl inputfile > source-renamephd.txt
#source source-renamephd.txt
#perl ~/SeqQual/print_log-renamephd.pl >> log.txt

 echo ======================================================================
 echo Write fasta alignment files.
 echo ======================================================================
     # The values after "inputfile" refer to the Phred score and Heterozygote score needed in 
     # the Phred/Polyphred softwares respectively, they can be changed
perl ~/SeqQual/print_source-write_aln-diploid.pl inputfile 30 90 > source-write_aln.txt
source source-write_aln.txt
     # same values here than above need to be put before ">>"
perl ~/SeqQual/print_log-write_aln-diploid.pl 30 90 >> log.txt

 echo ======================================================================
 echo Replace isolated nucleotides in alignment files.
 echo ======================================================================
     # this will by default replace isolated nucleotides which are surrounded by at least 5 
     # "?????" by ? also, for up to 3 isolated nucleotides, to use with caution
     # value after "inputfile" refers to the max number of isolated nucleotides 
     # considered (1, 2 or 3)
perl ~/SeqQual/print_source-replace.pl inputfile 3 > source-replace.txt
source source-replace.txt
     # same value here than above needs to be put before ">>" 
perl ~/SeqQual/print_log-replace.pl 3 >> log.txt

 echo ======================================================================
 echo Truncate start and end of alignment files.
 echo ======================================================================
    # parameter value after "inputfile" means that columns (bases in alignment) 
    # with so many ? at both start and end of sequences will be truncated 
perl ~/SeqQual/print_source-truncate.pl inputfile 1 > source-truncate.txt
source source-truncate.txt
    # same value here than above needs to be put before ">>" 
perl ~/SeqQual/print_log-truncate.pl 1 >> log.txt

      # WARNING: the option remove1 cant' be used at the same time than the "remove2" option below
 echo ======================================================================
 echo Remove bad columns with deletion in consensus.
 echo ======================================================================
       # This option will remove any column corresponding to one base in the alignment that includes only ? and deletion (-) 
       # with a deletion (-) in the consensus sequence
perl ~/SeqQual/print_source-remove1.pl inputfile > source-remove1.txt
source source-remove1.txt
perl ~/SeqQual/print_log-remove1.pl >> log.txt

      # WARNING: the option "remove2" cant' be used at the same time than the "remove1" option above
      # so comment out the option above in order to use this one 
      # WARNING2: all that is being corrected by "remove2" includes what would be corrected using "remove1"
 #echo ======================================================================
 #echo Remove bad columns with base A, G, C or T in consensus.
 #echo ======================================================================
       # This option will remove any column corresponding to one base in the alignment that includes only ? and deletion (-) 
       # with a base (A, G, C or T) or not (-) in the consensus sequence
#perl ~/SeqQual/print_source-remove2.pl inputfile > source-remove2.txt
#source source-remove2.txt
#perl ~/SeqQual/print_log-remove2.pl >> log.txt

 echo ======================================================================
 echo Delete empty alignment files.
 echo ======================================================================
     # due to the integration of quality and truncate/removed options, some alignments may
     # be empty at the end of the pipeline, and these will be deleted
perl ~/SeqQual/print_source-delete_files.pl inputfile > source-delete_files.txt
source source-delete_files.txt

 echo ======================================================================
 echo Take alignment files into directory Output/aln.
 echo ======================================================================
perl ~/SeqQual/print_source-take_aln.pl inputfile > source-take_aln.txt
source source-take_aln.txt

 echo ======================================================================
 echo Take log file into directory Output.
 echo ======================================================================
perl ~/SeqQual/take_log_to_output.pl
