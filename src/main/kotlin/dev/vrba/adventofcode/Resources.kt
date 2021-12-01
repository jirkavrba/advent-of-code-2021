package dev.vrba.adventofcode

import java.io.File
import java.net.URI

internal object Resources {

    fun readResource(fileName: String): String =
        File(fileName.toURI()).readText()

    fun readResourceLines(fileName: String): List<String> =
        File(fileName.toURI()).readLines()

    fun <T> readResourceLines(fileName: String, transform: (String) -> T): List<T> =
        readResourceLines(fileName).map(transform)

    private fun String.toURI(): URI =
        Resources.javaClass.classLoader.getResource(this)?.toURI() ?: throw IllegalArgumentException("Cannot find Resource: $this")
}