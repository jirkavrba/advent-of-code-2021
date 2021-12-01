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
        val input = listOf(199, 200, 208, 210, 200, 207, 240, 269, 260, 263)
        val result = instance.task1(input)

        assertEquals(7, result)
    }

    @Test
    @DisplayName("Part 1 input")
    fun testTask1Input() {
        val input = readResourceLines("day01.txt") { Integer.parseInt(it) }
        val result = instance.task1(input)

        assertEquals(1451, result)
    }

    @Test
    @DisplayName("Part 2 example")
    fun testTask2Example() {
        val input = listOf(199, 200, 208, 210, 200, 207, 240, 269, 260, 263)
        val result = instance.task2(input)

        assertEquals(5, result)
    }

    @Test
    @DisplayName("Part 2 input")
    fun testTask2Input() {
        val input = readResourceLines("day01.txt") { Integer.parseInt(it) }
        val result = instance.task2(input)

        assertEquals(1395, result)
    }
}