package dev.vrba.adventofcode.days

import dev.vrba.adventofcode.Resources.readResourceLines
import jdk.jfr.Name
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@Name("Day 1")
class Day01Tests {

    private val instance = Day01()

    @Test
    @DisplayName("Part 1 example")
    fun testTask1Example() {
        val input = """
            199
            200
            208
            210
            200
            207
            240
            269
            260
            263
        """.trimIndent()
           .lines()

        assertEquals(7, instance.task1(input))
    }

    @Test
    @DisplayName("Part 1 input")
    fun testTask1Input() {
        val input = readResourceLines("day01.txt")

        assertEquals(1451, instance.task1(input))
    }

    @Test
    @DisplayName("Part 2 example")
    fun testTask2Example() {
        val input = """
            199
            200
            208
            210
            200
            207
            240
            269
            260
            263
        """.trimIndent()
            .lines()

        assertEquals(5, instance.task2(input))
    }

    @Test
    @DisplayName("Part 2 input")
    fun testTask2Input() {
        val input = readResourceLines("day01.txt")

        assertEquals(1395, instance.task2(input))
    }
}