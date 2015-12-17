#!/usr/bin/env perl
use common::sense;
use AnyEvent::HTTP qw(http_get);

my $cv = AnyEvent->condvar;
for my $i (1 .. 500) {
    $cv->begin;
    http_get "https://perljobs.ru",
        sub {
            my (undef, $h) = @_;
            say "Request $i completed, status: $h->{Status}";
            $cv->end;
        };
}
$cv->recv;
