""" Hash Table ADT
    Defines a Hash Table using Linear Probing for conflict resolution.
    All functions, unless stated otherwise, have a constant best / worst case complexity of O(1).
"""
from __future__ import annotations
__author__ = 'Gan Kai Xin, Alicia Quek, Chew Xin Ning, Foo Kai Yan'
__docformat__ = 'reStructuredText'
__modified__ = '23/10/2022'
__since__ = '16/10/2022'


from referential_array import ArrayR
from typing import TypeVar, Generic
from primes import LargestPrimeIterator
T = TypeVar('T')


class LinearProbeTable(Generic[T]):
    """
        Linear Probe Table.

        Attributes:
            count: number of elements in the hash table
            table: used to represent our internal array
            tablesize: current size of the hash table
            expected_size: maximum number of elements that will be added to the hash table
            conflict_count: total number of conflicts
            probe_length_lst: list of probing done throughout the execution of the code that will be used to determine probe_total and probe_max
            rehash_count: total number of times rehashing is done

        Methods:
            hash: Hash a key for insertion into the hashtable.
            statistics: Return a tuple of 4 values; conflict_count, probe_total, probe_max, rehash_count.
            _linear_probe: Find the correct position for this key in the hash table using linear probing. KeyError is raise when a position can't be found
            keys: Returns all keys in the hash table.
            values: Returns all values in the hash table.
            is_empty: Returns whether the hash table is empty.
            is_full: Returns whether the hash table is full.
            insert: Utility method to call our setitem method.
            _rehash: resize table and reinsert all values.
    """

    def __init__(self, expected_size: int, tablesize_override: int = -1) -> None:
        """
            Initialiser, initialises the hash table
            :param arg1: expected_size
            :param arg2: tablesize_override
            :complexity: O(N) where N is the tablesize
        """
        self.count = 0
        # If tablesize_override is -1, a reasonable tablesize is  chosen: expected_size*2.
        # Else, set the tablesize to the exact value of tablesize_override.
        if tablesize_override == -1:
            self.tablesize = expected_size*2 # better to have a table double the size than u need, so dont have to rehash often
        else:
            self.tablesize = tablesize_override
        self.table = ArrayR(self.tablesize)
        self.expected_size = expected_size  # for rehash
        self.conflict_count = 0
        self.probe_length_lst = []
        self.rehash_count = 0

    def hash(self, key: str) -> int:
        """
            Hash a key for insertion into the hashtable.
            :complexity: O(K) where K is the size of the key
        """
        value = 0
        a = 31415 # prime base number to avoid clustering and collisions
        b = 27183
        for char in key:
            value = (ord(char) + a * value) % self.tablesize
            a = a * b % (self.tablesize - 1)
        return value

    def statistics(self) -> tuple:
        """
            Returns a tuple of 4 values:
                ○ the total number of conflicts (conflict_count)
                ○ the total distance probed throughout the execution of the code (probe_total)
                ○ the length of the longest probe chain throughout the execution of the code (probe_max)
                ○ the total number of times rehashing is done (rehash_count)
            :complexity: O(n) where n is the length of the list
        """
        probe_max = max(self.probe_length_lst)
        probe_total = sum(self.probe_length_lst)

        return (self.conflict_count, probe_total, probe_max, self.rehash_count)

    def __len__(self) -> int:
        """
            Returns number of elements in the hash table
        """
        return self.count

    def _linear_probe(self, key: str, is_insert: bool) -> int:
        """
            Find the correct position for this key in the hash table using linear probing.
            :complexity best: O(K) first position is empty
                            where K is the size of the key
            :complexity worst: O(K + N) when we've searched the entire table
                            where N is the tablesize
            :raises KeyError: When a position can't be found
        """
        position = self.hash(key)  # get the position using hash

        if is_insert and self.is_full():
            raise KeyError(key)

        conflict = False
        probe_chain = []
        for _ in range(len(self.table)):  # start traversing
            if self.table[position] is None:  # found empty slot
                if is_insert:
                    if conflict == True:
                        self.conflict_count += 1
                    self.probe_length_lst.append(len(probe_chain))
                    return position
                else:
                    raise KeyError(key)  # so the key is not in
            elif self.table[position][0] == key:  # found key
                if conflict == True:
                    self.conflict_count += 1
                self.probe_length_lst.append(len(probe_chain))
                return position
            else:  # slot not empty but not the key, try next (Linear Probing)
                position = (position + 1) % len(self.table)
                probe_chain.append(position)
                conflict = True

        raise KeyError(key) 
        
    def keys(self) -> list[str]:
        """
            Returns all keys in the hash table.
            :complexity best: O(1) when table has 1 key only
            :complexity worst: O(N) when we've searched the entire table
                            where N is the tablesize
        """
        res = []
        for x in range(len(self.table)):
            if self.table[x] is not None:
                res.append(self.table[x][0])
        return res

    def values(self) -> list[T]:
        """
            Returns all values in the hash table.
            :complexity best: O(1) when table has 1 value only
            :complexity worst: O(N) when we've searched the entire table
                            where N is the tablesize
        """
        res = []
        for x in range(len(self.table)):
            if self.table[x] is not None:
                res.append(self.table[x][1])
        return res

    def __contains__(self, key: str) -> bool:
        """
            Checks to see if the given key is in the Hash Table
            :see: #self.__getitem__(self, key: str)
        """
        try:
            _ = self[key]
        except KeyError:
            return False
        else:
            return True

    def __getitem__(self, key: str) -> T:
        """
            Get the item at a certain key
            :see: #self._linear_probe(key: str, is_insert: bool)
            :complexity best: O(K) first position is empty
                            where K is the size of the key
            :complexity worst: O(K + N) when we've searched the entire table
                            where N is the tablesize
            :raises KeyError: when the item doesn't exist
        """
        position = self._linear_probe(key, False)
        return self.table[position][1]

    def __setitem__(self, key: str, data: T) -> None:
        """
            Set an (key, data) pair in our hash table
            :see: #self._linear_probe(key: str, is_insert: bool)
            :see: #self.__contains__(key: str)
            :complexity best: O(K) first position is empty
                            where K is the size of the key
            :complexity worst: O(K + N + m) when table rehash and we've searched the entire table
                            where N is the tablesize and m is the number of loop iterates till condition met.
        """
        position = self._linear_probe(key, True)
        if self.count > self.tablesize/2:
            self._rehash()

        if self.table[position] is None: # if its a new item
            self.count += 1

        self.table[position] = (key, data)

    def is_empty(self) -> bool:
        """
            Returns whether the hash table is empty
        """
        return self.count == 0

    def is_full(self) -> bool:
        """
            Returns whether the hash table is full
        """
        return self.count == len(self.table)

    def insert(self, key: str, data: T) -> None:
        """
            Utility method to call our setitem method
            :see: #__setitem__(self, key: str, data: T)
        """
        self[key] = data

    def _rehash(self) -> None:
        """
            Need to resize table and reinsert all values
            :complexity: O(N+m) where N is the tablesize and m is the number of times while loop iterates till condition met.
        """
        # This should be called on insert if the number of items stored there exceeds a half of its capacity.
        # Prime number is use as the new table size to reduce the load factor and generally avoid collisions
        prime_tablesize = LargestPrimeIterator(self.tablesize, 2)
        while next(prime_tablesize) <= self.tablesize:
            prime_use = next(prime_tablesize)
        new_hash = LinearProbeTable(self.expected_size , prime_use)
        for i in range(len(self.table)):
            if self.table[i] is not None:
                new_hash[str(self.table[i][0])] = self.table[i][1]
        self.count = new_hash.count
        self.table = new_hash.table
        self.rehash_count += 1

    def __str__(self) -> str:
        """
            Returns all they key/value pairs in our hash table (no particular
            order).
            :complexity: O(N) where N is the table size
        """
        result = ""
        for item in self.table:
            if item is not None:  # if item is not empty
                (key, value) = item
                result += "(" + str(key) + "," + str(value) + ")\n"
        return result

