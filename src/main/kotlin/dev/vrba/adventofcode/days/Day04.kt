@file:Suppress("NAME_SHADOWING")

package dev.vrba.adventofcode.days


class Day04 {

    private val matrixSize = 5

    data class Board(private val rows: List<List<Int>>) {
        fun won(): Boolean = rows.any { it.isEmpty() }
        fun score(): Int = rows.flatten().toSet().sum()
        fun mark(number: Int): Board = copy(
            rows = rows.map { it - number }
        )
    }

    private fun parseBoard(input: List<String>): Board {
        val rows = input.map { it.trim().split("\\s+".toRegex()).map(String::toInt) }
        val columns = rows.indices.map { index -> rows.map { it[index] } }

        return Board(rows + columns)
    }

    private fun parseInput(input: List<String>): Pair<List<Int>, List<Board>> {
        val draws = input.first().split(",").map { it.toInt() }
        val boards = input.drop(1)
            .filter { it.isNotBlank() }
            .chunked(matrixSize) { parseBoard(it) }

        return Pair(draws, boards)
    }

    fun findWinnerBingoBoardScore(input: List<String>): Int {
        val (draws, boards) = parseInput(input)

        return draws.asSequence()
            .runningFold(boards to 0) { (boards, _), draw -> boards.map { it.mark(draw) } to draw  }
            .dropWhile { (boards, _) -> boards.none { it.won() }}
            .first()
            .let { (boards, draw) -> boards.first { it.won()}.score() * draw }
    }

    fun findLoserBingoBoardScore(input: List<String>): Int {
        val (draws, boards) = parseInput(input)

        return draws.asSequence()
            .runningFold(boards to 0) { (boards, _), draw -> boards.filterNot { it.won() }.map { it.mark(draw) } to draw  }
            .dropWhile { (boards, _) -> !boards.all { it.won() } }
            .first()
            .let { (board, draw) -> board.first().score() * draw }
    }

}