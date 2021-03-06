#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated April 2010
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

$input=shift;
open (IN, "<$input");
while (<IN>){
    chomp;
    next unless(/\S/);
    print "cd $_\n";
    print "echo --------------------------------------------------\n";
    print "echo Dealing $_\n";
    print "echo --------------------------------------------------\n";
    print "cd mydata/phd_dir/\n";
    print "perl ~/SeqQual/rename_phd-ab1.pl\n";
    print "source rename-ab1.txt\n";
    print "perl ~/SeqQual/rename_phd-abd.pl\n";
    print "source rename-abd.txt\n";
    print "perl ~/SeqQual/rename_phd-scf.pl\n";
    print "source rename-scf.txt\n";
    print "cd ../../../\n\n\n";
}
