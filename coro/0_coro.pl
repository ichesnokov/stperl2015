#!/usr/bin/env perl
use common::sense;
use Coro;
use Coro::AnyEvent;

my $shared = 0;
async {

    say "Thread 1 start, shared is: $shared";
    $shared++;
    say "Thread 1 leave, shared is: $shared";

    cede;

    say "Thread 1 continue, shared is: $shared";
    $shared++;
    say "Thread 1 end, shared is: $shared";
};

async {

    say "Thread 2 start, shared is: $shared";
    $shared++;
    say "Thread 2 leave, shared is: $shared";

    cede;

    say "Thread 2 continue, shared is: $shared";
    $shared++;
    say "Thread 2 end, shared is: $shared";
};

Coro::AnyEvent::idle;
