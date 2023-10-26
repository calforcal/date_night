# Date Night - A Binary Search Tree

### The Problem
<p>You're working for a movie streaming service that is compiling 'Suggested Movies' for its users. Each Movie has its title, and also a score between 1 and 100. You've been tasked with creating a storage system to read, write, and destroy the 'Suggested Movies' that are given to you.</p>

### The Solution
<p>Since we'll need to access these movies quickly, and the files being retrieved could be quite large - we've built a Binary Search Tree. BST's are a fundamental data structure that are extremely useful when handling larger datasets and information is needed to be retrieved quickly.</p>

## Repo Installation
In your terminal run the following commands to clone the repositories:
          
    git clone git@github.com:calforcal/date_night.git

**Ruby Version**

    ruby 3.2.2

**Installing the Gems Locally**

     bundle install

**Testing the Repositories**

#### To run the full test suite:

<p> **Coverage should be at 100%** </p>

     bundle exec rspec

## BST Functionality

### Initialize a Tree

<details close>

    tree = BinarySearchTree.new

</details>

### Insert

<p>The insert method takes a score, and a movie title - which is used to create a new node within the tree. If the node is inserted, the return value is the level at which the node was inserted.</p>

<details close>

    Input: tree.insert(61, "Max Keebler's Big Move")
      Output: # => 0
    Input: tree.insert(16, "Sharknado")
      Output: # => 1
    Input: tree.insert(92, "Eras Tour the Movie")
      Output: # => 1
    Input: tree.insert(50, "Dunkirk")
      Output: # => 2


                            Tree Shape
                                61
                               /  \
                             16    92
                               \
                                50
    
#### How it works:

<p>

At a high level, the node insertion follows a basic decision making process: If the ```new_node``` , is greater than the ```head_node``` , it is placed on the right side of the tree. If less than - it's placed on the left side of the tree. It moves down the tree following this process, until it finds a node that has room in its ```left_node``` or ```right_node``` .

Digging deeper into my implementation, I have deployed two helper methods that aid in the insert functionality. The method ```place_node``` abstracts away the decision making from the ```insert``` method, deciding when to place the node (when it reaches the bottom of the tree).

Further abstraction takes place within the ```place_node``` by utilizing a ```find_bottom``` method. This method traverses the tree, by comparing nodes, and choosing whether to go deeper left / right - while keeping track of the level as it goes.

Combined, we are able to insert a new node and return the level it was inserted at!
</p>

</details>

### Include?

<p>

The `include?` method takes in a `score` or num, and returns `true` or `false` depending on whether or not a node with that `score` exists within the tree.

</p>

<details close>

    Input: tree.include?(61)
      Output: # => true

    Input: tree.include?(100)
      Output: # => false

#### How it works:

<p>

The ```include``` method abstracts most of it's functionality away to another method called ```node_finder```.

```node_finder``` seemed like a very useful method that might be able to be reused elsewhere in the BST. Using recursion, it receives a ```current_node``` and ```num``` - (the score its searching for). If the ```current_node.score``` matches the ```num``` it returns the ```current_node``` otherwise if ```current_node``` is ```nil``` it returns ```nil```. If there are still nodes left to search - the method calls itself, deciding where to go next based on if the score its searching for is greater than or less than the ```current_node.score``` , which continues until it finds the node or reaches the bottom of the tree.

</p>

</details>

### Depth Of

<p>

The `depth_of` method takes in a `score` or num as an argument, and if the tree contains that `score` it returns the `level` of that node, otherwise it returns `nil`.

</p>

<details close>

    Input: tree.depth_of(61)
      Output: # => 0

    Input: tree.depth_of(50)
      Output: # => 2

                            Tree Shape
              Level: 0          61
                               /  \
              Level: 1       16    92
                               \
              Level: 2          50

#### How it works:

<p>

In the ```depth_of``` method - we were actually able to recycle the ```.include?``` method by adding just a few lines of code. We first zero-out the ```@level``` of the tree, in the ```.include?``` method, and then when we search for the node with ```node_finder```, it updates the ```@level``` as it searches!

So in the ```depth_of``` method, if it found the node, we return ```@level``` or if not, we return ```nil```.

</p>

</details>

### Max and Min

<p>

The `max` and `min` methods work the same way but provide opposite values. They take no argument and return either the highest or lowest score, respectively.

</p>

<details close>

    Input: tree.max
      Output: # => { "Eras Tour the Movie" =>92 }

    Input: tree.min
      Output: # => { "Sharknado" =>16 }

#### How it works:

<p>

```.max``` and ```.min``` work the same way - but the inverse of eachother. First, we set the ```@head``` as both the ```current_node``` and ```MIN/MAX``` num. We then make our way to the bottom of the left or right side of the tree to find the most extreme number in either case, and return that. 

</p>

</details>

### Sort

<p>

The `sort` method takes in no arguments. It returns all of the nodes within the tree as an array in the following key/value pair format: `"{ title"=>score }`.

</p>

<details close>

    Input: tree.sort
      Output:
              [{ "Sharknado"=>16 },
               { "Dunkirk"=>50 },
               { "Max Keebler's Big Move"=>61 },
               { "Eras Tour the Movie"=>92 }]

#### How it works:

<p>

The ```sort``` method utilizes a helper method called ```collect_nodes``` to help it retrieve all of the nodes, in order from lowest to highest score.

```collect_nodes``` is where all of the logic for this method is housed - it begins with an empty array, where each node will be 'collected'. If the ```starting_node``` is `nil` it returns, meaning there is no more nodes to check on this branch.

If the node is not `nil`, then it will collect that node in `node_array`. The function will then be called recursively on the `left_node` and `right_node` - the `left_node`'s will be `prepended` since each `left_node` will be smaller than the previous node. And the opposite for `righr_node`'s, each of those will be `appended` - added to the back of the array, in order to keep them sorted.

Ultimately the array will be returned and as the recursion 'bubbles up' the original function call will hand back all of the nodes it found in one, sorted array.

</p>

</details>

### Load

<p>

The `load` method takes in one argument, a file path to a `.txt` file. It reads the `.txt` file and inserts each line as a node within the tree and returns the number of nodes it inserted.

</p>

<details close>

    # movies.txt sample format:
      34, Hannibal Buress: Comedy Camisado
      63, Meet My Valentine
      22, Experimenter
      84, French Dirty
      41, Love
      10, I Love You Phillip Morris



    Input: tree.load('movies.txt')
      Output: # => 6

                            Tree Shape
                                34
                               /  \
                             22    63
                            /  \     \
                          10    41    84

#### How it works:

<p>

The `load` method is essentially the bulk version of `insert`. It receives the path a `.txt` file, reads each line of the file, and performs some basic functionality to format each line.

One its formatted in a way that can be iterated over - each `score` / `title` pair is insterted using the `insert` method, only if the score doesn't already exist within the tree.

Finally once all nodes have been inserted - it returns a count of the number of new nodes inserted.

</p>

</details>

<br>
<br>

## Assuming these inputs for the enclosed inputs for the remainder of the examples

    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

                            Tree Shape
                                98
                               /  \
                              58    
                            /    \
                           /      \
                         36        93
                           \       /
                            38   86
                                /
                               69  


### Health

<p>

The `health` method takes in one argument `level`. The return value is each node at that `level`, and with that - it returns two other values signifying the health of the tree:

The first is the number of nodes that are the children of the node returned.

The second is the percentage of nodes that are the child of the returned node.

These metrics are helpful in determing the balance of the tree - i.e is there an equal number of nodes on each side of the tree or has it become unbalanced somewhere.

</p>

<details close>

    Input: tree.health(0)
      Output: [[98, 7, 100]]
    Input: tree.health(1)
      Output: [[58, 6, 85]]
    Input: tree.health(2)
      Output: [[36, 2, 28], [93, 3, 42]]

#### How it works:

<p>

This method has several helper methods implemented in order to abstract away functionality from the main method call. The first action of the `health` method is to get a count of the total number of nodes below a given node. We have called this `count_nodes_below` - which recursively traverses the tree, giving a +1 count to `node_count` each time it finds a non-nil node.

This method was made to accept any node in the tree and count the nodes below it, so that it could be used to count every node in tree (starting with the `head`) and also a node in the middle of the tree.

The next helper method utilized is `get_nodes_at_level`. This method uses the given input of level, and traverses the tree recursively, only returning the nodes when the `target_level` equals the `start_level`. A guard statement checks if the `start_level` is greater than the `target_level` - if it is, the method returns and the recursion for this branch stops. Once the search is completed, we are returned only the nodes from the given `target_level`.

Once we've returned the nodes from a certain level, we `.map` each one into the format required for the return which is the nodes `score`, the number of nodes below it, and the percentage of nodes below it.

</p>

</details>

### Leaves

The `leaves` method takes in no arguments. It returns the number of leaves that are in the tree. A leaf being a node that has neither a `left_node` or a `right_node`.

<details close>

    Input: tree.leaves
      Output: 2

#### How it works:

<p>

The `leaves` method is fairly straight-forward, it utilizes one other helper method the essentially houses all of the functionality.

The `get_leaves` method takes in a starting node, and proceeds to traverse the tree looking for nodes that have a `left_node` and `right_node` of `nil`. When it finds one, it pushes it to a collector array, and then as the recursion bubbles up, all of the leaves are returned.

</p>

</details>

### Height

The `height` method takes in no arguments. It returns the height or depth of the tree. The height is the number of levels in the tree.

<details close>

    Input: tree.height
      Output: 4

#### How it works:

<p>

The `height` method is also fairly simple - it traverses the tree recursively, searching for the end of each branch - and as it does so, it accepts a parameter called `start_level`, which is used to keep track of the level of the nodes it finds at the end of each branch. Once it has collected the end of each branch, it simply returns the maximum numbed, which indicates the height (or depth) of the tree.

</p>

</details>

### Delete

<details close>

    Input: tree.delete(38)
      Output: 38

#### How it works:

<p>

The `delete` method is the most complicated of all, due to its tree restructuring upon deleting a node. There are 3 different cases a tree must consider when it is deleting a node. A node with 0 children, 1 children, or 2 children.

First: the `delete` method employs two helper methods to start the process. `get_node_above` is used to find the parent node of the node we're looking to delete. It recursively searches the tree looking for the `score` of the node it needs to delete. Each time the method is called recursively, we pass the `parent` as an argument to keep track as we go down the levels. When it finds the score, it returns the `parent`.

It the reuses functionality from the `include?` method by using its' helper method - `node_finder`. Which returns us the node that we are looking to delete.

Now we save both the `parent` and the `deletion` node for further use in the process.

**Case 1**
The first case is the simplest - deleting a node with no children. Once we have located the node, we check to ensure it has no children, and then we determine if it is the `left_node` or `right_node` of its parent. We then set the `left_node` or `right_node` of the `parent` to `nil` respectively. Done!

**Case 2**
If we have determined during our check that either the `left_node` OR (emphasis on the or) `right_node` of the `deletion` node is `nil`. We employ a helper method called `one_child_deletion`. It takes the `node_above` and `delete_node` as arguments. First step is saving the `child` we do not want to delete or lose to the garbage collector by misplacing it. We then determine if the `delete_node` was a `left_node` or `right_node` and depending on which - we set the `child` to the `left_node` or `right_node` of the `node_above` (parent). If the node was deleted `true` or `false` is returned so that the main function knows that it should indicate the node was deleted.

**Case 3**
This is the trickiest case of the 3. If we have determined (by process of elimination) that the `deletion` node has 2 children, we employ the `two_child_deletion` helper method. It also takes in the arguments of `node_above` and `delete_node`.

The first decision by the helper method is determining if the `delete_node.score` is `>` OR `<` the `node_above.score`. If it's greater, we find the next smallest score in the tree. We do this be collecting all of the nodes to the left of the `delete_node` and returning the maximum, the `successor`. Since it is the LARGEST from the left side, all nodes to its left will be smaller than the `successor` and since it's from the left side of the `delete_node` - we know all nodes to the right will be greater than the `successor`.

We then find the `successor_parent`, to begin our restructuring. If the `delete_node` is a `right_node`, we set the `successor_parent.right_node` to `successor.right_node` because we want the tree lineage to continue. The `successor_parent.left_node` remains unchanged.

The `node_above.right_node` (above the node we're deleting) then becomes the `successor`. The `successor.left_node` and `successor.right_node` then become the `delete_node` left and right node, respectively.

This process runs exactly the same on when replacing `left_nodes` in the tree. The only difference being that the `node_above.left_node` becoming the `successor` VS the the `right_node` in the above example.

</p>

</details>