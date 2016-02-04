#!/usr/bin/env perl
use common::sense;
use utf8::all;
use AnyEvent;

my $cv = AnyEvent->condvar;

# Set up I/O watcher
my $io_w = AnyEvent->io(
    fh   => *STDIN,
    poll => 'r',
    cb   => sub {
        chomp(my $typed = <STDIN>);
        say "Вы ввели: $typed";
        $cv->send('До свиданья!') if $typed eq 'exit';
    }
);

# Set up idle watcher
my $counter = 0;
my $idle_w = AnyEvent->idle(cb => sub {
    say "Я досчитал до $counter!" if ++$counter % 5e5 == 0;
});

# Set up timer watcher
my $timer_w = AnyEvent->timer(
    after    => 2,
    interval => 2,
    cb       => sub {
        say "Прошло еще 2 секунды";
    }
);

# Block until $cv receives something
say $cv->recv;
