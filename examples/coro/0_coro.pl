#!/usr/bin/env perl
use common::sense;
use Coro;
use Coro::AnyEvent;

my $var = 0;
async {

    say "Thread 1 start, var is: $var";
    $var++;
    say "Thread 1 leave, var is: $var";

    cede;

    say "Thread 1 continue, var is: $var";
    $var++;
    say "Thread 1 end, var is: $var";
};

async {

    say "Thread 2 start, var is: $var";
    $var++;
    say "Thread 2 leave, var is: $var";

    cede;

    say "Thread 2 continue, var is: $var";
    $var++;
    say "Thread 2 end, var is: $var";
};

Coro::AnyEvent::idle;
