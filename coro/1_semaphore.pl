#!/usr/bin/env perl
use common::sense;
use Coro;
use Coro::AnyEvent;

my $sem = Coro::Semaphore->new(5);

my $iter = 0;
for my $i (1 .. 1000) {
    async {
        $sem->down;

        say "I am coro number $i";

        # Pretend we're doing something asynchronously using non-blocking sleep
        Coro::AnyEvent::sleep 1;

        $sem->up;
    };
}

Coro::AnyEvent::sleep 10;
