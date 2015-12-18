#!/usr/bin/env perl
use common::sense;
use Coro;
use Coro::AnyEvent;

my $sem = Coro::Semaphore->new(5);
for my $i (1 .. 1000) {
    async {
        $sem->down;
        say "I am coro number $i";

        # Use non-blocking sleep
        Coro::AnyEvent::sleep 1;
        $sem->up;
    };
}
Coro::AnyEvent::sleep 2;
