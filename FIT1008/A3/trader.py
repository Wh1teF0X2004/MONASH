""" Implement abstract methods and common attributes that will be inherited by each Trader type.
    All functions, unless stated otherwise, have a constant best / worst case complexity of O(1).
"""

from __future__ import annotations

from abc import abstractmethod, ABC
from material import Material
from random_gen import RandomGen
from avl import AVLTree, AVLTreeNode

# Generated with https://www.namegenerator.co/real-names/english-name-generator
TRADER_NAMES = [
    "Pierce Hodge",
    "Loren Calhoun",
    "Janie Meyers",
    "Ivey Hudson",
    "Rae Vincent",
    "Bertie Combs",
    "Brooks Mclaughlin",
    "Lea Carpenter",
    "Charlie Kidd",
    "Emil Huffman",
    "Letitia Roach",
    "Roger Mathis",
    "Allie Graham",
    "Stanton Harrell",
    "Bert Shepherd",
    "Orson Hoover",
    "Lyle Randall",
    "Jo Gillespie",
    "Audie Burnett",
    "Curtis Dougherty",
    "Bernard Frost",
    "Jeffie Hensley",
    "Rene Shea",
    "Milo Chaney",
    "Buck Pierce",
    "Drew Flynn",
    "Ruby Cameron",
    "Collie Flowers",
    "Waldo Morgan",
    "Winston York",
    "Dollie Dickson",
    "Etha Morse",
    "Dana Rowland",
    "Eda Ryan",
    "Audrey Cobb",
    "Madison Fitzpatrick",
    "Gardner Pearson",
    "Effie Sheppard",
    "Katherine Mercer",
    "Dorsey Hansen",
    "Taylor Blackburn",
    "Mable Hodge",
    "Winnie French",
    "Troy Bartlett",
    "Maye Cummings",
    "Charley Hayes",
    "Berta White",
    "Ivey Mclean",
    "Joanna Ford",
    "Florence Cooley",
    "Vivian Stephens",
    "Callie Barron",
    "Tina Middleton",
    "Linda Glenn",
    "Loren Mcdaniel",
    "Ruby Goodman",
    "Ray Dodson",
    "Jo Bass",
    "Cora Kramer",
    "Taylor Schultz",
]


class Trader(ABC):
    """
    Abstract class to be used by different type of traders class.

    Attributes:
        name = Name of the trader
        materials_list = A list containing all materials in their inventory they might buy
        current_active_deal = Return current active deal of trader
        material_selected = Material wanted to buy
        buy_price = A random price for that deal
        is_selling = Return boolean representing whether Trader is currently selling Material
        trader_type = Type of Trader (RandomTrader / RangeTrader / HardTrader)

    Getters:
        get_trader_type = Return trader type (RandomTrader / RangeTrader / HardTrader)
        get_name = Return Trader's name
        get_buy_price = Return buy price of Material
        get_material_name = Return material name
        get_mining_rate = Return mining rate of a material

    Methods:
        random_trader = Class method that returns a trader of RandomTrader class
        add_material = Add all materials from material list provided by player
        remove_material = Removes a material from the trader's material list
        is_currently_selling = Returns boolean that indicate whether the trader is currently selling
        current_deal = Returns a tuple with the material the trader wants to buy and the buy_price offered
        generate_deal = Generate a deal for the trader
        stop_deal = Stop the deal and reset Material List
        sort_material_list = Sort the all the material present in the trader's inventory
    """

    def __init__(self, name: str) -> None:
        """ Initialisation, return None """
        self.name = name
        self.material_list = []
        self.current_active_deal = None
        self.material_selected = None
        self.buy_price = 0
        self.is_selling = False
        self.trader_type = None

    @classmethod
    def random_trader(cls):
        """ Generates a random trader of specific type with random name """
        name = RandomGen.random_choice(TRADER_NAMES)
        return cls(name)

    @abstractmethod  # different Trader has different Trader Type
    def get_trader_type(self) -> str:
        """ Return trader type """
        pass

    def get_name(self) -> str:
        """ Return Trader's name """
        return self.name

    def get_buy_price(self) -> int:
        """ Return buy price of Material """
        return self.buy_price

    def get_material_name(self) -> str:
        """ Return material name """
        if not self.is_selling:
            return "No deal currently!"
        return self.current_deal()[0].get_material_name()

    def get_mining_rate(self) -> float:
        """ Return mining rate of a material """
        if not self.is_selling:
            return 0
        return self.current_deal()[0].get_mining_rate()

    def set_all_materials(self, mats: list[Material]) -> None:
        """ Add all materials from material list provided by player
            :complexity: O(M), where M = #Material
        """
        for new_mat in mats:
            self.add_material(new_mat)

    def add_material(self, mat: Material) -> None:
        """ Adds a material passed to the method into the trader's material list """
        self.material_list.append(mat)

    def remove_material(self, mat: Material) -> None:
        """ Removes a material passed to the method into the trader's material list """
        self.material_list.remove(mat)

    def is_currently_selling(self) -> bool:
        """" Check whether the trader is currently selling """
        return self.is_selling

    def current_deal(self) -> tuple[Material, float]:
        """ Returns a tuple with the material selected and its buy price
            :raises ValueError: when there is no deal currently held, raise ValueError
        """

        if not self.is_selling:
            raise ValueError('No deal currently!')

        # initialise and return currently active deal
        self.current_active_deal = (self.material_selected, self.get_buy_price())
        return self.current_active_deal

    @abstractmethod
    def generate_deal(self) -> None:
        """ Generate trader's deal """
        pass

    def stop_deal(self) -> None:
        """ Trader will stop dealing and reset attributes """
        self.is_selling = False
        self.material_list = []
        self.current_active_deal = None
        self.material_selected = None
        self.buy_price = 0

    def __str__(self) -> str:
        """ Returns a string representing current deal of the trader """
        return f'<{self.get_trader_type()}: {self.get_name()} buying [{self.get_material_name()}: {self.get_mining_rate()}🍗/💎] for {self.get_buy_price():.2f}💰>'


class RandomTrader(Trader):
    """ Inherit from Trader class """

    def __init__(self, name: str) -> None:
        """ Initialisation of Random Trader """
        Trader.__init__(self, name)
        self.trader_type = "RandomTrader"

    def get_trader_type(self) -> str:
        """ Return trader type """
        return self.trader_type

    def generate_deal(self) -> None:
        """ Generate a random deal with random buy price, return None """
        self.material_selected = RandomGen.random_choice(self.material_list)
        self.buy_price = round(2 + 8 * RandomGen.random_float(), 2)

        # there is deal currently going on, therefore it is selling
        self.is_selling = True


class RangeTrader(Trader):
    """ Inherit from Trader class """

    def __init__(self, name: str) -> None:
        """ Initialisation of Range Trader """
        Trader.__init__(self, name)
        self.trader_type = "RangeTrader"

    def get_trader_type(self) -> str:
        """ Return trader type """
        return self.trader_type

    def set_materials(self, mats: list[Material]) -> None:
        """ Add all materials from material list provided by player
            :complexity: O(N), where N is the complexity for set_all_materials() function
        """
        Trader.set_all_materials(self, mats)

    def generate_deal(self) -> None:
        """ Generate a deal that using a random range of materials in material list, return None """

        # generate two random numbers
        i = RandomGen.randint(1, len(self.material_list))
        j = RandomGen.randint(i, len(self.material_list))

        # initialise material available to generate a deal
        material_available = self.materials_between(i-1, j)  # ranging from i-1 to j
        self.material_selected = RandomGen.random_choice(material_available)
        self.buy_price = round(2 + 8 * RandomGen.random_float(), 2)

        # set is_selling to True when there is a deal being generated
        self.is_selling = True

    def materials_between(self, i: int, j: int) -> list[Material]:
        """ Generate a list of the ith hardest to mine material to the jth hardest to mine, inclusive """

        # create an AVL tree to sort material in order
        avl_tree = AVLTree()

        # add into AVL tree which they will be automatically sorted
        for mats in self.material_list:
            mats = AVLTreeNode(mats)
            avl_tree.insert_aux(mats, mats)

        return avl_tree.range_between(i, j+1)


class HardTrader(Trader):
    """ Inherit from Trader class """

    def __init__(self, name: str) -> None:
        """ Initialisation, return None """
        Trader.__init__(self, name)
        self.trader_type = "HardTrader"

    def get_trader_type(self) -> str:
        """ Return trader type """
        return self.trader_type

    def generate_deal(self) -> None:
        """ Generate a deal that will be offered by a Trader, return None """

        # Retrieve the hardest to mine material, which is at last index of material list
        self.material_selected = self.material_list[-1]

        # Remove retrieved material from the inventory (list of materials)
        self.remove_material(self.material_selected)

        # Set buy price
        self.buy_price = round(2 + 8 * RandomGen.random_float(), 2)
        self.is_selling = True


if __name__ == "__main__":
    trader = RangeTrader("Jackson")
    print(trader)
    trader.set_materials([
        Material("Coal", 4.5),
        Material("Diamonds", 3),
        Material("Redstone", 20),
    ])
    trader.generate_deal()
    print(trader)
    trader.stop_deal()
    print(trader)

