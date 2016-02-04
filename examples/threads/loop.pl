#!/usr/bin/env perl
use common::sense;

my $COUNT       = 2e7;
my $MAX_THREADS = 10;
my @threads;
for my $i (1 .. $MAX_THREADS) {
    push @threads, sub {
        my $result = 0;
        for my $i (1 .. $COUNT) {
            $result += $i;
        }
        say "Thread $i result: $result";
    };
}
$_->() for @threads;
say 'Done';
