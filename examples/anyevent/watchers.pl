#!/usr/bin/env perl
use common::sense;
use utf8::all;
use AE;

# Prepace condvar
my $cv = AE::cv;

# Set up I/O watcher
my $io_w = AE::io *STDIN, 0, sub {
    chomp(my $typed = <STDIN>);
    say "Вы ввели: $typed";
    $cv->send('Good-bye') if $typed eq 'exit';
};

my $counter = 0;

# Set up idle watcher
my $idle_w = AE::idle sub {
    say "Я досчитал до $counter!" if ++$counter % 5e6 == 0;
};

# Set up timer watcher
my $timer_w = AE::timer 5, 5, sub {
    say "Прошло еще 5 секунд";
};

# Block until $cv receives something
say $cv->recv;
