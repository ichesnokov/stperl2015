#!/usr/bin/env perl
use v5.18;
use warnings;
use Coro;

my $COUNT       = 5e7;
my $MAX_THREADS = 10;
my @threads;
for my $i (1 .. $MAX_THREADS) {
    push @threads, async(
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
