"""
This module implements an abstract class of Pokemon with basic attributes and methods.
All functions, unless stated otherwise, have a constant best / worst case complexity of O(1).
"""

from __future__ import annotations

__author__ = "Scaffold by Jackson Goerner, Code by Chew Xin Ning, Foo Kai Yan, Gan Kai Xin and Alicia Chik Wen Quek"

# Import libraries
from abc import ABC, abstractmethod
from random_gen import RandomGen


class PokemonBase(ABC):  # Abstract class
    """  To define common attributes and methods of a Pokemon.

    Attributes:
        poke_name(str) = Pokemon's name
        max_hp(int) = maximum hit points of the Pokemon
        current_hp(int) = Pokemon's current hit points
        poke_type(str) = type of Pokemon
        level(int) = Pokemon's level
        initial_hp(int) = Pokemon's initial hit points
        speed(int) = Pokemon's speed
        defence(int) = Pokemon's defence
        attack_damage(int) = Pokemon's attack damage towards its opponent
        status_effect(str) = Pokemon's unique status effects they can inflict when battling
        heal_count(int) = number of times a specific Pokemon get healed
        eff_atk(int) = effective attack damage of a Pokemon towards its opponent
        status_effect_obtained(str) = status effect obtained from opponent
        current_poke(str) = current Pokemon that is selected for battling

    Getters:
        get_speed = return Pokemon's speed
        get_attack_damage = return Pokemon's attack damage towards its opponent
        get_defence = return Pokemon's defence against opponent
        get_hp = return Pokemon's current health/hit points
        get_poke_name = return Pokemon's name
        get_level = return Pokemon's current level
        get_poke_type = return Pokemon's type
        get_evolved_version = evolve Pokemon to another class and return evolved Pokemon

    Methods:
        heal = To clear status effect obtained and reset hp to initial hp
        is_fainted = determine if a Pokemon is fainted based on its hp
        level_up = increment Pokemon's current level by 1
        lose_hp = lose hp according to the damage they received
        defend = perform defence calculation based on damage received
        attack = perform attack based on status effect and status effect obtained
        effective_attack = to determine how effective some moves are against others
        should_evolve = check if Pokemon is applicable to evolve based on their current level
        can_evolve = check if a Pokemon can evolve based on their name

    """

    # class variable, accessible for all methods
    poke_name = None

    def __init__(self, hp: int, poke_type: str) -> None:
        """ Initialisation of Pokemon created.

            :pre1: hp must be an integer type
            :pre2: poke_type must be one of the available type
            :param arg1: maximum hit point
            :param arg2: type of Pokemon
            :complexity: occur in precondition for poke_type,
                         Best O(Comp==) if target poke_type is at index 0 of the checklist,
                         worst O(Comp== * N), when target poke_type is not in the checklist,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in the list
        """

        # precondition for hp
        if type(hp) != int:
            raise TypeError(f'Please enter maximum hit point as integer :)')
        else:
            # accept valid input as max_hp and current_hp
            self.max_hp = hp
            self.current_hp = hp

        # precondition for poke_type
        if poke_type not in ['Fire', 'Grass', 'Water', 'Ghost', 'Normal']:
            raise ValueError("INVALID POKE TYPE, OOPS:(")
        else:
            # accept valid poke_type
            self.poke_type = poke_type

        # initialisation of instance variable
        self.level = None
        self.initial_hp = self.max_hp
        self.speed = None
        self.defence = None
        self.attack_damage = None
        self.status_effect = None
        self.heal_count = 0
        self.eff_atk = 0
        self.status_effect_obtained = None

    @abstractmethod
    def get_speed(self) -> int:
        """ Get Pokemon's speed """
        pass

    @abstractmethod
    def get_attack_damage(self) -> int:
        """ Get Pokemon's attack damage """
        pass

    @abstractmethod
    def get_defence(self) -> int:
        """ Get Pokemon's defence """
        pass

    @abstractmethod
    def get_hp(self) -> int:
        """ Get Pokemon's health/hit points """
        pass

    def get_poke_name(self) -> str:
        """ Get Pokemon's name """
        return self.poke_name

    def get_level(self) -> int:
        """ Get Pokemon's level """
        return self.level

    def get_poke_type(self) -> str:
        """ Get Pokemon's type """
        return self.poke_type

    def heal(self) -> None:
        """ To clear status effect obtained and reset hp to initial hp """
        self.status_effect = None # clear status effect
        self.current_hp = self.initial_hp # reset hp
        self.heal_count += 1 # increment number of heal

    def is_fainted(self) -> bool:
        """ If hp is equal to or below 0, the Pokemon is fainted """
        if self.get_hp() <= 0:
            return True
        else:
            return False

    def level_up(self) -> None:
        """ Level up Pokemon by 1 level from its base level if Pokemon is not fainted """
        if not self.is_fainted():
            self.level += 1

    def lose_hp(self, lost_hp: int) -> None:
        """ Pokemon loses hp according to the damage they received """
        self.current_hp -= lost_hp

    def defend(self, damage: int) -> None:
        """ Accept damage and decrease hit point based on Pokemon's defence

            :complexity: Best = O(Comp==) if Pokemon's name is not needed to compare with item in list,
                         Worst = O(Comp== * N) if Pokemon's name is not in the list,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in list
        """

        if self.get_poke_name() == "Charmander":
            if damage > self.get_defence():
                self.lose_hp(damage)
            else:
                self.lose_hp(damage // 2)

        elif self.get_poke_name() == "Squirtle":
            if damage > 2 * self.get_defence():
                self.lose_hp(damage)
            else:
                self.lose_hp(damage // 2)

        elif self.get_poke_name() == "Bulbasaur":
            if damage > (self.get_defence() + 5):
                self.lose_hp(damage)
            else:
                self.lose_hp(damage // 2)

        # worst time complexity occurs when Pokemon's name is the last element in the list
        elif self.get_poke_name() in ["Gastly", "Haunter", "Gengar"]:
            self.lose_hp(damage)

        elif self.get_poke_name() == "Eevee":
            if damage >= self.get_defence():
                self.lose_hp(damage)
            # else, lose no hp

        elif self.get_poke_name() == "Charizard":
            if damage > self.get_defence():
                self.lose_hp(2 * damage)
            else:
                self.lose_hp(damage)

        elif self.get_poke_name() == "Blastoise":
            if damage > 2 * self.get_defence():
                self.lose_hp(damage)
            else:
                self.lose_hp(damage//2)

        elif self.get_poke_name() == "Venusaur":
            if damage > (self.get_defence() + 5):
                self.lose_hp(damage)
            else:
                self.lose_hp(damage//2)

    def attack(self, other: PokemonBase) -> None:
        """ Perform attack and apply status effect to opponent

            :complexity: Best = Worst = O(Comp==),
                         where O(Comp==) is the complexity for string comparison of status_effect_obtained
        """

        self.attack_damage = self.effective_attack(other)
        # if a pokemon is asleep, stop the attack
        if self.status_effect == "Sleep":
            # end attack
            pass

        else:
            # opponent accept damage
            if self.status_effect_obtained != "Confusion":
                other.lose_hp(self.attack_damage)

            # if a pokemon is confused, it has 50% chance to attack itself
            if self.status_effect_obtained == "Confusion":
                if RandomGen.random_chance(0.5): # if True, pokemon attack itself

                    # calculate effective attack
                    self.attack_damage = PokemonBase.effective_attack(self, other)

                    # apply attack damage
                    self.defend(self.attack_damage)

                    # end attack
                    pass

            # lose 1 hp and halves effective attack
            elif self.status_effect_obtained == "Burn":
                self.lose_hp(1)
                self.eff_atk = (self.effective_attack(other) // 2)

            # halves speed
            elif self.status_effect_obtained == "Paralysis":
                self.speed = (self.speed // 2)

            # lose 3 hp
            elif self.status_effect_obtained == "Poison":
                self.lose_hp(3)

            # 20% chance to inflict pokemon's respective status effect onto opponent
            if RandomGen.random_chance(0.2):
                other.status_effect_obtained = self.status_effect

    def effective_attack(self, other: PokemonBase) -> int:
        """ To calculate multiplier apply to attacking stat based on different Pokemon type

            complexity: Best = O(Comp==) if Pokemon's name is in the first index in checklist,
                         Worst = O(Comp== * N) if Pokemon's name is not in the list,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in list
        """

        # initialise multiplier to be 0
        multiplier = 0
        if self.get_poke_type() == "Fire":
            if other.get_poke_type() in ["Fire", "Ghost", "Normal"]:
                multiplier = 1
            elif other.get_poke_type() == "Grass":
                multiplier = 2
            elif other.get_poke_type() == "Water":
                multiplier = 0.5

        if self.get_poke_type() == "Grass":
            if other.get_poke_type() in ["Grass", "Ghost", "Normal"]:
                multiplier = 1
            elif other.get_poke_type() == "Water":
                multiplier = 2
            elif other.get_poke_type() == "Fire":
                multiplier = 0.5

        if self.get_poke_type() == "Water":
            if other.get_poke_type() in ["Water", "Ghost", "Normal"]:
                multiplier = 1
            elif other.get_poke_type() == "Fire":
                multiplier = 2
            elif other.get_poke_type() == "Grass":
                multiplier = 0.5

        if self.get_poke_type() == "Ghost":
            if other.get_poke_type() in ["Fire", "Grass", "Water"]:
                multiplier = 1.25
            elif other.get_poke_type() == "Ghost":
                multiplier = 2
            elif other.get_poke_type() == "Normal":
                multiplier = 0

        if self.get_poke_type() == "Normal":
            if other.get_poke_type() in ["Fire", "Grass", "Water"]:
                multiplier = 1.25
            elif other.get_poke_type() == "Ghost":
                multiplier = 0
            elif other.get_poke_type() == "Normal":
                multiplier = 1

        # calculate and return integer effective attack
        self.eff_atk = multiplier * self.attack_damage
        return int(self.eff_atk)

    def should_evolve(self) -> bool:
        """ Check if pokemon is applicable to evolve option.

            :complexity: Best = O(Comp==) if Pokemon's name is at the first index in list,
                         Worst = O(Comp== * N) if Pokemon's name is not in the list,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in list
        """

        # only specific Pokemon with applicable level can evolve
        should_evolve = False
        if self.get_poke_name() in ["Charmander", "Squirtle", "Bulbasaur", "Haunter"]:
            if self.level >= 3:
                should_evolve = True
        elif self.get_poke_name() == "Gastly":
            if self.level >= 1:
                should_evolve = True

        return should_evolve

    def can_evolve(self) -> bool:
        """ Check if pokemon can evolve.
            :complexity: Best = O(Comp==) if Pokemon's name is the first index in list,
                         Worst = O(Comp== * N) if Pokemon's name not in the last index in list,
                         where O(Comp==) is the complexity for string comparison,
                         O(N) is the complexity of traversing through item in list
        """

        if self.get_poke_name() in ["Charmander", "Squirtle", "Bulbasaur", "Gastly", "Haunter"]:
            return True
        else:
            return False

    # not abstract, since not all the Pokemon can evolve
    def get_evolved_version(self) -> PokemonBase:
        """ Change Pokemon class if the Pokemon evolves and return evolved Pokemon """
        pass

    def __str__(self) -> str:
        """ Return String representation of Pokemon's attributes """
        return f'LV. {self.level} {self.get_poke_name()}: {self.current_hp} HP'
