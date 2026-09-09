## B - Data provenance

::::{.columns}
:::{.column width="50%"}

![Pillar B](images/pillars-diagram-b.png)
:::

:::{.column width="50%"}

- What if an LLM invents data? Data existence?
- Robots entering data
- Modern methods of provenance assurance, and their limits

:::
::::


## Who is this person? (2)

![2](images/aidan-toner-rodgers-cropped.png)

## Aidan Toner-Rodgers

![2](images/aidan-toner-rodgers.jpeg)

## Maybe you've heard about him


::::{.columns}  

::: {.column width="50%"}

![ECB speech](images/aidan-toner-rodgers-ecb-speech.png)

::: 
::: {.column width="50%"}

["AI-assisted researchers discover 44% more materials, resulting in a 39% increase in patent filings."](https://www.economist.com/finance-and-economics/2025/05/22/what-the-failure-of-a-superstar-student-reveals-about-economics)

:::
::::

## Now {.smaller}


::::{.columns}  

::: {.column width="10%"}
::: 
::: {.column width="80%"}
"MIT now declares “**no confidence in the provenance**, reliability or validity of the data and...in the veracity of the research”. Mr Toner-Rodgers’s paper has been *withdrawn* from the pre-print repository on which it first appeared [arXiv]; ... The lab at the heart of his findings remains **unknown**." 

:::
::: {.column width="10%"}
:::
::::

# How can we know that a data source is reliably obtained?

## Technical means

- Data publisher adds **checksums**
- User adds **checksums** (chaining verification)
- Human-moderated or automated verification verifies checksums

## Human means

- Data Editor connects with data publisher
  - Routinely done for "unnamed" data sources under NDA!
- Replicators (see *I4R*) 
  - re-obtain data from claimed source, verify

## You don't

- Replication does not require that data provenance be verified - it may *collect new data*
  - Availability of survey/experiment data
  - Availability of alternate sources