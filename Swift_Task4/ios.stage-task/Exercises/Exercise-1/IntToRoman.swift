import Foundation

public extension Int {
    
    var roman: String? {
        return convert(value: self)
    }
    func convert(value: Int) -> String? {
           guard value > 0 && value < 4000 else {return nil}
           
           var str: String?
           
           let dictI = [1:"I",2:"II",3:"III",4:"IV",5:"V",6:"VI",7:"VII",8:"VIII",9:"IX"]
           let dictX = [1:"X",2:"XX",3:"XXX",4:"XL",5:"L",6:"LX",7:"LXX",8:"LXXX",9:"XC"]
           let dictC = [1:"C",2:"CC",3:"CCC",4:"CD",5:"D",6:"DC",7:"DCC",8:"DCCC",9:"CM"]
           let dictM = [1:"M",2:"MM",3:"MMM"]
           
           if value / 10 == 0 { str = dictI[value] }
           // ----------------------------------------------
           if value / 10 > 0 &&  value / 10 <= 9 {
               str = dictX[value/10]
               str! += dictI[value%10] ?? ""
           }
           // ----------------------------------------------
           if value / 100 > 0 && value / 100 <= 9 {
               str = dictC[value/100]
               let valueX = value % 100
               
               if valueX / 10 > 0 && valueX / 10 < 10 {
                   str! += dictX[valueX / 10]!
               }
                str! += dictI[valueX%10] ?? ""
           }
           
           // ----------------------------------------------
           
           if value / 1000 > 0 && value / 1000 < 4 {
               str = dictM[value / 1000]
               
               let valueC = value % 1000
               if valueC / 100 > 0 && valueC / 100 <= 9 {
                   str! += dictC[valueC/100]!
               }
               
               let valueX = valueC % 100
               if valueX / 10 > 0 && valueX / 10 < 10 {
                   str! += dictX[valueX/10]!
               }
               let valueI = valueX % 10
               if valueI  > 0 &&  valueI  <= 9 {
                   str! += dictI[valueI]!
               }
           }
        
        return str
    }
}
