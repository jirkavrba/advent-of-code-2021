package dev.vrba.adventofcode.days

import dev.vrba.adventofcode.Resources.readResourceLines
import jdk.jfr.Name
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@Name("Day 4")
class Day04Tests {

    private val instance = Day04()

    @Test
    @DisplayName("Part 1 example")
    fun testTask1Example() {
        val input = """
        7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

        22 13 17 11  0
         8  2 23  4 24
        21  9 14 16  7
         6 10  3 18  5
         1 12 20 15 19

         3 15  0  2 22
         9 18 13 17  5
        19  8  7 25 23
        20 11 10 24  4
        14 21 16 12  6

        14 21 17 24  4
        10 16 15  9 19
        18  8 23 26 20
        22 11 13  6  5
         2  0 12  3  7   
        """.trimIndent()
           .lines()

        val result = instance.findWinnerBingoBoardScore(input)

        assertEquals(4512, result)
    }

    @Test
    @DisplayName("Part 1 input")
    fun testTask1Input() {
        val input = readResourceLines("day04.txt")
        val result = instance.findWinnerBingoBoardScore(input)

        assertEquals(14093, result)
    }

    @Test
    @DisplayName("Part 2 example")
    fun testTask2Example() {
        val input = """
        7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

        22 13 17 11  0
         8  2 23  4 24
        21  9 14 16  7
         6 10  3 18  5
         1 12 20 15 19

         3 15  0  2 22
         9 18 13 17  5
        19  8  7 25 23
        20 11 10 24  4
        14 21 16 12  6

        14 21 17 24  4
        10 16 15  9 19
        18  8 23 26 20
        22 11 13  6  5
         2  0 12  3  7   
        """.trimIndent()
            .lines()

        val result = instance.findLoserBingoBoardScore(input)

        assertEquals(1924, result)
    }

    @Test
    @DisplayName("Part 2 input")
    fun testTask2Input() {
        val input = readResourceLines("day04.txt")
        val result = instance.findLoserBingoBoardScore(input)

        assertEquals(17388, result)
    }
}