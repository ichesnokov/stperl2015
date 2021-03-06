#!/usr/bin/env perl
use common::sense;
use threads;

my $COUNT       = 2.5e3;
my $MAX_THREADS = 5000;
my @threads;
for my $i (1 .. $MAX_THREADS) {
    push @threads, threads->create(
        sub {
            # some asynchronous thread of execution
            my $result = 0;
            for my $i (1 .. $COUNT) {
                $result += $i;
            }
            say "Thread $i result: $result";
        }
    );
}
$_->join for @threads;
say 'Done';
