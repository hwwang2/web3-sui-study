module game2::finger_guessing{
    use sui::event::emit;

    use sui::clock::{Self, Clock};

    const ERR_NOT_CORRECT_GESTURE: u64 = 2;

    const ROCK: u8 = 0;
    const PAPER: u8 = 1;
    const SCISSORS: u8 = 2;

    // result
    /// 0: tie, 1: player win, 2: computer win
    struct Result has copy, drop{
        status: u8
    }


    entry public fun play(guess: u8, clock: &Clock){
        if(guess > 2) abort ERR_NOT_CORRECT_GESTURE;

        let ts_ms = clock::timestamp_ms(clock);
        let comp_guess = (ts_ms % 3 as u8);

        // logic
        if(guess == comp_guess){
            emit(Result{status:0})
        }else{
            let player_win = if((guess == ROCK && comp_guess == SCISSORS) || (guess == SCISSORS && comp_guess == PAPER) || (guess == PAPER && comp_guess == ROCK)) true else false;

            if(player_win) emit(Result{status:1}) else emit(Result{status:2});
        };
    }
}