#!/usr/bin/env perl
use common::sense;
use Coro;
use Coro::AnyEvent;

my $sig = Coro::Signal->new;
async {
    $sig->wait;
    say "First thread woke up!";
};

async {
    $sig->wait;
    say "Second thread woke up!";
};

async {
    say "Sleeping 1 second...";

    # Blocking sleep
    sleep 1;
    $sig->send;
};


Coro::AnyEvent::idle;
