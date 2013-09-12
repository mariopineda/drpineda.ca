#!/usr/bin/perl

###########################################################
# Filename: sitemap.pl
# Author:   Paul Greenberg
# Website:  www.isrcomputing.com
# License:  GPLv3
###########################################################

use strict;
use warnings;
use WWW::Crawler::Lite;

###########################################################
# GLOBAL VARIABLES
###########################################################

my %pages = ();
my $pattern = 'http://mpkanalytics.com';
my %links = ();
my $downloaded = 0;
my $MAX_DOWN = 1000;
my $date = "2013-08-08";
my $output = "sitemap.xml";
my $path = "http://mpkanalytics.com/";

###########################################################
# MAIN
###########################################################

open GFILE, ">", $output or die $!;
print GFILE "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
print GFILE "<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n";

my $crawler;
$crawler = WWW::Crawler::Lite->new(
 agent       => 'Sitemap/1.0',
 url_pattern => $pattern,
 http_accept => [qw( text/plain text/html )],
 on_response => sub {
  my ($url, $res) = @_;
  printf GFILE ("<url><loc>%s</loc><lastmod>%s</lastmod><changefreq>monthly</changefreq><priority>0.5</priority></url>\n", $url, $date);
  print "Found $downloaded $url\n";
  $downloaded++;
  $crawler->stop() if $downloaded++ > $MAX_DOWN;
 },
 on_link     => sub {
  my ($from, $to, $text) = @_;
  return if exists($pages{$to}) && $pages{$to} eq 'BAD';
  $pages{$to}++;
  $links{$to} ||= [ ];
  push @{$links{$to}}, { from => $from, text => $text };
 },
 on_bad_url => sub {
  my ($url) = @_;
  # Mark this url as 'bad':
  $pages{$url} = 'BAD';
 }
);

$crawler->crawl( url => $path );

print GFILE "</urlset>\n";
close(GFILE);
print "Completed!\n";
exit(0);