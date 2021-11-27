package main

import "core:fmt"

main :: proc() {
    board := [9]string{" ", " ", " "," ", " ", " ", " ", " ", " "}
    p1_turn := true

    // Currently loops over all squares instead of accepting user input
    for i := 0; i < 10; i += 1 {
        if p1_turn {
            board[i] = "o"
        } else {
            board[i] = "x"
        }

        render_board(board)

        if game_over(board) {
            // Is there a shorter way to do this? Ternary?
            if p1_turn {
                fmt.printf("Player 1 wins")
            } else {
                fmt.printf("Player 2 wins")
            }
            break
        }

        p1_turn = !p1_turn
    }
}

render_board :: proc(board: [9]string) {
    fmt.printf("%s | %s | %s\n", board[0], board[1], board[2])
    fmt.printf("----------\n")
    fmt.printf("%s | %s | %s\n", board[3], board[4], board[5])
    fmt.printf("----------\n")
    fmt.printf("%s | %s | %s\n\n", board[6], board[7], board[8])
}

game_over :: proc(board: [9]string) -> bool {
    return check_horizontal(board) || check_vertical(board) || check_diagonal(board)
}

check_horizontal :: proc(board: [9]string) -> bool{
    return check(0, 1, 2, board) || check(3, 4, 5, board) || check(6, 7, 8, board)
}

check_vertical :: proc(board: [9]string) -> bool{
    return check(0, 3, 6, board) || check(1, 4, 7, board) || check(2, 5, 8, board)
}

check_diagonal :: proc(board: [9]string) -> bool{
    return check(0, 4, 8, board) || check(2, 4, 6, board)
}

check :: proc(a: int, b: int, c: int, board: [9]string) -> bool {
    return board[a] == board[b] && board[a] == board[c] && board[a] != " "
}