#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

@ids=qx{ls};
foreach $id(@ids){
    chomp $id;
    next unless $id =~ /\.arp/;
    if ($id=~/genotypicdata0/){$note="hap";}
    if ($id=~/genotypicdata1/){$note="dip";}
    $number=$id;
    $number=~s/\..*//;
    $name=$number.".".$note.".arp";
    system ("cp $id $name");
    system ("mv $name ../../../Output/arlequin");
}    
