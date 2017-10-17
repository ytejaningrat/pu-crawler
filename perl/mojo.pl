#!/usr/bin/perl

use strict;
use warnings;
use Mojo::UserAgent;

sub say {
 print join "\n", @_;
 print "\n";
};
sub img {
 print "<img class='left' src=\'", @_, "\' width=80px height=80px />";
}
my $url = "http://pu.go.id/main/arsip/";
my $mua = Mojo::UserAgent->new;
my $res = $mua->get($url)->result;

my @images = $res->dom
                 ->find('div[class*="artikel-konten"] div img')
                 ->map(attr => 'src')
                 ->map( sub { s|/\z||r } )
                 ->each;
#say @images;

my @links = $res->dom
                ->find('div[class*="artikel-konten"] div a[class*="index"]')
                ->map(attr => 'href')
                ->map( sub { s|/\z||r } )
                ->each;
#say @links;

my @titles = $res->dom
                 ->find('div[class*="artikel-konten"] div a[class*="index"]')
                 ->map('text')
                 ->map( sub { s|/\z||r } )
                 ->each;
#say @titles;

my @contents = $res->dom
                   ->find('div[class*="artikel-konten"] div p')
                   ->map('text')
                   ->map( sub { s|/\z||r } )
                   ->each;
#say @contents;

my @metas = $res->dom
                ->find('div[class*="artikel-konten"] div div[class*="artikel-meta"] span')
                ->map('text')
                ->map( sub { s|/\z||r } )
                ->each;
#say @metas;


print "<div class='artikel-konten'>\n";
for (my $i=0; $i < 10; $i++) {
 print "<div style='display:inline-block;'>\n";
 print "<a class='index' href='", $links[$i] , "'>";
 img $images[$i];
 print $titles[$i], "</a><br />\n";
 print "<p style='text-align:justify;'>", $contents[$i], "</p>";
 print "</div>\n"
}
print "</div>\n";
