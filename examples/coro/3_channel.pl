#!/usr/bin/env perl
use common::sense;
use Coro;

my $channel = Coro::Channel->new(2);
my $iter    = 0;
async {
    Coro::on_enter {
        say "Iteration: " . ++$iter;
    };
    for my $value (1 .. 10) {
        say "Put: $value";
        $channel->put($value);
    }
    say 'All items queued';
    $channel->shutdown;
};

while (my $value = $channel->get) {
    say "Got: $value";
}
say 'Done';
