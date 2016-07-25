#!/usr/bin/perl

use warnings;
use JSON;
use Data::Dumper;

my $arg1 = $ARGV[0];
my $arg2 = $ARGV[1];
my $arg3 = $ARGV[2];


     # AS_NEIGHBOURS
if ($arg1 eq "AS_NEIGHBOURS") {
  my $url ="https://stat.ripe.net/data/asn-neighbours/data.json?resource=$arg2";
  my $json_text = `curl --silent $url`;
  my $decoded = decode_json($json_text);

  my @neighb = @{$decoded->{'data'}{'neighbours'}};
#  print "-----start-----\n";
  my $i =0;
  foreach my $f (@neighb) {
    $i++;
#    print "ASN Neighbour: ". $f->{"asn"} . "\n";
#    print "---\n";
  }
#  print "Total peers: $i\n";
#  print "------end------\n";
  print "$i\n";

     # ROUTING_STATUS_AS ALL METRICS
} elsif ($arg1 eq "ROUTING_STATUS_AS") {
  my $url = "https://stat.ripe.net/data/routing-status/data.json?resource=$arg2";
  my $json_text = `curl --silent $url`;
  my $decoded = decode_json($json_text);
  print "-----start-----\n";
  print "ASN total_ris_peers: ". $decoded->{'data'}{'visibility'}{'v4'}{'total_ris_peers'} . "\n";
  print "ASN ris_peers_seeing: ". $decoded->{'data'}{'visibility'}{'v4'}{'ris_peers_seeing'} . "\n";
  print "ASN announced_prefixes: ". $decoded->{'data'}{'announced_space'}{'v4'}{'prefixes'} . "\n";
  print "ASN observed_neighbours: ". $decoded->{'data'}{'observed_neighbours'} . "\n";

     # ROUTING_STATUS_AS_TOTAL_RIS_PEERS
} elsif ($arg1 eq "ROUTING_STATUS_AS_TOTAL_RIS") {
  my $url = "https://stat.ripe.net/data/routing-status/data.json?resource=$arg2";
  my $json_text = `curl --silent $url`;
  my $decoded = decode_json($json_text);
  print "$decoded->{'data'}{'visibility'}{'v4'}{'total_ris_peers'}\n";

     # ROUTING_STATUS_AS_RIS_SEEING_PEERS
} elsif ($arg1 eq "ROUTING_STATUS_AS_RIS_SEEING_PEERS") {
  my $url = "https://stat.ripe.net/data/routing-status/data.json?resource=$arg2";
  my $json_text = `curl --silent $url`;
  my $decoded = decode_json($json_text);
  print "$decoded->{'data'}{'visibility'}{'v4'}{'ris_peers_seeing'}\n";

     # ROUTING_STATUS_AS_ANNOUNCED_PREFIX
} elsif ($arg1 eq "ROUTING_STATUS_AS_ANNOUNCED_PREFIX") {
  my $url = "https://stat.ripe.net/data/routing-status/data.json?resource=$arg2";
  my $json_text = `curl --silent $url`;
  my $decoded = decode_json($json_text);
  print "$decoded->{'data'}{'announced_space'}{'v4'}{'prefixes'}\n";

     # ROUTING_STATUS_AS_OBSERVED_NEIGHBOURS
} elsif ($arg1 eq "ROUTING_STATUS_AS_OBSERVED_NEIGHBOURS") {
  my $url = "https://stat.ripe.net/data/routing-status/data.json?resource=$arg2";
  my $json_text = `curl --silent $url`;
  my $decoded = decode_json($json_text);
  print "$decoded->{'data'}{'observed_neighbours'}\n";

     # ROUTING_STATUS_IP
} elsif ($arg1 eq "ROUTING_STATUS_IP") {
  my $url = "https://stat.ripe.net/data/routing-status/data.json?resource=$arg2";
  my $json_text = `curl --silent $url`;
  my $decoded = decode_json($json_text);
  print "-----start-----\n";
  print "IP_block $arg2 total_ris_peers: ". $decoded->{'data'}{'visibility'}{'v4'}{'total_ris_peers'} . "\n";
  print "IP_block $arg2 ris_peers_seeing: ". $decoded->{'data'}{'visibility'}{'v4'}{'ris_peers_seeing'} . "\n";
  print "------end------\n";

     # ROUTING_STATUS_IP_TOTAL_RIS_PEERS
} elsif ($arg1 eq "ROUTING_STATUS_IP_TOTAL_RIS_PEERS") {
  my $url = "https://stat.ripe.net/data/routing-status/data.json?resource=$arg2";
  my $json_text = `curl --silent $url`;
  my $decoded = decode_json($json_text);
  print "$decoded->{'data'}{'visibility'}{'v4'}{'total_ris_peers'}\n";

     # ROUTING_STATUS_IP_RIS_SEEING_PEERS
} elsif ($arg1 eq "ROUTING_STATUS_IP_RIS_SEEING_PEERS") {
  my $url = "https://stat.ripe.net/data/routing-status/data.json?resource=$arg2";
  my $json_text = `curl --silent $url`;
  my $decoded = decode_json($json_text);
  print "$decoded->{'data'}{'visibility'}{'v4'}{'ris_peers_seeing'}\n";


     # REVERSE_DNS_BLOCK
} elsif ($arg1 eq "REVERSE_DNS_BLOCK") {
  my $url = "https://stat.ripe.net/data/reverse-dns-consistency/data.json?resource=$arg2";
  my $json_text = `curl --silent $url`;
  my $decoded = decode_json($json_text);
  my @domains = @{$decoded->{'data'}{'prefixes'}{'ipv4'}{$arg2}{'domains'}};
  print "-----start-----\n";
  foreach my $f (@domains) {
    print "Prefix: ". $f->{"prefix"} . "\n";
    print "Domain: ". $f->{"domain"} . "\n";
    print "Found: ". $f->{"found"} . "\n";
    print "check status: ". $f->{"dnscheck"}{"status"} . "\n";
    print "---\n";
  }
  print "------end------\n";

      # REVERSE_DNS_BLOCK_FOUND
} elsif ($arg1 eq "REVERSE_DNS_BLOCK_FOUND") {
  my $url = "https://stat.ripe.net/data/reverse-dns-consistency/data.json?resource=$arg2";
  my $json_text = `curl --silent $url`;
  my $decoded = decode_json($json_text);
  my @domains = @{$decoded->{'data'}{'prefixes'}{'ipv4'}{$arg2}{'domains'}};
  foreach my $f (@domains) {
    if ($f->{'found'} =~ /true/i) {
      print "1\n";
    } else {
      print "0\n";
    }
  }

     # REVERSE_DNS_BLOCK_CHECK
} elsif ($arg1 eq "REVERSE_DNS_BLOCK_CHECK") {
  my $url = "https://stat.ripe.net/data/reverse-dns-consistency/data.json?resource=$arg2";
  my $json_text = `curl --silent $url`;
  my $decoded = decode_json($json_text);
  my @domains = @{$decoded->{'data'}{'prefixes'}{'ipv4'}{$arg2}{'domains'}};
  foreach my $f (@domains) {
    if ($f->{"dnscheck"}{"status"} =~ /ok/i) {
      print "1\n";
    } else {
      print "0\n";
    }
  }
}




