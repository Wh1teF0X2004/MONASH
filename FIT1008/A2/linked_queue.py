""" Queue ADT and an array implementation.

Defines a generic abstract queue with the usual methods, and implements
a circular queue and linear queue using arrays. It also implements a linked queue.
Also defines UnitTests for the class.
"""
__author__ = "Maria Garcia de la Banda, modified by Brendon Taylor"
__docformat__ = 'reStructuredText'

import unittest
from abc import ABC, abstractmethod
from enum import Enum
from typing import Generic
from referential_array import ArrayR, T


class QueueADT(ABC, Generic[T]):
    """ Abstract class for a generic Queue. """

    def __init__(self) -> None:
        self.length = 0

    @abstractmethod
    def append(self, item: T) -> None:
        """ Adds an element to the rear of the queue."""
        pass

    @abstractmethod
    def serve(self) -> T:
        """ Deletes and returns the element at the queue's front."""
        pass

    def __len__(self) -> int:
        """ Returns the number of elements in the queue."""
        return self.length

    def is_empty(self) -> bool:
        """ True if the queue is empty. """
        return len(self) == 0

    @abstractmethod
    def is_full(self) -> bool:
        """ True if the stack is full and no element can be pushed. """
        pass

    def clear(self):
        """ Clears all elements from the queue. """
        self.length = 0


class LinearQueue(QueueADT[T]):
    """ Linear implementation of a queue with arrays.

    Attributes:
         length (int): number of elements in the queue (inherited)
         front (int): index of the element at the front of the queue
         rear (int): index of the first empty space at the back of the queue
         array (ArrayR[T]): array storing the elements of the queue

    ArrayR cannot create empty arrays. So MIN_CAPACITY used to avoid this.
    """
    MIN_CAPACITY = 1

    def __init__(self, max_capacity: int) -> None:
        QueueADT.__init__(self)
        self.front = 0
        self.rear = 0
        self.array = ArrayR(max(self.MIN_CAPACITY, max_capacity))

    def append(self, item: T) -> None:
        """ Adds an element to the rear of the queue.
        :pre: queue is not full
        :complexity: O(1)
        :raises Exception: if the queueu is full
        """
        if self.is_full():
            raise Exception("Queue is full")

        self.array[self.rear] = item
        self.length += 1
        self.rear += 1

    def serve(self) -> T:
        """ Deletes and returns the element at the queue's front.
        :pre: queue is not empty
        :complexity: O(1)
        :raises Exception: if the queue is empty
        """
        if self.is_empty():
            raise Exception("Queue is empty")

        self.length -= 1
        item = self.array[self.front]
        self.front += 1
        return item

    def clear(self):
        """ Clears all elements from the queue.
        :complexity: O(1)
        """
        super().clear()
        self.front = 0
        self.rear = 0

    def is_full(self) -> bool:
        """ True if the queue is full and no element can be appended.
        :complexity: O(1)
        """
        return self.rear == len(self.array)

    def __toString__(self):
        """
        :complexity: O(N*M)
            where N is the length of the list
                  M is the size of the biggest item
        """
        result = "["
        for i in range(self.front, self.rear):
            if i >= self.front:
                result += ', '
            result += str(self.array[i])
        result += ']'


class CircularQueue(QueueADT[T]):
    """ Circular implementation of a queue with arrays.

    Attributes:
         length (int): number of elements in the queue (inherited)
         front (int): index of the element at the front of the queue
         rear (int): index of the first empty space at the back of the queue
         array (ArrayR[T]): array storing the elements of the queue

    ArrayR cannot create empty arrays. So MIN_CAPACITY used to avoid this.
    """
    MIN_CAPACITY = 1

    def __init__(self, max_capacity: int) -> None:
        QueueADT.__init__(self)
        self.front = 0
        self.rear = 0
        self.array = ArrayR(max(self.MIN_CAPACITY, max_capacity))

    def append(self, item: T) -> None:
        """ Adds an element to the rear of the queue.
        :pre: queue is not full
        :complexity: O(1)
        :raises Exception: if the queueu is full
        """
        if self.is_full():
            raise Exception("Queue is full")

        self.array[self.rear] = item
        self.length += 1
        self.rear = (self.rear + 1) % len(self.array)

    def serve(self) -> T:
        """ Deletes and returns the element at the queue's front.
        :pre: queue is not empty
        :complexity: O(1)
        :raises Exception: if the queue is empty
        """
        if self.is_empty():
            raise Exception("Queue is empty")

        self.length -= 1
        item = self.array[self.front]
        self.front = (self.front + 1) % len(self.array)
        return item

    def is_full(self) -> T:
        """ True if the queue is full and no element can be appended.
        :complexity: O(1)
        """
        return len(self) == len(self.array)

    def clear(self) -> None:
        """ Clears all elements from the queue.
        :complexity: O(1)
        """
        Queue.__init__(self)
        self.front = 0
        self.rear = 0

    def __str__(self) -> str:
        """Computes a string from the queue items - front to rear.
        :complexity: O(N*M)
            where N is the length of the list
                  M is the size of the biggest item
        """
        length = len(self)
        if length > 0:
            index = self.front
            output = str(self.array[index])
            for _ in range(len(self) - 1):
                index = (index + 1) % len(self.array)
                output += "," + str(self.array[index])
        else:
            output = ""
        return output


class Node(Generic[T]):
    """ Implementation of a generic Node class

    Attributes:
         item (T): the data to be stored by the node
         link (Node[T]): pointer to the next node

    ArrayR cannot create empty arrays. So MIN_CAPCITY used to avoid this.
    """

    def __init__(self, item: T = None) -> None:
        self.item = item
        self.link = None


class LinkQueue(QueueADT[T]):
    """ Linked implementation of a queue with nodes.

    Attributes:
         length (int): number of elements in the linked queue (inherited)
         front (int): reference to the front node (None represents an empty queue)
         rear (int): reference to the rear node (None represents an empty queue)
    """

    def __init__(self, _=None) -> None:
        QueueADT.__init__(self)
        self.front = None
        self.rear = None

    def clear(self) -> None:
        """ Resets the queue
        :complexity: O(1)
        """
        super().clear()
        self.front = None
        self.rear = None

    def is_full(self) -> bool:
        """ Returns true if the list is full
        :complexity: O(1)
        """
        return False

    def append(self, item: T) -> None:
        """ Adds an element to the rear of the queue.
        :complexity: O(1)
        """
        new_node = Node(item)
        if self.is_empty():
            self.front = new_node
        else:
            self.rear.link = new_node
        self.rear = new_node
        self.length += 1

    def serve(self) -> T:
        """ Deletes and returns the element at the queue's front.
        :pre: queue is not empty
        :complexity: O(1)
        :raises Exception: if the queue is empty
        """
        if self.is_empty():
            raise Exception("Queue is empty")

        temp = self.front.item
        self.front = self.front.link
        self.length -= 1
        if self.is_empty():
            self.rear = None
        return temp

    def __toString__(self):
        """ Computes a string from the queue items - front to rear.
        :complexity: O(N*M)
            where N is the length of the list
                  M is the size of the biggest item
        """
        result = ""
        node = self.front
        while node is not None:
            result += str(node.item) + ", "
            node = node.next

        return result


class DataStructure(Enum):
    LINEAR = 1
    CIRCULAR = 2
    LINK = 3


class TestQueue(unittest.TestCase):
    """ Tests for the above class."""
    EMPTY = 0
    ROOMY = 5
    LARGE = 10
    CAPACITY = 20

    def setUp(self):
        self.lengths = [self.EMPTY, self.ROOMY, self.LARGE, self.ROOMY, self.LARGE]

        if test_list == DataStructure.LINEAR:
            self.queues = [LinearQueue(self.CAPACITY) for i in range(len(self.lengths))]
        elif test_list == DataStructure.CIRCULAR:
            self.queues = [CircularQueue(self.CAPACITY) for i in range(len(self.lengths))]
        else:
            self.queues = [LinkQueue() for i in range(len(self.lengths))]

        for queue, length in zip(self.queues, self.lengths):
            for i in range(length):
                queue.append(i)
        self.empty_queue = self.queues[0]
        self.roomy_queue = self.queues[1]
        self.large_queue = self.queues[2]
        # we build empty queues from clear.
        # this is an indirect way of testing if clear works!
        # (perhaps not the best)
        self.clear_queue = self.queues[3]
        self.clear_queue.clear()
        self.lengths[3] = 0
        self.queues[4].clear()
        self.lengths[4] = 0

    def tearDown(self):
        for s in self.queues:
            s.clear()

    def test_init(self):
        self.assertTrue(self.empty_queue.is_empty())
        self.assertEqual(len(self.empty_queue), 0)

    def test_len(self):
        """ Tests the length of all queues created during setup."""
        for queue, length in zip(self.queues, self.lengths):
            self.assertEqual(len(queue), length)

    def test_is_empty_add(self):
        """ Tests queues that have been created empty/non-empty."""
        self.assertTrue(self.empty_queue.is_empty())
        self.assertFalse(self.roomy_queue.is_empty())
        self.assertFalse(self.large_queue.is_empty())

    def test_is_empty_clear(self):
        """ Tests queues that have been cleared."""
        for queue in self.queues:
            queue.clear()
            self.assertTrue(queue.is_empty())

    def test_is_empty_serve(self):
        """ Tests queues that have been served completely."""
        for queue in self.queues:
            # we empty the queue
            try:
                while True:
                    was_empty = queue.is_empty()
                    queue.serve()
                    # if we have served without raising an assertion,
                    # then the queue was not empty.
                    self.assertFalse(was_empty)
            except:
                self.assertTrue(queue.is_empty())

    def test_is_full_add(self):
        """ Tests queues that have been created not full."""
        self.assertFalse(self.empty_queue.is_full())
        self.assertFalse(self.roomy_queue.is_full())
        self.assertFalse(self.large_queue.is_full())

    def test_append_and_serve(self):
        for queue in self.queues:
            nitems = self.ROOMY
            for i in range(nitems):
                queue.append(i)
            for i in range(nitems):
                self.assertEqual(queue.serve(), i)

    def test_clear(self):
        for queue in self.queues:
            queue.clear()
            self.assertEqual(len(queue), 0)
            self.assertTrue(queue.is_empty())


if __name__ == '__main__':
    test_list = DataStructure.LINEAR
    testtorun = TestQueue()
    suite = unittest.TestLoader().loadTestsFromModule(testtorun)
    unittest.TextTestRunner().run(suite)

    test_list = DataStructure.CIRCULAR
    testtorun = TestQueue()
    suite = unittest.TestLoader().loadTestsFromModule(testtorun)
    unittest.TextTestRunner().run(suite)

    test_list = DataStructure.LINK
    testtorun = TestQueue()
    suite = unittest.TestLoader().loadTestsFromModule(testtorun)
    unittest.TextTestRunner().run(suite)
