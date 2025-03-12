""" Implementation of attributes and methods of Material for Trader
    All functions, unless stated otherwise, have a constant best / worst case complexity of O(1).
"""

from random_gen import RandomGen

# Material names taken from https://minecraft-archive.fandom.com/wiki/Items
RANDOM_MATERIAL_NAMES = [
    "Arrow",
    "Axe",
    "Bow",
    "Bucket",
    "Carrot on a Stick",
    "Clock",
    "Compass",
    "Crossbow",
    "Exploration Map",
    "Fire Charge",
    "Fishing Rod",
    "Flint and Steel",
    "Glass Bottle",
    "Dragon's Breath",
    "Hoe",
    "Lead",
    "Map",
    "Pickaxe",
    "Shears",
    "Shield",
    "Shovel",
    "Sword",
    "Saddle",
    "Spyglass",
    "Totem of Undying",
    "Blaze Powder",
    "Blaze Rod",
    "Bone",
    "Bone meal",
    "Book",
    "Book and Quill",
    "Enchanted Book",
    "Bowl",
    "Brick",
    "Clay",
    "Coal",
    "Charcoal",
    "Cocoa Beans",
    "Copper Ingot",
    "Diamond",
    "Dyes",
    "Ender Pearl",
    "Eye of Ender",
    "Feather",
    "Spider Eye",
    "Fermented Spider Eye",
    "Flint",
    "Ghast Tear",
    "Glistering Melon",
    "Glowstone Dust",
    "Gold Ingot",
    "Gold Nugget",
    "Gunpowder",
    "Ink Sac",
    "Iron Ingot",
    "Iron Nugget",
    "Lapis Lazuli",
    "Leather",
    "Magma Cream",
    "Music Disc",
    "Name Tag",
    "Nether Bricks",
    "Paper",
    "Popped Chorus Fruit",
    "Prismarine Crystal",
    "Prismarine Shard",
    "Rabbit's Foot",
    "Rabbit Hide",
    "Redstone",
    "Seeds",
    "Beetroot Seeds",
    "Nether Wart Seeds",
    "Pumpkin Seeds",
    "Wheat Seeds",
    "Slimeball",
    "Snowball",
    "Spawn Egg",
    "Stick",
    "String",
    "Wheat",
    "Netherite Ingot",
]


class Material:
    """
    Creates different material object with different mining rate

    Attributes:
         name = Used to identify the material
         mining rate = Specifies how many hunger points are needed to mine a single unit of the material

    Getters:
         get_name = Return name of player that is mining a Material
         get_mining_rate = Return mining rate of player

    Methods:
         random_material = Generates a material randomly
    """
    
    def __init__(self, name: str, mining_rate: float) -> None:
        """ Initialisation of Materials """
        self.name = name
        self.mining_rate = mining_rate

    def get_material_name(self) -> str:
        """ Return Trader's name """
        return self.name

    def get_mining_rate(self) -> float:
        """ Return mining rate """
        return self.mining_rate

    def __str__(self) -> str:
        """ String representation of materials and its mining rate, return String """
        return f'<Material: [{self.get_material_name()}: {self.get_mining_rate()}🍗/💎]'

    @classmethod
    def random_material(cls) -> Material:
        """ Generate and return a random material and mining rate """
        material_name = RandomGen.random_choice(RANDOM_MATERIAL_NAMES)  # random selected Material name
        mining_rate = RandomGen.random_float() * 10  # random generated mining rate
        return Material(material_name, mining_rate)


if __name__ == "__main__":
    print(Material("Coal", 4.5))
