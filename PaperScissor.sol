// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract PaperScissor {
    event GameCreated(
        address indexed creator,
        uint indexed gameId,
        uint indexed amount
    );
    event GameStarted(
        address indexed creator,
        address indexed participants,
        uint gameId
    );
    event GameComplete(address indexed winner, uint indexed id);
    // uint gameId=1;
    // address public creator;

    enum Move {
        None,
        Rock,
        Paper,
        Scissors
    }

    // Struct for the game details
    struct Game {
        address creator;
        address participant;
        uint256 bet;
        Move creatorMove;
        Move participantMove;
        bool isCompleted;
    }

    // Game storage
    uint256 public gameCounter;
    mapping(uint256 => Game) public games;
    // modifier onlyCreator{
    //     require(creator == msg.sender,"u are not creator");
    //     _;
    // }
    mapping(address => bool) public allowParticipants;

    // mapping(address=>mapping (uint=>uint)) public participantBetAmount;
    // uint betAmount =1 ether;

    function createGame(address _participant) public payable {
        require(msg.value > 0, "insufficient amount");
        require(_participant != address(0), "invalid address");
        allowParticipants[_participant] = true;
        //    participantBetAmount[_participant][_betAmount]=msg.value;
        gameCounter++;
        games[gameCounter] = Game(
            msg.sender,
            _participant,
            msg.value,
            Move.None,
            Move.None,
            false
        );
        emit GameCreated(msg.sender, gameCounter, msg.value);
        gameCounter++;
    }

    function joinGame(uint gameId) public payable {
        require(allowParticipants[msg.sender] = true, "u r not allowed");
        Game storage game = games[gameId];
        require(game.creator != address(0), "invalid creator");
        require(!game.isCompleted, "game already completed");
        require(msg.sender == game.participant, "u r not allowed");
        require(msg.value >= game.bet, "Insufficient bet amount");

        uint remainingAmount = (msg.value) - game.bet;
        if (msg.value > game.bet) {
            payable(msg.sender).transfer(remainingAmount);
        }

        emit GameStarted(game.creator, msg.sender, gameId);
    }

    function makeMove(uint _gameId, uint _move) public {
        Game storage game = games[_gameId];
        require(game.creator != address(0), "invalid creator");
        require(!game.isCompleted, "game already completed");
        //cannot compare a uint256 (an unsigned integer) with an enum type directly using comparison operators
        //like <= , first converting them into an appropriate type.
        //Solidity does not allow direct comparison between enums and integers
        // because they are fundamentally different types
        require(
            _move >= uint(Move.Rock) && _move <= uint(Move.Scissors),
            "Invalid move"
        );
        if (msg.sender == game.creator) {
            require(
                game.creatorMove == Move.None,
                "Move already made by creator"
            );
            game.creatorMove = Move(_move);
        } else if (msg.sender == game.participant) {
            require(
                game.participantMove == Move.None,
                "Move already made by participant"
            );
            game.participantMove = Move(_move);
        } else {
            revert("You are not a participant in this game");
        }

        // require(game.creatorMove != Move.None && game.participantMove != Move.None,"invalid move");
        address winner = address(0);

        // Determine winner based on moves
        if (game.creatorMove == game.participantMove) {
            // Tie
            payable(game.creator).transfer(game.bet);
            payable(game.participant).transfer(game.bet);
        } else if (
            (game.creatorMove == Move.Rock &&
                game.participantMove == Move.Scissors) ||
            (game.creatorMove == Move.Paper &&
                game.participantMove == Move.Rock) ||
            (game.creatorMove == Move.Scissors &&
                game.participantMove == Move.Paper)
        ) {
            // Creator wins
            winner = game.creator;
            payable(game.creator).transfer(2 * game.bet);
        } else {
            // Participant wins
            winner = game.participant;
            payable(game.participant).transfer(2 * game.bet);
        }

        game.isCompleted = true;

        emit GameComplete(winner, _gameId);
        // Check if both players have made their moves
        // if (game.creatorMove != Move.None && game.participantMove != Move.None) {
        //     resolveGame(_gameId);
        // }
    }

    //   function resolveGame(uint256 gameNumber) private {
    //     Game storage game = games[gameNumber];
    //     require(!game.isCompleted, "Game is already completed");

    //     game.isCompleted = true;

    //     address winner = address(0);

    //     // Determine winner based on moves
    //     if (game.creatorMove == game.participantMove) {
    //         // Tie
    //         payable(game.creator).transfer(game.bet);
    //         payable(game.participant).transfer(game.bet);
    //     } else if (
    //         (game.creatorMove == Move.Rock && game.participantMove == Move.Scissors) ||
    //         (game.creatorMove == Move.Paper && game.participantMove == Move.Rock) ||
    //         (game.creatorMove == Move.Scissors && game.participantMove == Move.Paper)
    //     ) {
    //         // Creator wins
    //         winner = game.creator;
    //         payable(game.creator).transfer(2 * game.bet);
    //     } else {
    //         // Participant wins
    //         winner = game.participant;
    //         payable(game.participant).transfer(2 * game.bet);
    //     }

    //     emit GameComplete(winner, gameNumber);
    // }
}
