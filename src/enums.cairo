#[cfg(test)]
mod tests {

    mod simple_enum {

        #[derive(PartialEq, Drop)]
        enum Error {
            DividedByZero,
            DividnedSmallerThanDivisor,
            InexactDivision
        }

        fn divide(dividend: u32, divisor: u32) -> Result<u32, Error> {
            if dividend == 0 {
                return Result::Err(Error::DividedByZero);
            }
            if divisor > dividend {
                return Result::Err(Error::DividnedSmallerThanDivisor);
            }
            if dividend % divisor != 0 {
                return Err(Error::InexactDivision);
            }
            Ok(dividend/divisor)
        }

        #[test]
        fn test_simple_enum() {
            let result = divide(10, 2);
            assert!(result == Result::Ok(5))
        }     
        
    }   

    mod enums_with_values {
       
        // custom data types or struct need this #[derive(PartialEq, Drop)]
        #[derive(PartialEq, Drop)]
        struct Division {
          dividend: u32,
          divisor: u32
        }

        // build-in data types doesn't have to specify #[derive(PartialEq, Drop)]
        type Remainder = u32;

        #[derive(PartialEq, Drop)]
        enum Error { 
            DividedByZero,
            DividnedSmallerThanDivisor: Division,
            InexactDivision: Remainder,         
        }

        fn divide(dividend: u32, divisor: u32) -> Result<u32, Error> {
            if divisor == 0 {
                return Err(Error::DividedByZero);
            } 
            if divisor > dividend {
                let division = Division {
                    // dividend: dividend,
                    // divisor: divisor
                    // or you can use shorthand version like below
                    dividend,
                    divisor
                } ;
                return Err(Error::DividnedSmallerThanDivisor(division));
            }
            if dividend % divisor != 0 {
                let remainder: Remainder = dividend % divisor; 
                return Err(Error::InexactDivision(remainder));
            }
            return Ok(dividend/divisor);
        }

        #[test]
        fn test_enum_with_values() {
            let result = divide(10, 2);
            assert!(result == Ok(5));

            let result = divide(10, 0);
            assert!(result == Err(Error::DividedByZero));

            let result = divide(10, 3);
            let remainder: Remainder = 1; 
            assert!(result == Err(Error::InexactDivision(remainder)));

            let result = divide(4, 10);
            let division = Division {
                dividend: 4,
                divisor: 10,
            };

            assert!(result == Err(Error::DividnedSmallerThanDivisor(division)))
        }

    }


}