#[cfg(test)]

mod tests {

    mod traits {

        // Properties: we use "struct"
        // Behaviour: we use "trait" (signature/defination of things, not the actual implementation)

        #[derive(Drop)]
        struct Human {
            health: u32,
            strength: u32,
            intelligence: u32
        }

        trait HumanAction {
            fn new() -> Human;
            fn train(ref self: Human); // we are modifying the "struct" this is gonna a "ref", we use self in triat's method arguments especially if you modify the actual element
            fn study(ref self: Human);
        }

        // define actual behaviour behind the above three methods
        impl HumanActionImpl of HumanAction {
            fn new() -> Human {
                // when this is called it will return a new below struct 
                Human {
                    health: 100,
                    strength: 20,
                    intelligence: 20
                }
            }

            fn train(ref self: Human){
                self.strength += 5;
            }

            fn study(ref self: Human) {
                self.intelligence += 5;
            }
        }

        #[derive(Drop)]
        struct Alien {
            health: u32,
            strength: u32,
            intelligence: u32
        }

        trait AlienAction {
            fn new() -> Alien;
            fn train(ref self: Alien);
            fn study(ref self: Alien);
        }

        impl AlienActionImpl of AlienAction {
            fn new() -> Alien{
                Alien {
                    health: 100,
                    strength: 40,
                    intelligence: 10
                }
            }

            fn train(ref self: Alien) {
                self.strength += 10;
            }

            fn study(ref self: Alien) {
                self.intelligence += 1;
            }
            
        }

        #[test]
        fn test_create_characters() {

            // This will create a new struct which is defined in the trait's method
            let mut human: Human = HumanActionImpl::new();
            let mut alien: Alien = AlienActionImpl::new();

            human.study(); // we need to make the above variable "human" mutable with "mut" which is a rule for refrences
            alien.study();

            assert!(human.intelligence == 25_u32);
            assert!(alien.intelligence == 11_u32);
        }
    }

// with generics instead of creating seperate trait for each struct we can create a single generic trait
    mod generics {

        #[derive(Drop)]
        struct Human {
            health: u32,
            strength: u32,
            intelligence: u32,
        }

        #[derive(Drop)]
        struct Alien {
            health: u32,
            strength: u32,
            intelligence: u32
        }

        // instead of creating seperate trait for each struct we can create a single generic trait
        trait Action<T> {
            fn new() -> T;
            fn study(ref self: T);
            fn train(ref self: T);
        }

        impl HumanImpl of Action<Human> {
            fn new() -> Human {
                Human {
                    health: 100,
                    intelligence: 50,
                    strength: 30
                }
            }

            fn study(ref self: Human) {
                self.intelligence += 10;
            }

            fn train(ref self: Human) {
                self.strength += 5;
            }
        }

        impl AlienImpl of Action<Alien> {
            fn new() -> Alien {
                Alien {
                    health: 100,
                    intelligence: 23,
                    strength: 45
                }
            }

            fn study(ref self: Alien) {
                self.intelligence += 2;
            }

            fn train(ref self: Alien) {
                self.strength += 10;
            }
        }

        #[test]
        fn test_create_characters(){
            let mut new_human: Human = HumanImpl::new();
            let mut new_alien: Alien = AlienImpl::new();

            new_human.study();
            new_alien.study();

            assert!(new_human.intelligence == 60_u32);
            assert!(new_alien.intelligence == 25_u32);
        }

    }
}