#!/usr/bin/env perl
use common::sense;
use AE;

my $cv = AE::cv;
my $io_w = AE::io *STDIN, 0, sub {
    chomp(my $typed = <STDIN>);
    utf8::decode($typed);
    say "Вы ввели: $typed";
    $cv->send('Good-bye') if $typed eq 'exit';
};

my $counter = 0;
my $idle_w = AE::idle sub {
    say "Я досчитал до $counter!" if ++$counter % 5e6 == 0;
};

my $timer_w = AE::timer 5, 5, sub {
    say "Прошло еще 5 секунд";
};

say $cv->recv;
