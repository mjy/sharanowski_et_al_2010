#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;	
#  use diagnostics;

use lib qw(lib/);

use Psy::Psy;
use Psy::Output::Output;

# Deterostomes

my %params = ( 
	'-matrix_file' => 'dataset2_genejack.txt',
	'-matrix_label' => 'my_label',
	'-helix_index' => '',
	'-fileformat' => 'nexus',
	'-path' => '',
	'-number_terminals' => 15, # n - 1 
	'-project_name' => 'test'
);

# prot_deut 

#my $core_slice = slice->new;
#$core_slice->taxa(0..100);
#$core_slice->blocks(0..1083);
#$core_slice->remove('Blocks', @non_core);

### Read/setup

my $foo = Psy->new(%params);
my $mx = $foo->mx('-matrix_label' => 'my_label');

# my $orig_slice = $mx->origSlice;
# $orig_slice->remove('Taxa', @deut_bad_seqs);

my $o = output->new();

### Generate output

# 15 random (jacknife)

for (my $i = 1; $i < 101; $i++) {
  print "\n\nFILE: $i";
  my $slice = $mx->origSlice->newRandomSlice('numblocksmax' => 15, 'numblocksmin' => 15);
	print "blocks:\t", join (" ", sort {$a <=> $b} keys %{$slice->blocks}),"\n"	;
  $o->MrBayes('-mx' => $mx, '-slice' => $slice, '-file_name' => "$i.nex" );
}


# my @word_sizes;
# $o->Phase('-mx' => $mx);



# for (my $i = 1; $i < 10; $i++) {
# @word_sizes = (6);

# $o->KwordProfile('-mx' => $mx,  '-mode' => 'all_fused', '-kword_size' => \@word_sizes);

# $o->Kword('-mx' => $mx, '-format' => 'tnt', '-file_name' => "all_6_missing_1" , '-kword_size' => \@word_sizes,	'-zero_length_missing' => 1 ); # '-kword_size' => [8]

# $o->Tnt('-mx' => $mx, '-slice' => $reduced_slice);
#}
#$o->Nexus('-mx' => $mx, '-slice' => $reduced_slice);
# ,'-translation_mode' => 'all',

