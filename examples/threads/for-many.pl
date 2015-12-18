#!/usr/bin/env perl
use common::sense;
use Coro;

my $COUNT       = 1e3;
my $MAX_THREADS = 5000;
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
