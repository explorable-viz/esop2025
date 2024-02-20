# 2. Overview of approach and solution

## 2.2 Related inputs

- [ ] Our second insight is that the graphical setting makes it straightforward to compose reachability in G and its opposite the other way around, producing another provenance query called _related inputs_ (▽△). Fig 2 illustrates related inputs, again using our implementation. Here the user starts from one of the input data sets, expressing interest in the bioenergy capacity of China for 2018 by moving their mouse over the appropriate cell in the table (\figref{related-inputs-main} step 1, green selection). The system generates two further selections in response. First, any scatter plot elements that demand the selected input are given a similar green highlight; here just one point is highlighted, and in fact only the $y$ coordinate of that point (step 2, tooltip).
- [ ] We call this output selection the \emph{mediating output} because of its role in establishing a
connection between otherwise unrelated inputs. Finally, any other inputs demanded by the mediating output
(that were needed to compute the $y$ coordinate of that point) are highlighted in grey (steps 3a and 3b).
(They grey is used to visually distinguish the \emph{answer} to the query from the selection that initiated
the query in the first place.)
- [ ] The result of a related inputs query can be thought of as a unit of comprehension or unit of reuse. It
picks out all the relevant data needed to understand or make use of the original selected input, and it does
so in a way that identifies the common output elements that explain why the inputs are related. Sometimes a
single input is used in many different outputs, or different features of a single output, in which case the
query result can be quite noisy (because lots of inputs turn out to be related); in \secref{} we also show how
selectively projecting away irrelevant parts of the mediating output can refine the query and produce a more
precise answer. (The same approach can be used to discard irrelevant mediating inputs in a related outputs
query to obtain more precise results.)

