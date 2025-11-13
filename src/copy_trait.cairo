// 

#[cfg(test)]

mod tests {
    
    fn add_one(x: u32) -> u32 {
        x + 1
    }

    #[test]
    fn test_add_one() {
        let x:u32 = 3;
        let y:u32 = add_one(x); // the question is does this also takes the ownership
        assert!(x == 3_u32); // it doesn't complain like: the variable is moved... | The answer is: low level or build-in types like u32, they implement a trait called copy, which when you pass a value as an argument to a function instead of moving ownership it implements a "copy trait" that gonna create a copy and pass ownership over copy of the value not the ownership of the value itself
        assert!(y == 4_u32); 
    }   

    #[derive(Drop, Copy)]
    struct Person {
        height: u32,
        age: u32
    }

    fn get_age(person: Person) -> u32 {
        person.age
    }

    #[test]
    fn test_get_age(){
        let person = Person {
            height: 180,
            age: 21
        };

        let age: u32 = get_age(person);
        assert!(age == 21_u32);
        assert!(person.age == 21_u32); // Voilà! now we don't get the error. try removing "Copy" triat form the #[derive(Drop, Copy)]
    }





    // Copy trait with mutablity (mut)
    fn increase_age(mut person: Person) {
        person.age += 1;
    }

    #[test]
    fn test_increase_age() {
        let person = Person {
            height: 180,
            age: 21
        };
        increase_age(person);
        assert!(person.age == 21_u32); // still 21 because we are passing a copy of the person struct not the ownership itself
    }






}