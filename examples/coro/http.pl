#!/usr/bin/env perl
use common::sense;
use Coro qw(rouse_cb rouse_wait);
use Coro::AnyEvent;
use AnyEvent::HTTP qw(http_get);

for my $i (1 .. 10) {
    http_get 'https://perljobs.ru', rouse_cb;
    my (undef, $hdr) = rouse_wait;
    warn "Request $i completed, status=$hdr->{Status}";
}

Coro::AnyEvent::idle;
