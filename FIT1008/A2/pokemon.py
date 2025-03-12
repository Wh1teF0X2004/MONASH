"""
This module create Pokemon of specific type and inherit attributes and methods from PokemonBase class.
All functions, unless stated otherwise, have a constant best / worst case complexity of O(1).
"""

__author__ = "Scaffold by Jackson Goerner, Code by Chew Xin Ning, Foo Kai Yan, Gan Kai Xin and Alicia Chik Wen Quek"

# Import libraries
from pokemon_base import PokemonBase


class Charmander(PokemonBase):
    """  To create a Charmander Pokemon.

    Attributes:
        poke_name(str) = Pokemon's name
        base_lvl(int) = Pokemon's base level
        max_hp(int) = maximum hit points of the Pokemon
        current_hp(int) = Pokemon's current hit points
        poke_type(str) = type of Pokemon
        level(int) = Pokemon's level
        speed(int) = Pokemon's speed
        defence(int) = Pokemon's defence
        attack_damage(int) = Pokemon's attack damage
        status_effect(str) = Pokemon's unique status effects they can inflict when battling
        status_effect_obtained(str) = status effect obtained from the opponent

    Getters:
        get_speed = return Pokemon's speed
        get_attack_damage = return Pokemon's attack damage
        get_defence = return Pokemon's defence
        get_hp = return Pokemon's current health/hit points
        get_evolved_version = evolve Pokemon to another class and return evolved Pokemon

    Methods:
        update_hp = Update Pokemon class if the Pokemon evolves and return evolved Pokemon

    """

    poke_name = "Charmander"

    def __init__(self) -> None:
        """ Initialisation of Charmander created.

            :pre1: hp must be an integer type
            :pre2: poke_type must be one of the available type
            :complexity: occur in precondition for poke_type in PokemonBase,
                         Best O(Comp==) if target poke_type is at index 0 of the checklist,
                         worst O(Comp== * N), when target poke_type is not in the checklist,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in the list
        """

        self.poke_type = "Fire"
        self.base_lvl = 1
        self.max_hp = 8 + 1 * self.base_lvl
        self.current_hp = self.max_hp
        PokemonBase.__init__(self, self.max_hp, self.poke_type)
        self.level = 1
        self.attack_damage = 6 + 1 * self.level
        self.speed = 7 + 1 * self.level
        self.defence = 4
        self.status_effect = "Burn"
        self.status_effect_obtained = None

    def get_speed(self) -> int:
        """ Get Pokemon's speed """
        self.speed = 7 + 1 * self.level
        return self.speed

    def get_attack_damage(self) -> int:
        """ Get Pokemon's attack damage """
        self.attack_damage = 6 + 1 * self.level
        return self.attack_damage

    def get_defence(self) -> int:
        """ Get Pokemon's defence """
        return self.defence

    def get_hp(self) -> int:
        """ Get Pokemon's health/hit points """
        self.update_hp()
        return self.current_hp

    def update_hp(self) -> None:
        """ Update hp according to Pokemonon's level if it is levelled up """
        if self.level > self.base_lvl: # means it has updated its level
            self.current_hp = 8 + 1 * self.level

    def get_evolved_version(self) -> PokemonBase:
        """ Update Pokemon class if the Pokemon evolves and return evolved Pokemon """

        evolved_version = Charizard()

        # change the current HP so that the difference between maximum and current HP is kept the same
        if self.get_hp() != self.initial_hp:
            evolved_version.hp = self.max_hp - (self.get_hp() - self.initial_hp)

        return evolved_version


class Squirtle(PokemonBase):
    """  To create a Squirtle Pokemon.

    Attributes:
        poke_name(str) = Pokemon's name
        base_lvl(int) = Pokemon's base level
        max_hp(int) = maximum hit points of the Pokemon
        current_hp(int) = Pokemon's current hit points
        poke_type(str) = type of Pokemon
        level(int) = Pokemon's level
        speed(int) = Pokemon's speed
        defence(int) = Pokemon's defence
        attack_damage(int) = Pokemon's attack damage
        status_effect(str) = Pokemon's unique status effects they can inflict when battling
        status_effect_obtained(str) = status effect obtained from the opponent

    Getters:
        get_speed = return Pokemon's speed
        get_attack_damage = return Pokemon's attack damage
        get_defence = return Pokemon's defence
        get_hp = return Pokemon's current health/hit points
        get_evolved_version = evolve Pokemon to another class and return evolved Pokemon

    Methods:
        update_hp = Update Pokemon class if the Pokemon evolves and return evolved Pokemon

    """

    poke_name = "Squirtle"

    def __init__(self) -> None:
        """ Initialisation of Squirtle created.

            :pre1: hp must be an integer type
            :pre2: poke_type must be one of the available type
            :complexity: occur in precondition for poke_type in PokemonBase,
                         Best O(Comp==) if target poke_type is at index 0 of the checklist,
                         worst O(Comp== * N), when target poke_type is not in the checklist,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in the list
        """

        self.poke_type = "Water"
        self.base_lvl = 1
        self.max_hp = 9 + 2 * self.base_lvl
        self.current_hp = self.max_hp
        PokemonBase.__init__(self, self.max_hp, self.poke_type)
        self.level = 1
        self.attack_damage = 4 + (self.level // 2)
        self.speed = 7
        self.defence = 6 + self.level
        self.status_effect = "Paralysis"
        self.status_effect_obtained = None

    def get_speed(self) -> int:
        """ Get Pokemon's speed """
        return self.speed

    def get_attack_damage(self) -> int:
        """ Get Pokemon's attack damage """
        self.attack_damage = 4 + (self.level // 2)
        return self.attack_damage

    def get_defence(self) -> int:
        """ Get Pokemon's defence """
        self.defence = 6 + self.level
        return self.defence

    def get_hp(self) -> int:
        """ Get Pokemon's health/hit points """
        self.update_hp()
        return self.current_hp

    def update_hp(self) -> None:
        """ Update hp according to Pokemono's level if it is levelled up """
        if self.level > self.base_lvl: # means it has updated its level
            self.current_hp = 9 + 2 * self.level

    def get_evolved_version(self) -> PokemonBase:
        """ Change Pokemon class if the Pokemon evolves and return evolved Pokemon """

        evolved_version = Blastoise()

        # change the current HP so that the difference between maximum and current HP is kept the same
        if self.get_hp() != self.initial_hp:
            evolved_version.hp = self.max_hp - (self.get_hp() - self.initial_hp)

        return evolved_version


class Bulbasaur(PokemonBase):
    """  To create a Bulbasaur Pokemon.

    Attributes:
        poke_name(str) = Pokemon's name
        base_lvl(int) = Pokemon's base level
        max_hp(int) = maximum hit points of the Pokemon
        current_hp(int) = Pokemon's current hit points
        poke_type(str) = type of Pokemon
        level(int) = Pokemon's level
        speed(int) = Pokemon's speed
        defence(int) = Pokemon's defence
        attack_damage(int) = Pokemon's attack damage
        status_effect(str) = Pokemon's unique status effects they can inflict when battling
        status_effect_obtained(str) = status effect obtained from the opponent

    Getters:
        get_speed = return Pokemon's speed
        get_attack_damage = return Pokemon's attack damage
        get_defence = return Pokemon's defence
        get_hp = return Pokemon's current health/hit points
        get_evolved_version = evolve Pokemon to another class and return evolved Pokemon

    Methods:
        update_hp = Update Pokemon class if the Pokemon evolves and return evolved Pokemon

    """

    poke_name = "Bulbasaur"

    def __init__(self) -> None:
        """ Initialisation of Bulbasaur created.

            :pre1: hp must be an integer type
            :pre2: poke_type must be one of the available type
            :complexity: occur in precondition for poke_type in PokemonBase,
                         Best O(Comp==) if target poke_type is at index 0 of the checklist,
                         worst O(Comp== * N), when target poke_type is not in the checklist,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in the list
        """

        self.poke_type = "Grass"
        self.base_lvl = 1
        self.max_hp = 12 + 1 * self.base_lvl
        self.current_hp = self.max_hp
        PokemonBase.__init__(self, self.max_hp, self.poke_type)
        self.level = 1
        self.attack_damage = 5
        self.speed = 7 + (self.level // 2)
        self.defence = 5
        self.status_effect = "Poison"
        self.status_effect_obtained = None

    def get_speed(self) -> int:
        """ Get Pokemon's speed """
        self.speed = 7 + (self.level // 2)
        return self.speed

    def get_attack_damage(self) -> int:
        """ Get Pokemon's attack damage """
        return self.attack_damage

    def get_defence(self) -> int:
        """ Get Pokemon's defence """
        return self.defence

    def get_hp(self) -> int:
        """ Get Pokemon's health/hit points """
        self.update_hp()
        return self.current_hp

    def update_hp(self) -> None:
        """ Update hp according to Pokemon's level if it is levelled up """
        if self.level > self.base_lvl: # means it has updated its level
            self.current_hp = 12 + 1 * self.level

    def get_evolved_version(self) -> PokemonBase:
        """ Change Pokemon class if the Pokemon evolves and return evolved Pokemon """

        evolved_version = Venusaur()

        # change the current HP so that the difference between maximum and current HP is kept the same
        if self.get_hp() != self.initial_hp:
            evolved_version.hp = self.max_hp - (self.get_hp() - self.initial_hp)

        return evolved_version


class Gastly(PokemonBase):
    """  To create a Gastly Pokemon.

    Attributes:
        poke_name(str) = Pokemon's name
        base_lvl(int) = Pokemon's base level
        max_hp(int) = maximum hit points of the Pokemon
        current_hp(int) = Pokemon's current hit points
        poke_type(str) = type of Pokemon
        level(int) = Pokemon's level
        speed(int) = Pokemon's speed
        defence(int) = Pokemon's defence
        attack_damage(int) = Pokemon's attack damage
        status_effect(str) = Pokemon's unique status effects they can inflict when battling
        status_effect_obtained(str) = status effect obtained from the opponent

    Getters:
        get_speed = return Pokemon's speed
        get_attack_damage = return Pokemon's attack damage
        get_defence = return Pokemon's defence
        get_hp = return Pokemon's current health/hit points
        get_evolved_version = evolve Pokemon to another class and return evolved Pokemon

    Methods:
        update_hp = Update Pokemon class if the Pokemon evolves and return evolved Pokemon

    """

    poke_name = "Gastly"

    def __init__(self) -> None:
        """ Initialisation of Gastly created.

            :pre1: hp must be an integer type
            :pre2: poke_type must be one of the available type
            :complexity: occur in precondition for poke_type in PokemonBase,
                         Best O(Comp==) if target poke_type is at index 0 of the checklist,
                         worst O(Comp== * N), when target poke_type is not in the checklist,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in the list
        """

        self.poke_type = "Ghost"
        self.base_lvl = 1
        self.max_hp = 6 + self.base_lvl // 2
        self.current_hp = self.max_hp
        PokemonBase.__init__(self, self.max_hp, self.poke_type)
        self.level = 1
        self.attack_damage = 4
        self.speed = 2
        self.defence = 8
        self.status_effect = "Sleep"
        self.status_effect_obtained = None

    def get_speed(self) -> int:
        """ Get Pokemon's speed """
        return self.speed

    def get_attack_damage(self) -> int:
        """ Get Pokemon's attack damage """
        return self.attack_damage

    def get_defence(self) -> int:
        """ Get Pokemon's defence """
        return self.defence

    def get_hp(self) -> int:
        """ Get Pokemon's health/hit points """
        self.update_hp()
        return self.current_hp

    def update_hp(self) -> None:
        """ Update hp according to Pokemon's level if it is levelled up """
        if self.level > self.base_lvl: # means it has updated its level
            self.current_hp = 6 + self.level // 2

    def get_evolved_version(self) -> PokemonBase:
        """ Change Pokemon class if the Pokemon evolves and return evolved Pokemon """

        evolved_version = Haunter()

        # change the current HP so that the difference between maximum and current HP is kept the same
        if self.get_hp() != self.initial_hp:
            evolved_version.hp = self.max_hp - (self.get_hp() - self.initial_hp)

        return evolved_version


class Eevee(PokemonBase):
    """  To create a Eevee Pokemon.

    Attributes:
        poke_name(str) = Pokemon's name
        base_lvl(int) = Pokemon's base level
        max_hp(int) = maximum hit points of the Pokemon
        current_hp(int) = Pokemon's current hit points
        poke_type(str) = type of Pokemon
        level(int) = Pokemon's level
        speed(int) = Pokemon's speed
        defence(int) = Pokemon's defence
        attack_damage(int) = Pokemon's attack damage
        status_effect(str) = Pokemon's unique status effects they can inflict when battling
        status_effect_obtained(str) = status effect obtained from the opponent

    Getters:
        get_speed = return Pokemon's speed
        get_attack_damage = return Pokemon's attack damage
        get_defence = return Pokemon's defence
        get_hp = return Pokemon's current health/hit points

    """

    poke_name = "Eevee"

    def __init__(self) -> None:
        """ Initialisation of Eevee created.

            :pre1: hp must be an integer type
            :pre2: poke_type must be one of the available type
            :complexity: occur in precondition for poke_type in PokemonBase,
                         Best O(Comp==) if target poke_type is at index 0 of the checklist,
                         worst O(Comp== * N), when target poke_type is not in the checklist,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in the list
        """

        self.poke_type = "Normal"
        self.base_lvl = 1
        self.max_hp = 10
        self.current_hp = self.max_hp
        PokemonBase.__init__(self, self.max_hp, self.poke_type)
        self.level = 1
        self.attack_damage = 6 + self.base_lvl
        self.speed = 7 + self.base_lvl
        self.defence = 4 + self.base_lvl
        self.status_effect = "Confusion"
        self.status_effect_obtained = None

    def get_speed(self) -> int:
        """ Get Pokemon's speed """
        self.speed = 7 + self.level
        return self.speed

    def get_attack_damage(self) -> int:
        """ Get Pokemon's attack damage """
        self.attack_damage = 6 + self.level
        return self.attack_damage

    def get_defence(self) -> int:
        """ Get Pokemon's defence """
        self.defence = 4 + self.level
        return self.defence

    def get_hp(self) -> int:
        """ Get Pokemon's health/hit points """
        return self.current_hp


class Charizard(PokemonBase):
    """  To create a Charizard Pokemon.

    Attributes:
        poke_name(str) = Pokemon's name
        base_lvl(int) = Pokemon's base level
        max_hp(int) = maximum hit points of the Pokemon
        current_hp(int) = Pokemon's current hit points
        poke_type(str) = type of Pokemon
        level(int) = Pokemon's level
        speed(int) = Pokemon's speed
        defence(int) = Pokemon's defence
        attack_damage(int) = Pokemon's attack damage
        status_effect(str) = Pokemon's unique status effects they can inflict when battling
        status_effect_obtained(str) = status effect obtained from the opponent

    Getters:
        get_speed = return Pokemon's speed
        get_attack_damage = return Pokemon's attack damage
        get_defence = return Pokemon's defence
        get_hp = return Pokemon's current health/hit points

    Methods:
        update_hp = Update Pokemon class if the Pokemon evolves and return evolved Pokemon

    """

    poke_name = "Charizard"

    def __init__(self) -> None:
        """ Initialisation of Charizard created.

            :pre1: hp must be an integer type
            :pre2: poke_type must be one of the available type
            :complexity: occur in precondition for poke_type in PokemonBase,
                         Best O(Comp==) if target poke_type is at index 0 of the checklist,
                         worst O(Comp== * N), when target poke_type is not in the checklist,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in the list
        """

        self.poke_type = "Fire"
        self.base_lvl = 3
        self.max_hp = 12 + 1 * self.base_lvl
        self.current_hp = self.max_hp
        PokemonBase.__init__(self, self.max_hp, self.poke_type)
        self.level = 3
        self.attack_damage = 10 + 2 * self.level
        self.speed = 9 + 1 * self.level
        self.defence = 4
        self.status_effect = "Burn"
        self.status_effect_obtained = None

    def get_speed(self) -> int:
        """ Get Pokemon's speed """
        self.speed = 9 + 1 * self.level
        return self.speed

    def get_attack_damage(self) -> int:
        """ Get Pokemon's attack damage """
        self.attack_damage = 10 + 2 * self.level
        return self.attack_damage

    def get_defence(self) -> int:
        """ Get Pokemon's defence """
        return self.defence

    def get_hp(self) -> int:
        """ Get Pokemon's health/hit points """
        self.update_hp()
        return self.current_hp

    def update_hp(self) -> None:
        """ Update hp according to Pokemonon's level if it is levelled up """
        if self.level > self.base_lvl: # means it has updated its level
            self.current_hp = 12 + 1 * self.level


class Blastoise(PokemonBase):
    """  To create a Blastoise Pokemon.

    Attributes:
        poke_name(str) = Pokemon's name
        base_lvl(int) = Pokemon's base level
        max_hp(int) = maximum hit points of the Pokemon
        current_hp(int) = Pokemon's current hit points
        poke_type(str) = type of Pokemon
        level(int) = Pokemon's level
        speed(int) = Pokemon's speed
        defence(int) = Pokemon's defence
        attack_damage(int) = Pokemon's attack damage
        status_effect(str) = Pokemon's unique status effects they can inflict when battling
        status_effect_obtained(str) = status effect obtained from the opponent

    Getters:
        get_speed = return Pokemon's speed
        get_attack_damage = return Pokemon's attack damage
        get_defence = return Pokemon's defence
        get_hp = return Pokemon's current health/hit points

    Methods:
        update_hp = Update Pokemon class if the Pokemon evolves and return evolved Pokemon

    """

    poke_name = "Blastoise"

    def __init__(self) -> None:
        """ Initialisation of Blastoise created.

            :pre1: hp must be an integer type
            :pre2: poke_type must be one of the available type
            :complexity: occur in precondition for poke_type in PokemonBase,
                         Best O(Comp==) if target poke_type is at index 0 of the checklist,
                         worst O(Comp== * N), when target poke_type is not in the checklist,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in the list
        """

        self.poke_type = "Water"
        self.base_lvl = 3
        self.max_hp = 15 + (2 * self.base_lvl)
        self.current_hp = self.max_hp
        PokemonBase.__init__(self, self.max_hp, self.poke_type)
        self.level = 3
        self.attack_damage = 8 + (self.level // 2)
        self.speed = 10
        self.defence = 8 + (1 * self.level)
        self.status_effect = "Paralysis"
        self.status_effect_obtained = None

    def get_speed(self) -> int:
        """ Get Pokemon's speed """
        return self.speed

    def get_attack_damage(self) -> int:
        """ Get Pokemon's attack damage """
        self.attack_damage = 8 + (self.level // 2)
        return self.attack_damage

    def get_defence(self) -> int:
        """ Get Pokemon's defence """
        self.defence = 8 + (1 * self.level)
        return self.defence

    def get_hp(self) -> int:
        """ Get Pokemon's health/hit points """
        self.update_hp()
        return self.current_hp

    def update_hp(self) -> None:
        """ Update hp according to Pokemonon's level if it is levelled up """
        if self.level > self.base_lvl: # means it has updated its level
            self.current_hp = 15 + 2 * self.level


class Venusaur(PokemonBase):
    """  To create a Venusaur Pokemon.

    Attributes:
        poke_name(str) = Pokemon's name
        base_lvl(int) = Pokemon's base level
        max_hp(int) = maximum hit points of the Pokemon
        current_hp(int) = Pokemon's current hit points
        poke_type(str) = type of Pokemon
        level(int) = Pokemon's level
        speed(int) = Pokemon's speed
        defence(int) = Pokemon's defence
        attack_damage(int) = Pokemon's attack damage
        status_effect(str) = Pokemon's unique status effects they can inflict when battling
        status_effect_obtained(str) = status effect obtained from the opponent

    Getters:
        get_speed = return Pokemon's speed
        get_attack_damage = return Pokemon's attack damage
        get_defence = return Pokemon's defence
        get_hp = return Pokemon's current health/hit points

    Methods:
        update_hp = Update Pokemon class if the Pokemon evolves and return evolved Pokemon

    """

    poke_name = "Venusaur"

    def __init__(self) -> None:
        """ Initialisation of Venusaur created.

            :pre1: hp must be an integer type
            :pre2: poke_type must be one of the available type
            :complexity: occur in precondition for poke_type in PokemonBase,
                         Best O(Comp==) if target poke_type is at index 0 of the checklist,
                         worst O(Comp== * N), when target poke_type is not in the checklist,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in the list
        """

        self.poke_type = "Grass"
        self.base_lvl = 2
        self.max_hp = 20 + (self.base_lvl//2)
        self.current_hp = self.max_hp
        PokemonBase.__init__(self, self.max_hp, self.poke_type)
        self.level = 2
        self.attack_damage = 5
        self.speed = 3 + (self.level // 2)
        self.defence = 10
        self.status_effect = "Poison"
        self.status_effect_obtained = None

    def get_speed(self) -> int:
        """ Get Pokemon's speed """
        self.speed = 3 + (self.level // 2)
        return self.speed

    def get_attack_damage(self) -> int:
        """ Get Pokemon's attack damage """
        return self.attack_damage

    def get_defence(self) -> int:
        """ Get Pokemon's defence """
        return self.defence

    def get_hp(self) -> int:
        """ Get Pokemon's health/hit points """
        self.update_hp()
        return self.current_hp

    def update_hp(self) -> None:
        """ Update hp according to Pokemonon's level if it is levelled up """
        if self.level > self.base_lvl: # means it has updated its level
            self.current_hp = 20 + (self.level // 2)


class Haunter(PokemonBase):
    """  To create a Haunter Pokemon.

    Attributes:
        poke_name(str) = Pokemon's name
        base_lvl(int) = Pokemon's base level
        max_hp(int) = maximum hit points of the Pokemon
        current_hp(int) = Pokemon's current hit points
        poke_type(str) = type of Pokemon
        level(int) = Pokemon's level
        speed(int) = Pokemon's speed
        defence(int) = Pokemon's defence
        attack_damage(int) = Pokemon's attack damage
        status_effect(str) = Pokemon's unique status effects they can inflict when battling
        status_effect_obtained(str) = status effect obtained from the opponent

    Getters:
        get_speed = return Pokemon's speed
        get_attack_damage = return Pokemon's attack damage
        get_defence = return Pokemon's defence
        get_hp = return Pokemon's current health/hit points
        get_evolved_version = evolve Pokemon to another class and return evolved Pokemon

    Methods:
        update_hp = Update Pokemon class if the Pokemon evolves and return evolved Pokemon

    """

    poke_name = "Haunter"

    def __init__(self) -> None:
        """ Initialisation of Haunter created.

            :pre1: hp must be an integer type
            :pre2: poke_type must be one of the available type
            :complexity: occur in precondition for poke_type in PokemonBase,
                         Best O(Comp==) if target poke_type is at index 0 of the checklist,
                         worst O(Comp== * N), when target poke_type is not in the checklist,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in the list
        """

        self.poke_type = "Ghost"
        self.base_lvl = 1
        self.max_hp = 9 + (self.base_lvl // 2)
        self.current_hp = self.max_hp
        PokemonBase.__init__(self, self.max_hp, self.poke_type)
        self.level = 1
        self.attack_damage = 8
        self.speed = 6
        self.defence = 6
        self.status_effect = "Sleep"
        self.status_effect_obtained = None

    def get_speed(self) -> int:
        """ Get Pokemon's speed """
        return self.speed

    def get_attack_damage(self) -> int:
        """ Get Pokemon's attack damage """
        return self.attack_damage

    def get_defence(self) -> int:
        """ Get Pokemon's defence """
        return self.defence

    def get_hp(self) -> int:
        """ Get Pokemon's health/hit points """
        self.update_hp()
        return self.current_hp

    def update_hp(self) -> None:
        """ Update hp according to Pokemonon's level if it is levelled up """
        if self.level > self.base_lvl: # means it has updated its level
            self.current_hp = 9 + self.level // 2

    def get_evolved_version(self) -> PokemonBase:
        """ Change Pokemon class if the Pokemon evolves and return evolved Pokemon """

        evolved_version = Gengar()

        # change the current HP so that the difference between maximum and current HP is kept the same
        if self.get_hp() != self.initial_hp:
            evolved_version.hp = self.max_hp - (self.get_hp() - self.initial_hp)

        return evolved_version


class Gengar(PokemonBase):
    """  To create a Gengar Pokemon.

    Attributes:
        poke_name(str) = Pokemon's name
        base_lvl(int) = Pokemon's base level
        max_hp(int) = maximum hit points of the Pokemon
        current_hp(int) = Pokemon's current hit points
        poke_type(str) = type of Pokemon
        level(int) = Pokemon's level
        speed(int) = Pokemon's speed
        defence(int) = Pokemon's defence
        attack_damage(int) = Pokemon's attack damage
        status_effect(str) = Pokemon's unique status effects they can inflict when battling
        status_effect_obtained(str) = status effect obtained from the opponent

    Getters:
        get_speed = return Pokemon's speed
        get_attack_damage = return Pokemon's attack damage
        get_defence = return Pokemon's defence
        get_hp = return Pokemon's current health/hit points

    Methods:
        update_hp = Update Pokemon class if the Pokemon evolves and return evolved Pokemon

    """

    poke_name = "Gengar"

    def __init__(self) -> None:
        """ Initialisation of Gengar created.

            :pre1: hp must be an integer type
            :pre2: poke_type must be one of the available type
            :complexity: occur in precondition for poke_type in PokemonBase,
                         Best O(Comp==) if target poke_type is at index 0 of the checklist,
                         worst O(Comp== * N), when target poke_type is not in the checklist,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in the list
        """

        self.poke_type = "Ghost"
        self.base_lvl = 3
        self.max_hp = 12 + (self.base_lvl // 2)
        self.current_hp = self.max_hp
        PokemonBase.__init__(self, self.max_hp, self.poke_type)
        self.level = 3
        self.attack_damage = 18
        self.speed = 12
        self.defence = 3
        self.status_effect = "Sleep"
        self.status_effect_obtained = None

    def get_speed(self) -> int:
        """ Get Pokemon's speed """
        return self.speed

    def get_attack_damage(self) -> int:
        """ Get Pokemon's attack damage """
        return self.attack_damage

    def get_defence(self) -> int:
        """ Get Pokemon's defence """
        return self.defence

    def get_hp(self) -> int:
        """ Get Pokemon's health/hit points """
        self.update_hp()
        return self.current_hp

    def update_hp(self) -> None:
        """ Update hp according to Pokemonon's level if it is levelled up """
        if self.level > self.base_lvl: # means it has updated its level
            self.current_hp = 12 + self.level // 2
