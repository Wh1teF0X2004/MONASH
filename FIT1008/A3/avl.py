""" AVL Tree implemented on top of the standard BST.
    All functions, unless stated otherwise, have a constant best / worst case complexity of O(1).
"""

__author__ = 'Alexey Ignatiev, with edits by Jackson Goerner'
__docformat__ = 'reStructuredText'

from bst import BinarySearchTree
from typing import TypeVar, Generic, List
from node import AVLTreeNode, TreeNode

K = TypeVar('K')
I = TypeVar('I')


class AVLTree(BinarySearchTree, Generic[K, I]):
    """ Self-balancing binary search tree using rebalancing by sub-tree
        rotations of Adelson-Velsky and Landis (AVL).
    """

    def __init__(self) -> None:
        """
            Initialises an empty Binary Search Tree
            :complexity: O(1)
        """

        BinarySearchTree.__init__(self)

    def get_height(self, current: AVLTreeNode) -> int:
        """
            Get the height of a node. Return current.height if current is
            not None. Otherwise, return 0.
            :complexity: O(1)
        """

        if current is not None:
            return current.height
        return 0

    def get_balance(self, current: AVLTreeNode) -> int:
        """
            Compute the balance factor for the current sub-tree as the value
            (right.height - left.height). If current is None, return 0.
            :complexity: O(1)
        """

        if current is None:
            return 0
        return self.get_height(current.right) - self.get_height(current.left)

    def update_height(self, current: AVLTreeNode) -> int:
        """ Update height of current node using maximum of height left and right subtree,
            and increment by 1
            :complexity: O(1), constant time operation
        """

        return 1 + max(self.get_height(current.left), self.get_height(current.right))

    def insert_aux(self, current: AVLTreeNode, key: K, item: I = None) -> AVLTreeNode:
        """
            Attempts to insert an item into the tree, it uses the Key to insert it
            :complexity: Best = Worst = O(M*log N)*(Comp< + Comp>), as AVL tree is always balance.
                         O(M) is the complexity of rebalance() function,
                         multiply by O(log N), where N is the total number of nodes in AVL tree,
                         multiply by cost of comparison (> and <)
        """

        if not current:
            return AVLTreeNode(key)  # base case

        # convergence
        elif key < current.key:
            current.left = self.insert_aux(current.left, key, item)
        else:
            current.right = self.insert_aux(current.right, key, item)

        # update height, 1 + maximum height of left subtree and right subtree
        current.height = self.update_height(current)

        # rebalance and return new root of the subtree rooted at current
        root = self.rebalance(current)
        return root

    def delete_aux(self, current: AVLTreeNode, key: K) -> AVLTreeNode:
        """
            Attempts to delete an item from the tree, it uses the Key to
            determine the node to delete.
            :complexity: Best = Worst = O(M*log N)*(Comp< + Comp>), as AVL tree is always balance.
                         O(M) is the complexity of self.is_leaf(), self.get_successor(), self.update_height() and self.rebalance() function,
                         multiply by O(log N), where N is the total number of nodes in AVL tree,
                         multiply by cost of comparison (> and <)
        """

        # base case
        if not current:
            return current
        elif key < current.key:  # target key is lesser than current key
            # continue searching in left subtree
            current.left = self.delete_aux(current.left, key)
        elif key > current.key:  # target key is greater than current key
            # continue searching in right subtree
            current.right = self.delete_aux(current.right, key)

        else:  # key is found, perform actual deletion
            # if current is a leaf node
            if self.is_leaf(current):
                self.length -= 1
                return None

            # if current only has right node
            elif current.left is None:
                self.length -= 1
                return current.right

            # if current only has left node
            elif current.right is None:
                self.length -= 1
                return current.left

            # most of the case: find a successor and delete it
            succ = self.get_successor(current)

            # set current's reference to the child, bypassing the target node and delete it
            current.key = succ.key
            current.item = succ.item
            current.right = self.delete_aux(current.right, succ.key)

        # update height of current node
        current.height = self.update_height(current)

        # rebalancing
        self.rebalance(current)
        return current

    def left_rotate(self, current: AVLTreeNode) -> AVLTreeNode:
        """
            Perform left rotation of the sub-tree.
            Right child of the current node, i.e. of the root of the target
            sub-tree, should become the new root of the sub-tree.
            returns the new root of the subtree.
            Example:

                 current                                       child
                /       \                                      /   \
            l-tree     child           -------->        current     r-tree
                      /     \                           /     \
                 center     r-tree                 l-tree     center

            :complexity: O(1), constant time operations
        """

        # Explanation (using the same naming as in the docstring):
        # Step 1: if child has a left subtree (center), assign left subtree (centre) as the right child of current
        # Step 2: if current has no parent, assign child as the root of the tree
        # Step 3: elif current is the left node of its parent, make child as the left node of current
        # Step 4: else, assign child as the right child of the parent of current
        # Step 5: make child as the parent of current

        # save current left and right node
        child = current.right
        centre = child.left

        # perform rotation
        child.left = current
        current.right = centre

        # update height of current
        current.height = self.update_height(current)

        # update height of child
        child.height = self.update_height(child)

        # return new root of the subtree rooted at current
        return child

    def right_rotate(self, current: AVLTreeNode) -> AVLTreeNode:
        """
            Perform right rotation of the sub-tree.
            Left child of the current node, i.e. of the root of the target
            sub-tree, should become the new root of the sub-tree.
            returns the new root of the subtree.
            Example:

                       current                                child
                      /       \                              /     \
                  child       r-tree     --------->     l-tree     current
                 /     \                                           /     \
            l-tree     center                                 center     r-tree

            :complexity: O(1), constant time operations
        """

        # Explanation (using the same naming as in the docstring):
        # Step 1: if child has right subtree (center), assign current as the parent of the right subtree (center)
        # Step 2: if current has no parent, assign x as the root of the tree
        # Step 3: elif current is the left child of its parent, make child as the right child of current's parent
        # Step 4: else, assign child as the left child of current's parent
        # Step 5: make child as parent of current

        # save current left and right node
        child = current.left
        center = child.right

        # perform rotation
        child.right = current
        current.left = center

        # update height of current
        current.height = self.update_height(current)

        # update height of child
        child.height = self.update_height(child)

        # return new root of the subtree rooted at current
        return child

    def rebalance(self, current: AVLTreeNode) -> AVLTreeNode:
        """ Compute the balance of the current node.
            Do rebalancing of the sub-tree of this node if necessary.
            Rebalancing should be done either by:
            - one left rotate
            - one right rotate
            - a combination of left + right rotate
            - a combination of right + left rotate
            returns the new root of the subtree.
            :complexity: Best = O(1), when AVL tree is already balanced,
                         Worst = O(N), when AVL tree need to be rebalanced,
                         where N is the complexity of self.left_rotate() and self.right_rotate()
        """

        # left heavy, height of left subtree is greater than that of right subtree
        if self.get_balance(current) >= 2:
            child = current.right

            if self.get_height(child.left) > self.get_height(child.right): # perform right-left rotation
                current.right = self.right_rotate(child)

            # else, perform only left rotation
            return self.left_rotate(current)

        # right heavy, height of right subtree is greater than that of left subtree
        if self.get_balance(current) <= -2:
            child = current.left

            if self.get_height(child.right) > self.get_height(child.left): # perform left-right rotation
                current.left = self.left_rotate(child)

            # else, perform only right rotation
            return self.right_rotate(current)

        # return new root
        return current

    def range_between(self, i: int, j: int) -> list:
        """
        Returns a sorted list of all elements in the tree between the ith and jth indices, inclusive.

        :complexity: O(N), where N is the time complexity for range_between_aux() function
        """
        return self.range_between_aux(self.root, i, j, [])

    def range_between_aux(self, current: AVLTreeNode, i: int, j: int, ret_lst: list[K]) -> list:
        """
        Returns a sorted list of all elements in the tree between the ith and jth indices, inclusive.

        :complexity: Best = Worst = O(j - 1 + log(N)), where N is the total number of nodes in the tree
        """

        # return when hitting a leaf node
        if current is None:
            return ret_lst

        # using inorder traversal
        # Step 1: left subtree
        if current.key > i+1:
            self.range_between_aux(current.left, i, j, ret_lst)

        # Step 2: root
        # if current key is within the range, append to ret_list
        if i+1 <= current.key <= j+1:
            ret_lst.append(current.key)

        # Step 3: right subtree
        if current.key < j+1:
            self.range_between_aux(current.right, i, j, ret_lst)

        return ret_lst
