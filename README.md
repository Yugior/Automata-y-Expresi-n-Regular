# E1 Implementation of Lexical Analysis (Automaton and Regular Expression)
Samir Baidon Pardo A01705403

## Description
The language choosen for this evidence is the math language, 
more especiffically one in which you can have al possible combinations of abc
although there is a catch as there are three rules to follow

1. It must not have abc
2. It must not have bba
3. It must finish in bc

Seeing as we only have three letters in our language it would be better to use a 
non-deterministic finite automaton (NFA) for this problem, as it can give us more flexibility and links

## Design

Seeing that our language is 
Σ = a,b,c
we will implement an automaton using q states, an automaton, according to Stanford University is a "abstract models of machines that perform computations on an input by moving through a series of states or configurations." (Stanford University,2004)

VERSION 1.0
![Automata evidence 1](https://github.com/Zathiald/automaton/assets/111139805/5dd46a2c-f45b-4341-9380-eff2b9601d73)

This was my fisrt version of the automaton, in this version I was missing the looping at the end, because of it I had finite states that didn't lead to nowhere, so I had to implement that for the future automaton.

VERSION 2.0

![Automaton 2 0](https://github.com/Zathiald/automaton/assets/111139805/4f623609-8fb1-4641-8799-e83b8ad85a8c)

This is the second iteration of the automaton, now with everything it needs in order for it to work and not have finite unconclusive states.

One thing we must take into account is that because of the rules of the automaton we have some states that are not finite and loop themselves because if the sequence has one of the rules then it can't go to the end state.

The automaton works in the following manner:

| Starting State | Input | Final State |
| -------------- | ------| ----------- |
| Q0             | A     | Q1          |
| Q0             | B     | Q4          |
| Q0             | C     | Q0          |
| Q1             | A     | Q1          |
| Q1             | B     | Q2          |
| Q1             | C     | Q0          |
| Q2             | A     | Q1          |
| Q2             | C     | Q3          |
| Q3             | A     | Q3          |
| Q3             | B     | Q3          |
| Q3             | C     | Q3          |
| Q4             | A     | Q1          |
| Q4             | B     | Q5          |
| Q4             | C     | Q7          |
| Q5             | A     | Q6          |
| Q5             | B     | Q4          |
| Q5             | C     | Q7          |
| Q6             | A     | Q6          |
| Q6             | B     | Q6          |
| Q6             | C     | Q6          |
| Q7             | A     | Q1          |
| Q7             | B     | Q4          |
| Q7             | C     | Q0          |


For further implementation are goint to transcribe the automaton to a Regular Expression (R.E):

<strong>^(?!.*abc)(?!.*bba).*bc$</strong>

## Implementation
Now after we have made our automaton we have to translate the progress to a prolog file in order for it to be tested and modified if necessary, what we first need is to implement the relations of the states, we will put them in the next format: 

<strong>transition(initial_state,letter,next_state)</strong>

So for example on the initial state of Q0 if we ingress the letter a then we go to the state Q1, so in prolog it would look like this:

<strong>transition(q0,a,q1)</strong>

So after stablishing all the states we need for prolog to now which is an accepting state, we will create a function called final_state in which we stablish that if it is on the state, then it is true
<strong>final_state(q7)</strong>

Now we create a function to check in order for it to check the automaton, we are going to use a head recursion because we want to go from the beggining all the way to the base case which is our final state, so we will start by creating the base case for our function which we will call automatonCheck
<strong>automatonCheck([], InitialState) :-
    final_state(InitialState).)</strong>
    
On this base case we will take a list and the starting state for the cycle, now for the recurssion we need to recover the automaton again and then check with the new state as the initial, so we plant it like this

<strong>automatonCheck([Symbol | RestofList], InitialState) :-
    transition(InitialState, Symbol, NextState),
    automatonCheck(RestofList, NextState).</strong>

We first make the transition to the next state and we check if we are at the end of the string and at the final state, if not we re do the automaton check with the next state and letter and it will end once we get q7 as the final state.

And at the end we will use this function of recover_automaton so we can input the string as a list and initiate it on the q0 state

<strong>recover_automaton(ListtoCheck) :-
    automatonCheck(ListtoCheck, q0).</strong>

The complexity for this system is O(n), that is because our regression system needs to go through the n number of letters in the list input, but it goes through them just one time, giving it it's O(n) complexity.

## Testing
The testing for this automaton is written on the file <strong>automaton_test.pl</strong>, but these were the results for it
![Automaton testing complete](https://github.com/Zathiald/automaton/assets/111139805/aeaa37f4-d924-4965-8690-beae39e9e860)

## Other Implementations
There are lenguages like Python,Java or Scala that could let me implement different algorithms and test them thoroughly and automatically.

For example Python, in order to implement it, according to Professor Thorsten Altenkirch of the University of Nottingham, python is a more open language in which you need to specify to the file what you are trying to do before even beggining to code. Although there are now python libraries such as automaton, this still need to be defined before starting to program. Here is an example of just the definition for an automaton in python:

``` python
from automaton import machines
m = machines.FiniteMachine()
m.add_state('up')
m.add_state('down')
m.add_transition('down', 'up', 'jump')
m.add_transition('up', 'down', 'fall')
m.default_start_state = 'down'
print(m.pformat())
```

The difference between implementing an automaton between python and prolog is that prolog is designed in order to analyze languages and logic, so using prolog is the most efficient way to secure a good language analysis.

Another option would be to use a Turing machine instead of an automaton, the Stanford Encyclopedia of Philosophy describes Turing machine as "simple abstract computational devices intended to help investigate the extent and limitations of what can be computed."(Stanford Encylopedia, 2018), the main difference between an automaton and a turing machine is that Turing machines are non-limited, meaning that our sequence could grow more and more and not have a limit.

However this turing machines often scalate more and more and for this tipe of problem, which is more simple in comparison, a Turing machine would take more time to analyze and implement, rather than just using an automaton which is simpler and more efficient.

## References

Academy, E. (2023, August 2). What is the main difference between linear bounded automata and Turing machines? - EITCA Academy. EITCA Academy. https://eitca.org/cybersecurity/eitc-is-cctf-computational-complexity-theory-fundamentals/decidability/linear-bound-automata/examination-review-linear-bound-automata/what-is-the-main-difference-between-linear-bounded-automata-and-turing-machines/ 

Basics of Automata Theory. (n.d.). https://cs.stanford.edu/people/eroberts/courses/soco/projects/2004-05/automata-theory/basics.html

Computerphile. (2023, March 16). Automata & Python - Computerphile [Video]. YouTube. https://www.youtube.com/watch?v=32bC33nJR3A

Examples — automaton 3.3.0.dev12 documentation. (n.d.). https://docs.openstack.org/automaton/latest/user/examples.html 

Turing Machines (Stanford Encyclopedia of Philosophy). (2018, September 24). https://plato.stanford.edu/entries/turing-machine/





