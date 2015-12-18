#!/usr/bin/env perl
use common::sense;
use Coro;
use Coro::AnyEvent;

my $sig = Coro::Signal->new;
async {
    say "First thread starts waiting...";
    $sig->wait;
    say "First thread woke up!";
};

async {
    say "Second thread starts waiting...";
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
