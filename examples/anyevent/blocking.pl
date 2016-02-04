use common::sense;
use AnyEvent;

# Нельзя делать так:
my $cv = AnyEvent->condvar;
my $cv2 = AnyEvent->condvar;

my $timer = AnyEvent->timer(after => 1, cb => sub {
    # Запуск еще одного цикла???
    $cv2->recv;
    say "hi";
});
$cv->recv;
