// whenever we passes a struct to a function the ownership is moved to the function

#[cfg(test)]

mod tests {

    #[derive(Drop)]
    struct Person {
        height: u32,
        age: u32
    }

    fn get_age(person: Person) -> u32 {
        person.age
    }

    #[test]
    fn test_get_age() {
        let person = Person {
            height: 80,
            age: 23
        };

        assert!(person.age == 23_u32); // this is aam zindagi

        let age = get_age(person); // now we are passing person to the "get_age" function and storing the person.age in a variable called age
        assert!(age == 23_u32);
        // assert!(person.age == 23_32); // error: the variable is previously moved, Ownership concepts 😭
        // Ye hai mentos zindagi
        // since when we called "let age = get_age(person);" we moved the ownership of person to the function get_age()
    }

    // to solve the above issue, we can use "return ownership concept".
    fn get_age_return_ownership(person: Person) -> (u32, Person) {
        (person.age, person)
    }
    
    #[test]
    fn test_get_age_return_ownership(){
        let person = Person {
            height: 180,
            age: 21
        };

        let (age, person) = get_age_return_ownership(person);
        assert!(age == 21_u32);
        assert!(person.age == 21_u32); // now we can access the person since the ownership is returned 👌
    }


    // if we don't want to return ownership everytime, you only want to share the value not the ownership, we can use snapshots instead using "@". Then the function only access the snapshot not the ownership
    // to access the snapshot we need to use "*" in front of it
    fn get_age_with_snapshot(person: @Person) -> u32 {
        *person.age
    }

    #[test]
    fn test_get_age_with_snapshot() {
        let person = Person {
            height: 190,
            age: 22
        } ;

        //  the function get_age_with_snapshot doesn't accept the actual struct directly instead it wants the refrence of it so we need to add "@"
        let age = get_age_with_snapshot(@person);
        assert!(age == 22_u32);
        assert!(person.age == 22_u32); // we access the property directly, therefore ownership doesn't moved
    }

}