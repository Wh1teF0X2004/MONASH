""" Implement methods and attributes for Player.
    All functions, unless stated otherwise, have a constant best / worst case complexity of O(1).
"""

from __future__ import annotations

from cave import Cave
from material import Material
from trader import Trader
from food import Food
from random_gen import RandomGen
from hash_table import LinearProbeTable

# List taken from https://minecraft.fandom.com/wiki/Mob
PLAYER_NAMES = [
    "Steve",
    "Alex",
    "ɘᴎiɿdoɿɘH",
    "Allay",
    "Axolotl",
    "Bat",
    "Cat",
    "Chicken",
    "Cod",
    "Cow",
    "Donkey",
    "Fox",
    "Frog",
    "Glow Squid",
    "Horse",
    "Mooshroom",
    "Mule",
    "Ocelot",
    "Parrot",
    "Pig",
    "Pufferfish",
    "Rabbit",
    "Salmon",
    "Sheep",
    "Skeleton Horse",
    "Snow Golem",
    "Squid",
    "Strider",
    "Tadpole",
    "Tropical Fish",
    "Turtle",
    "Villager",
    "Wandering Trader",
    "Bee",
    "Cave Spider",
    "Dolphin",
    "Enderman",
    "Goat",
    "Iron Golem",
    "Llama",
    "Panda",
    "Piglin",
    "Polar Bear",
    "Spider",
    "Trader Llama",
    "Wolf",
    "Zombified Piglin",
    "Blaze",
    "Chicken Jockey",
    "Creeper",
    "Drowned",
    "Elder Guardian",
    "Endermite",
    "Evoker",
    "Ghast",
    "Guardian",
    "Hoglin",
    "Husk",
    "Magma Cube",
    "Phantom",
    "Piglin Brute",
    "Pillager",
    "Ravager",
    "Shulker",
    "Silverfish",
    "Skeleton",
    "Skeleton Horseman",
    "Slime",
    "Spider Jockey",
    "Stray",
    "Vex",
    "Vindicator",
    "Warden",
    "Witch",
    "Wither Skeleton",
    "Zoglin",
    "Zombie",
    "Zombie Villager",
    "H̴͉͙̠̥̹͕͌̋͐e̸̢̧̟͈͍̝̮̹̰͒̀͌̈̆r̶̪̜͙̗̠̱̲̔̊̎͊̑̑̚o̷̧̮̙̗̖̦̠̺̞̾̓͆͛̅̉̽͘͜͝b̸̨̛̟̪̮̹̿́̒́̀͋̂̎̕͜r̸͖͈͚̞͙̯̲̬̗̅̇̑͒͑ͅi̶̜̓̍̀̑n̴͍̻̘͖̥̩͊̅͒̏̾̄͘͝͝ę̶̥̺̙̰̻̹̓̊̂̈́̆́̕͘͝͝"
]


class Player:
    """ Implementation of Player and set material, cave, food and trader for player.

    Attributes:
         name = Used to identify the player
         balance = The amount of emerald available for player
         foods_list = List of food that is available for player
         traders_list = List of trader that player can have a trade with
         caves_list = List of cave that player can choose to mine from
         material_list = List of material owned by player
         hunger_pts = Hunger points that is needed to mine a single unit of the material

    Getters:
         get_chosen_food = Return food chosen by player for trading
         get_caves_lists = Return list of cave on player's journey
         get_materials_list = Return materials in player's inventory
         get_traders_list = Return trader list for trading

    Setters:
         set_traders = Set list of traders that can carry out trades
         set_foods = Set list of food that player can buy
         set_materials = Set list of food that player currently owned
         set_caves = Set list of caves that player can choose to mine from

    Methods:
         random_player = Class method to generate a random player with random name and random amount of emeralds
         select_food_and_caves = Player get to choose optimal food to fill hunger bars and cave to mine from
    """

    DEFAULT_EMERALDS = 50

    MIN_EMERALDS = 14
    MAX_EMERALDS = 40

    def __init__(self, name, emeralds=None) -> None:
        """ Initialisation of Player, return None """
        self.name = name
        self.balance = self.DEFAULT_EMERALDS if emeralds is None else emeralds
        self.foods_list = []
        self.traders_list = []
        self.caves_list = []
        self.material_list = []
        self.hunger_pts = 0

    @classmethod
    def random_player(cls) -> Player:
        """ Generate a random player with random name and random amount of emeralds """
        name = RandomGen.random_choice(PLAYER_NAMES)
        emeralds = RandomGen.randint(cls.MIN_EMERALDS, cls.MAX_EMERALDS)
        return Player(name, emeralds)

    def get_chosen_food(self) -> str | None:
        """ Return Food chosen by player for trading if there is one,
        else return None if player did not choose any food to trade
        :complexity: O(N), where N is the complexity for comparing food name string
        """

        # if food chosen is None, return None
        if self.select_food_and_caves()[0] is None:
            return None
        else:
            return self.select_food_and_caves()[0].get_food_name()

    def get_caves_list(self) -> str:
        """ Return list of cave on player's journey
            :complexity: O(C), where C = #Cave
        """
        caves = ''
        counter = 0
        for cave in range(len(self.caves_list)):
            counter += 1
            caves += f'{counter}. {str(self.caves_list[cave])} \n'
        return caves

    def get_materials_list(self) -> str:
        """ Return materials in player's inventory
            :complexity: O(M), where M = #Material
        """
        materials = ''
        counter = 0
        for material in range(len(self.material_list)):
            counter += 1
            materials += f'{counter}. {str(self.material_list[material])} \n'
        return materials

    def get_traders_list(self) -> str:
        """ Return trader list for trading
            :complexity: O(T), where T = #Trader
        """
        traders = ''
        counter = 0
        for trader in range(len(self.traders_list)):
            counter += 1
            traders += f'{counter}. {str(self.traders_list[trader])} \n'
        return traders

    def set_traders(self, traders_list: list[Trader]) -> None:
        """ Set list of traders that can carry out trades """
        self.traders_list = traders_list

    def set_foods(self, foods_list: list[Food]) -> None:
        """ Set list of food that player can buy """
        self.foods_list = foods_list

    def set_materials(self, materials_list: list[Material]) -> None:
        """ Set list of food that player currently owned """
        self.material_list = materials_list

    def set_caves(self, caves_list: list[Cave]) -> None:
        """ Set list of caves that player can choose to mine from """
        self.caves_list = caves_list

    def select_food_and_caves(self) -> tuple[Food | None, float, list[tuple[Cave, float]]]:
        """ Function that return the food that player opted to buy to filled their hunger points,
            the emerald balance after the deal, and a list of all caves plundered on their journey,
            paired with the quantity of each material mined.

            Approach reason for:
                Food choice: Decided to choose ideal food option with the lowest price and highest number of hunger bars.
                Caves mine order: Decided to choose caves order according to traders material buying price, where caves with the materials
                                 with the highest buying price from traders will be mined first, in order to achieve the highest emerald balance.

            Example when :
            player = Player("Alex", emeralds=50)
            foods = [Food("Rice", 335, 58),Food("Chocolate Pie Slice", 377, 16),Food("Minced Beef", 478, 32)]
            caves = [Cave("Reachwater Rock", Material("Crossbow", 2.55), 7), Cave("Castle Karstaag Ruins", Material("Iron Nugget", 8.54), 6),
                    Cave("Pinepeak Cavern",  Material("Lapis Lazuli", 7.39), 9)]
            materials = [Material("Crossbow", 2.55), Material("Iron Nugget", 8.54), Material("Lapis Lazuli", 7.39)]
            With Traders:
            1. <HardTrader: Emil Huffman buying [Crossbow: 2.55🍗/💎] for 4.74💰>
            2. <HardTrader: Ruby Cameron buying [Iron Nugget: 8.54🍗/💎] for 6.69💰>
            3. <RandomTrader: Katherine Mercer buying [Lapis Lazuli: 7.39🍗/💎] for 7.00💰>

            The outcome of player.select_food_and_caves() would be:
            Food chosen: <Food: Chocolate Pie Slice 16💰 for 377🍗>
            Balance: 170.32
            Caves: [(<Cave: Pinepeak Cavern 9 <Material: [Lapis Lazuli: 7.39🍗/💎]>,9),
                    (<Cave: Castle Karstaag Ruins 6 <Material: [Iron Nugget: 8.54🍗/💎]>,6),
                    (<Cave: Reachwater Rock 7 <Material: [Crossbow: 2.55🍗/💎]>,7)]

            :complexity best: O(F + M + MN + T + TN + t + t^2) where F is the number of Foods, M = #Materials, T = #Traders,
                             C = #Caves, t is the number of unique materials at optimal price, N is the complexity of assignment
                             in hash table
            :complexity worst: O(F + M + MN + T + T * (Comp>= + N) + t + t^2 + t * C * (Comp== + R) where R is the complexity of
                                retrieval in hash table,
        """
        # list variable to be used
        dict_mat = {}   # dictionary containing information of material that can be sold
        lst_cave = []  # contain list of caves of player choice
        chosen_food = None
        temp_price = 100  # temporary price set at max 100
        temp_hunger_bar = 0

        # Step 1: choose ideal food option with the lowest price and highest number of hunger bars
        # The player can select one and only one food item to purchase, filling up their hunger points

        # Search for optimal food choice in foods_list, in terms of highest hunger bar at a low price
        # complexity of this for loop would be O(F) where F is the number of Foods
        for food in self.foods_list:
            # Check if player could afford the food, else chosen_food is None
            if food.get_price() <= self.balance:
                # if current food has a lower price and higher number of hunger bar, player would choose this food
                if food.get_hunger_bars() >=  temp_hunger_bar and food.get_price() <= temp_price:
                    temp_hunger_bar = food.get_hunger_bars()
                    temp_price = food.get_price()
                    chosen_food = food

        # if player could not afford all the food option or if foods_list is empty
        # and have no hunger points to mine, method is return
        if chosen_food == None and self.hunger_pts == 0:
            return (chosen_food, self.balance, lst_cave)

        # update balance and hunger bar
        self.balance -= chosen_food.get_price()
        self.hunger_pts += chosen_food.get_hunger_bars()

        # Step 2: Form a priority list to determine which caves is worth mining.
        # Have a hashtable with material name as key and mining rate as value
        # complexity of this hash table would be O(M) where M is the number of Materials = tablesize
        table_mat_info = LinearProbeTable(len(self.material_list), (len(self.material_list)*2))

        # complexity of this for loop would be O(M*N) where M is the number of Materials, N is the complexity of assignment in hash table
        for item in self.material_list:
            table_mat_info[item.get_material_name()] = item.get_mining_rate()

        # Have a hashtable with unique material name as key and price as value
        # complexity of this hash table would be O(T) where T is the number of Traders = tablesize
        table_mat_price = LinearProbeTable(len(self.traders_list), (len(self.traders_list)*2))

        # complexity of this for loop would be:
        # best: O(T*(N)) when there all traders sell unique material, where T is the number of Traders, N is the complexity of assignment in hash table
        # worst: O(T*(Comp>= + N)) when there some traders sell same materials, where Comp>= is cost of comparison of the same materials
        for trader in self.traders_list:
            # if there is a trader that sell the same material as the others, check which trader sell at a higher price.
            if trader.get_material_name() in table_mat_price.keys():
                if trader.get_buy_price() >= table_mat_price[trader.get_material_name()]:
                    # overwrite the existing price with the new one of the same material
                    table_mat_price[trader.get_material_name()] = trader.get_buy_price()
            else:
                # Add material with its buy price to hash table
                table_mat_price[trader.get_material_name()] = trader.get_buy_price()

        # Best = O(N*Comp==)^2, where N is number of keys, Comp== complexity for integer comparison
        # Worst = O(N*Comp==*M)^2, where N is number of keys, Comp== complexity for comparison, M is complexity for hash table operations
        # create a dictionary containing infomation of material, generated using table_mat_price and table_mat_info, that can be sold

        for price_key in table_mat_price.keys():
            for info_key in table_mat_info.keys():
                # only add into dictionary if the material can be sold
                if price_key == info_key:
                    dict_mat[info_key] = table_mat_info[info_key]

        # Compute a list that contains values representing the hunger bars consumed to mine each material
        # Compute lst_materials that contains material names in increasing order of hunger bars consumed
        # Best = O(N) when the first element in value list is already less than the second element OR when there is only one material, where N is (length of values list - 1)
        # Worst = O(N^2) when all the comparison of previous element (values[i]) is more than the current element (temp_val)

        values = list(dict_mat.values())
        lst_material = list(dict_mat.keys())

        for mats in range(1, len(values)):
            temp_val = values[mats]
            temp_key = lst_material[mats]
            i = mats - 1
            while i >= 0 and values[i] > temp_val:
                values[i + 1] = values[i]
                lst_material[i + 1] = lst_material[i]
                i -= 1
            values[i + 1] = temp_val
            lst_material[i + 1] = temp_key

        # Step 3: List the caves that player will go to mine on their journey to get optimal balance of emeralds
        # The player go mining for the day, using their hunger to collect materials
        # A list of all caves plundered on their journey, paired with the quantity of each material mined.
        # complexity of this for loop would be:
        # best: O(t) when hunger_pts == 0 in the first place, where t is the number of unique materials at optimal price
        # worst: O(t)*O(C*(Comp== + R)) when hunger_pts != 0 throughout the iteration, where C is the number of Caves,
        #        R is the complexity of retrieval in hash table and Comp == is comparison of materials
        for order in range(len(lst_material)):
            if self.hunger_pts != 0:
                for cave in self.caves_list:
                    if cave.get_material().get_material_name() == lst_material[order]:
                        mining_r = table_mat_info[lst_material[order]]
                        h_bar = cave.get_quantity()*mining_r
                        # if cant mine all, calculate the amount that can be mined.
                        if h_bar > self.hunger_pts:
                            quantity = self.hunger_pts/mining_r
                        else:
                            quantity = cave.get_quantity()
                        self.hunger_pts -= quantity*mining_r
                        self.balance += quantity*table_mat_price[lst_material[order]]
                        lst_cave.append((cave, quantity))

        return (chosen_food, self.balance, lst_cave)


    def __str__(self) -> str:
        """ String representation of player's material, cave, food and trader lists """
        return f'Player Name: {self.name} \nBalance: {self.balance:.2f} 💰💰 \nFood: {self.get_chosen_food()} 🍗🍗' \
               f'\nCaves: \n{self.get_caves_list()}Materials: \n{self.get_materials_list()}Traders: \n{self.get_traders_list()}'


if __name__ == "__main__":
    print(Player("Steve"))
    print(Player("Alex", emeralds=1000))

