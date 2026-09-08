# Challenges

## A - Data quality

::::{.columns}
:::{.column width="50%"}

![Pillar A](images/pillars-diagram-a.png)
:::

:::{.column width="50%"}

- LLM-generated data is popular
- Draw from an inference distribution
  - Important: Variability matters (Coqueret et al, 2026)
  - Correct way of handling variability: equivalent to multiple imputation

:::
::::

## Coqueret et al (2026) {.smaller}

**Randomness in Large Language Models: What Researchers Need to Know (and Report)**

Coqueret, Llull, Oswald, Pérignon, Scheuch, Vilhuber (2026, working paper)

- "Temperature = 0" does **not** make a commercial API deterministic
  - silent model updates behind unchanged model names
  - floating-point rounding that depends on server load, batching, hardware
  - expert routing (mixture-of-experts) depends on *other users'* requests
- Seeds only help if prompt, model, decoding, sampling implementation **and serving environment** are all fixed
- Several frontier "reasoning" models have **removed** user-settable temperature altogether

## Coqueret et al (2026): is your result robust? {.smaller}

- One sentiment-classification task over corporate filings
- Same prompt, same model, repeated **200 times**
- Distribution of downstream regression test statistics is wide enough that a non-trivial share of runs cross conventional significance thresholds — and others do not
- A researcher who queries the model **once** has drawn a single realization from that distribution

::: {.img-placeholder}
IMAGE PLACEHOLDER: figure from Coqueret et al (2026) — distribution of test statistics across the 200 runs
:::

## Coqueret et al (2026): what to report {.smaller}

- An itemized reporting standard:
  - what belongs in the **paper** vs. what belongs in the **replication package**
  - what is essentially **costless** to provide vs. what requires additional work
- Be precise about all parameters of the generation process
- Store raw model inputs and outputs of every run (privacy concerns are real!)
- Document the observed variability for future replicators

## LLM-generated data and Multiple Imputation

## Inherent variability

- LLMs are **probabilistic** by design, so some variability is expected
- "Temperature" is meant to control this, but imperfect

> Is your result robust?

## LLM output as a Multiple Imputation problem {.smaller}

:::: {.columns}

::: {.column width="50%"}
- Rubin (1993, *J. Official Statistics*) is credited with one of the first formalizations of multiple imputation
- Often used for privacy protection, but also missing data
- See Reiter (2004, *Survey Methodology*; 2005, *J. Stat. Plan. Inference*) for inference rules
:::
::: {.column width="50%"}
![](images/rubin1993.png)
:::
::::

## LLM output as a Multiple Imputation problem {auto-animate=true transition=fade .smaller}

**Recommendation**

:::: {.columns}
::: {.column width="50%"}
- Run the LLM (query) multiple times (e.g., 10 times) -> $D^*_m, m=1,...,10$
:::
::: {.column width="50%"}

:::
::::

## LLM output as a Multiple Imputation problem {auto-animate=true transition=fade .smaller}

**Recommendation**

:::: {.columns}
::: {.column width="50%"}
- Run the downstream analysis for each $D^*_m$ -> ${q}_m, v_m, m=1,...,10$
:::
::: {.column width="50%"}

:::
::::

## LLM output as a Multiple Imputation problem {auto-animate=true transition=fade .smaller}

**Recommendation**

:::: {.columns}
::: {.column width="50%"}
- Use multiple imputation rules (Rubin, Reiter, etc.) to report
  - sampling variability inherent in the underlying data $D^*$: $\bar{v}$
  - variability due to the variability in the LLM output $b$
:::
::: {.column width="50%"}

![](images/reiter2004-formula.png)

:::
::::

## The decomposition is the point {.smaller}

$$\bar{q}_m = \sum_{i=1}^{m} q_i / m, \qquad b_m = \sum_{i=1}^{m} (q_i - \bar{q}_m)^2 / (m-1), \qquad \bar{v}_m = \sum_{i=1}^{m} v_i / m$$

Report $\bar{q}_m$ with variance $T_p = b_m/m + \bar{v}_m$

- $\bar{v}_m$: the sampling variability you would face even with a perfectly deterministic instrument
- $b_m$: the variability **the LLM added**
- A large $b_m$ relative to $\bar{v}_m$ means the result rests on *which draw the author happened to get* — exactly when a replicator should not expect to recover the numbers

## LLM-specific considerations

- Be precise about all the parameters
- Also store outputs from API (but: privacy concerns are real!)
- Document the variability in the output (e.g., by running multiple times)
