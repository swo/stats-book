# Statistical inference

The typical approach in statistics is to teach frequentist inference
---things like $t$-tests--- before Bayesian statistics. The reason is
that Bayesian statistics is mathematically more complex, it was
developed after frequentist statistics, and is more confusing. However,
the reason Bayesian statistics is confusing is because inference is
confusing, and pretending that it is not leads to some critical
misunderstandings about statistical inference.

Rather than hide the fact that inference is confusing, I introduce the
concept of inference in this chapter, contrasting frequentist and
Bayesian inference, and showing very little math.

Having dealt with inference's limitations, I will go on to the nuts and
bolts of "doing" statistical inference. But read this chapter first, so
you don't hold on to some critical misconceptions.

## Inference is philosophically confusing

*Inference* means taking some concrete cases and making a broader
conclusion. Inference is always contrasted with deduction, which does
the opposite, reasoning from broad rules to particular circumstances.
The classic example of deduction is: all humans are mortal, Socrates is
human, therefore Socrates is mortal. We reason from a general rule about
mortality to a particular case of Socrates's mortality.

Inference goes from particular to general. For most of humanity's
history, we did this without worrying. Plato felt confident asserting
that all humans are mortal because he had never heard a counterexample:
because every human he observed or had heard about was mortal, he
reasoned that *every* human ---every one who ever lived and every one
which will live--- is mortal.

[inverse probability]{.mark}

Thousands of years after Plato, the philosopher David Hume questioned
this kind of logic. He said, "Sure, every human *so far* has been
mortal. But that's not proof positive that *no* human will ever be
immortal." We today are very comfortable to say that "correlation does
not prove causation", but Hume took that logic to its extreme: if
correlation does not prove causation, then seeing that every single one
of billions of human who lived is mortal does not prove that the next
human is guaranteed to be mortal. If we can't even prove that humans are
mortal, then how do we conclude anything?[^1]

This may seem abstract, but I want to point out that inference is
philosophically confusing so that you will not be surprised to hear that
inferential statistics is confusing!

## Null hypotheses are our imperfect approach to frequentist inference

[1. Freq. stats cannot adress states of nature. 2. But we want
$P[\theta|X]$. Waht to do? 3. Trick is to use $P[X|\theta]$ to make
p-values and supplement that with CIs.]{.mark}

We resolve the paradox of using frequentist statistics to make
inferences about the character of the universe ---things which do not
have frequencies--- using a trick called a *null hypothesis*. Rather
than asking, "Given the data, what's the probability that my hypothesis
is correct?", we construct an uninteresting, null hypothesis and then
reverse the question, "Imagine this null hypothesis were true. Then
what's the probability of getting data like mine?"

For example, if I think you're cheating in a card game, the natural
question is to ask, "Given the cards I've seen you draw, what's the
probability that you're cheating?" The point of a null hypothesis is to
flip it around: "Imagine that you were playing fair. What's the
probability you would be winning this month?"

To emphasize how these two questions are different, I'll introduce the
typical mathematical symbols for these concepts: $\theta$ is the event
that the null hypothesis is correct, and $X$ is the event that I
observed the data I did. Our natural inclination is to ask about
$\prob{\theta | X}$. But in frequentist statistics, $\prob{\theta}$ is
nonsense, either you are cheating or you are not. So we flip the
question, instead asking about $\prob{X | \theta}$.

In the previous section, we replaced an induction question with a
deduction question: $\prob{\theta | X}$ reasons from the specific $X$ to
the general $\theta$, while $\prob{X | \theta}$ reasons from the general
$\theta$ to the specific $X$. In other words, we replaced the hard,
inference question (are you cheating? are all human mortal?) with the
easier, deduction question: if you were not cheating, how likely are you
to have gotten such lucky hands?

It's tempting to equate $\prob{\theta | X}$ and $\prob{X | \theta}$.
This is called the *prosecutor's fallacy*. Imagine there was a crime,
and the perpetrator left type AB negative blood at the scene. A person
with type AB negative blood is accused of the crime. The prosecutor will
say, "Only 1% of Americans have type AB negative blood. So if this
person were innocent, there is only a 1% chance that type AB negative
blood would be found at the crime site. Thus, there is a 1% chance that
this person is innocent."

The prosecutor did a bait-and-switch. The null hypothesis $\theta$ is
that the accused is innocent, and some random American committed the
crime. The data $X$ is having found AB negative blood. The prosecutor
accurately concluded that $\prob{X | \theta} = 1\%$. But then they
fallaciously concluded that $\prob{\theta | X} = 1\%$.

If it's not obvious that this argument is fallacious, consider the more
general proposition that $\prob{A | B}$ equals $\prob{B | A}$. For
example, if it is snowing, what's the probability that the temperature
is below freezing? Basically 100%. But if it is below freezing, what is
the probability that it is snowing? Clearly much less than 100%. But
clearly the two concepts have something to do with one another, which we
will examine in the next section.

## Bayes's theorem is the only way to ask about whether your hypothesis is correct

[Move this to a Part IV]{.mark}

The relation between $\prob{X | \theta}$ and $\prob{\theta | X}$ is laid
out in *Bayes's theorem*:
$$\prob{\theta | X} = \frac{\prob{X | \theta} \prob{\theta}}{\prob{X}}.$$
This result follows almost immediately from the definition of
conditional probability, laid out in chapter
[\[chapter:probability\]](#chapter:probability){reference-type="ref"
reference="chapter:probability"}.

Note that there are four terms in Bayes's theorem:

- $\prob{\theta | X}$: Given the data, what's the probability that
  hypothesis is true? This is what the court is trying to figure out:
  given the evidence, what's the probability that the accused is
  innocent (or guilty)?

- $\prob{X | \theta}$: Given the hypothesis, or null hypothesis, what's
  the probability of observing the data we did?[^2]

- $\prob{X}$: What's the probability of observing this data? In this
  case, this is essentially the same as $\prob{X | \theta}$.

- $\prob{\theta}$: What's the probability, not considering the evidence,
  that this person is innocent?

In the courtroom example, $\prob{X}$ is the probability that, if we
walked into a random courtroom trying a case with blood evidence, that
the blood would be of type AB negative. If 1% of Americans have type AB
negative blood, and people of different blood types commit crimes at the
same rates, then $\prob{X} = 1\%$.

In this example, $\prob{X | \theta}$ is very similar to $\prob{X}$. Say
there are 300 million Americans, of whom 1%, or 3 million, have type AB
negative blood. If the accused is innocent, there are 299,999,999 type
AB negative people left, so the probability of observing type AB
negative blood is
$(3\text{ million} - 1) / (300\text{ million}) = 1\% - 1 / (300\text{ million})$,
or just slightly smaller than 1%.

So, plugging in $\prob{X}$ and $\prob{X | \theta}$, which we computed
based on our knowledge about blood types, we can conclude that
$\prob{\theta | X}$ is just slightly smaller than $\prob{\theta}$. In
other words, the probability that the accused is innocent given the
blood evidence is only very slightly smaller than the probability that
they are innocent when not considering that evidence. Without any
evidence, the probability that some random accused person happens to be
the perpetrator is small, say 1 in 300 million. In other words, the
prosecutor, if they have only the blood evidence, has a very bad case.

## Bayes's theorem is about updating, not defining, probabilities

In the example from the previous section, I showed that we can use data
to compute the relationship between $\prob{\theta}$, the probability
that a hypothesis is correct not considering the data, and
$\prob{\theta | X}$, the probability that a hypothesis is correct given
the data. In the language of Bayesian statistics, $\prob{\theta}$ is
called the *prior probability* of $\theta$, and $\prob{\theta | X}$ is
the *posterior probability*. In other words, the data "updated" the
prior, pre-data-collection probability.

The blood type example worked because the choice of $\prob{\theta}$ was
pretty clear: if we picked an Amercian at random, what's the chance they
are innocent of this particular crime? (Or, conversely, what's the
chance that a randomly-selected person is the perpretrator?)

In other cases, when $\theta$ is a hypothesis, $\prob{\theta}$ becomes
extremely problematic. Take the Socrates example: what's the
probability, if you hadn't observed the lives and deaths of any human,
that all humans are mortal? Or take a science example: if Einstein had
showed you his general theory of relativity, but neither you nor he had
ever observed any experimental evidence or astronomical data, what would
you say is the prior, pre-data-collection probability that his data is
correct?

As I discussed above, it only makes sense to assign probability to
hypotheses in a Bayesian context. It doesn't make sense to ask on what
fraction of replicates of Earth humans are mortal; instead you ask how
confident you are that humans are mortal.

Again, Bayes's theorem, is a perfectly mathematically sound theorem, but
it only *updates* probabilities. Given a prior probability, and the
data, it gives a posterior probability. But it can never tell you the
prior probability. This is why people don't like Bayesian statistics.
How can you put a prior probability on a hypothesis? Do you make a
guess? "Well, Einstein was smart, so that's a plus, but his theory
sounds complicated, so that's a minus, and so I think maybe
fifty-fifty?"

There's no mathematically sound answer to this question because there is
no philosophically sound answer to this question. In other words,
frequentist statistics and Bayesian statistics are both rigorous
mathematical systems, and there is clear link between experimental
science and the proportion-probabilities of frequentist statistics, but
the link betwen Bayesian degree-of-confidence probabilities and what we
have in our heads is not so clear.

Having filled your mind with this philosophical cloud, let's get down to
the nuts and bolts of statistical inference.

[^1]: This argument is usually couched as the ["sunrise
    problem"]{.mark}: given that the sun has risen every day, what's the
    probability it will rise tomorrow? Is that probability *exactly* 1?

[^2]: You may recognize that this wording is the definition of the
    $p$-value. In a way, the point of this chapter is to conceptually
    prepare you to be critical of the $p$-value, and to understand that
    is is *not* $\prob{\theta | X}$.
