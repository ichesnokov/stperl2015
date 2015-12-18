#!/usr/bin/env perl
use common::sense;
use Coro;
use Coro::AnyEvent;

my $sig = Coro::Signal->new;
for my $name (qw(First Second)) {
    async {
        say "$name thread starts waiting...";
        $sig->wait;
        say "$name thread woke up!";
    };
}

async {
    say "Sleeping 1 second...";
    # Blocking sleep
    sleep 1;
    $sig->send;
};

Coro::AnyEvent::idle;
