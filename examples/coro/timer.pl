#!/usr/bin/env perl
use common::sense;
use Coro;
use AnyEvent;

# Set up timer watcher
my $timer_w = AnyEvent->timer(
    after => 3,
    cb    => rouse_cb,
);

rouse_wait;
say "Timeout";

