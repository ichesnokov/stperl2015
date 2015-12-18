#!/usr/bin/env perl
use common::sense;
use Coro;
use Coro::AnyEvent;

my $var = 0;
async {
    say "Start thread 1, var is: $var";
    $var++;
    say "Leave thread 1, var is: $var";

    cede;

    say "Continue thread 1, var is: $var";
    $var++;
    say "End thread 1, var is: $var";
};

async {
    say "Start thread 2, var is: $var";
    $var++;
    say "Leave thread 2, var is: $var";

    cede;

    say "Continue thread 2, var is: $var";
    $var++;
    say "End thread 2, var is: $var";
};

Coro::AnyEvent::idle;
