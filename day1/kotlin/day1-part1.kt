import java.io.File
import kotlin.math.abs
import java.nio.file.Paths

fun main() {
    val file = File("../input.txt")
    val lines = file.readLines()

    val list1 = mutableListOf<String>()
    val list2 = mutableListOf<String>()

    for (line in lines) {
        val pair = line.split("   ")
        list1.add(pair[0])
        list2.add(pair[1])
    }

    list1.sort()
    list2.sort()

    var totalDistance = 0;
    for (i in list1.indices) {
        totalDistance += abs(list1[i].toInt() - list2[i].toInt())
    }

    println(totalDistance)
}