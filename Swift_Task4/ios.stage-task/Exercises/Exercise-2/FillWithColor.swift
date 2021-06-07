import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        
        var arrayResult = image
        
        if image.count < 1   || image[0].count < 1  || image[0].count > 50
        || newColor >= 65536 || row < 0 || row > image.count-1 || column < 0 ||
        column > image[0].count-1 {
            return arrayResult
        }
        for i in 0..<image.count {
            for j in 0..<image[i].count {
                if image[i][j] < 0 { return arrayResult }
            }
        }
        
        let oldValue = image[row][column]

        fill(&arrayResult, row, column, newColor, oldValue)
        
        return arrayResult
    }
    
    func fill(_ array: inout [[Int]], _ i: Int, _ j: Int, _ newColor: Int, _ oldValue: Int) {
        if (i < 0 || j < 0 || i >= array.count || j >= array[i].count) { return }
        
        if array[i][j] == oldValue {
        array[i][j] = newColor
            fill(&array, i-1, j, newColor, oldValue)
            fill(&array, i+1, j, newColor, oldValue)
            fill(&array, i, j-1, newColor, oldValue)
            fill(&array, i, j+1, newColor, oldValue)
        }
    }

}
