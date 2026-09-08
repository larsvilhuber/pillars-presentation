# What can **YOU** do?

## What is this?

![](images/anya-mouse.png)

## Training

::::{.columns}
:::{.column width="50%"}

- Biology students learn key lab techniques
  - Pipetting
  - Capture-recapture of wild animals

:::
:::{.column width="50%"}
:::
::::



## Training

::::{.columns}
:::{.column width="50%"}

- Biology students learn key lab techniques
  - Pipetting
  - Capture-recapture of wild animals

:::
:::{.column width="50%"}
![That's my daughter's hands in there](images/anya-mouse.png)
:::
::::

## **YOU**!

![](images/Gemini_Generated_Image_wdh8jvwdh8jvwdh8.png)

# (BTW...)

When I prompted Gemini to correct the spelling in "Reproducibility", it only made it worse!

![](images/gemini-is-bananas.png)

# Back to the topic

## Generic survey processing

::: {.white-col}
![Generic survey processing](images/xkcd_data_provenance-0.png)
:::

## Generic survey processing

::: {.white-col}
![Generic survey processing](images/xkcd_data_provenance-1.png)
:::

## Requiring transparency in academia

::: {.white-col}
![Generic survey processing](images/xkcd_data_provenance-2.png)
:::

## Verifying transparency in academia

::: {.white-col}
![Generic survey processing](images/xkcd_data_provenance-3.png)
:::

## Verification by journals

- **Provision** (publication of materials) provides transparency
- **Verification** (running the analysis again - computational reproducibility) compensates for *mistrust*/*absence of trust*

## Which journals  {.smaller}

- [American Economic Association](https://www.aeaweb.org/journals/) (8)
- [Econometric Society](https://www.econometricsociety.org/) (3)
- [Canadian Journal of Economics](https://www.economics.ca/cje-home) (1)
- [Royal Economic Society](https://res.org.uk/journals/) (2)
- [Western Economic Association International](https://weai.org/view/EI-Journal-Policies) (1)
- [European Economic Association](http://www.eeassoc.org/journal) (1)
- [Review of Economic Studies](https://www.restud.com/) (1)
- [Journal of the European Economic Association](https://academic.oup.com/jeea) (1)
- [Journal of Political Economy](https://www.journals.uchicago.edu/journals/jpe/about) (3)
- [American Journal of Political Science](https://onlinelibrary.wiley.com/page/journal/15405907/) (1)
- [American Political Science Review](https://www.cambridge.org/core/journals/american-political-science-review) (1)

## Verification by others

::::{.columns}
:::{.column width="50%"}

- Pre-publication: [cascad](https://www.cascad.tech/)

![cascad](images/cascad.png)

:::
:::{.column width="50%"}

- Post-publication: [Data Colada](https://datacolada.org/), [Institute for Replication](https://i4replication.org/)

![I4R](images/i4r.png)

:::
::::

## Verification by institutions

::::{.columns}
:::{.column width="50%"}

- [World Bank](https://reproducibility.worldbank.org/index.php/home)[^jones]

![World Bank RRR](images/worldbank-rrr.png)

[^jones]: Jones, M. (2024). Introducing Reproducible Research Standards at the World Bank. Harvard Data Science Review, 6(4). <https://doi.org/10.1162/99608f92.21328ce3>

:::
:::{.column width="50%"}

:::
::::


## Verification by you


::::{.columns}
:::{.column width="50%"}

![](images/Gemini_Generated_Image_wdh8jvwdh8jvwdh8.png)

:::
:::{.column width="50%"}

- Toner-Rodgers was caught b/c others scrutinized his work
  - Investigated the statistics (not too fishy)
  - Investigated the sources (huh?)
  - Investigated the coherence of the paper (much harder)

:::
::::

## Taking it a step further

::: {.white-col}
![Survey flow](images/xkcd_data_provenance-5.png)
:::

## Taking it a step further

- Has been discussed by authors behind Data Colada
- Survey tool provider (Qualtrics, etc.) exports data, posts **checksum**
- Survey tool provider exports data only to institution directly into trusted repository, researchers obtain data from there (with privacy protections)
- Researcher can verify **checksum**

## Does not work yet


## What if you could verify the file?


```{r checksum, include=TRUE,echo=TRUE}
# compute checksum of the file
tools::md5sum(here::here("presentation","SP500.csv"))
```

::::{.columns}
:::{.column width="50%"}


::: {.white-col}
![Certified survey processing](images/xkcd_data_provenance-10.jpg)
:::


:::
:::{.column width="50%"}

![Not yet available!](images/sp500-fred_md5.png)

:::
::::

## Does not prevent all fraud

::::{.columns}
:::{.column width="25%"}
:::
:::{.column width="50%"}

[Toronto researcher loses Ph.D.](https://retractionwatch.com/2024/04/26/psychology-researcher-loses-phd-after-allegedly-using-husband-in-study-and-making-up-data/)

![Toronto case](images/toronto-psychology-loses-phd.png)

:::
:::{.column width="25%"}

:::
::::

## How to document the full process?

::: {.white-col}
![Survey flow](images/xkcd_data_provenance-7.png)
:::

## How to document the full process?

- Identify all sources - very precisely!
- Document all processing steps - using tools you are learning here!
- Transparent about your process - show your code!
- Expect critique (if not criticism) - embrace it!


## Churchill said...

::::{.columns}
::: {.column width="50%"}
![](images/Winston-Churchill-Yousuf-Karsh-1941.jpg)
:::
::: {.column width="50%"}
"**Do not trust any statistics you did not fake yourself.**"
:::
::::

## Or did he...

::::{.columns}
::: {.column width="50%"}
![](images/Winston-Churchill-Yousuf-Karsh-1941-really.png)
:::
::: {.column width="50%"}
"No, of course, the British Prime Minister ... **never claimed such nonsense**. But putting his name in front of a quote gives it a more solemn, more imposing, more definitive appearance." [[Source](https://winstonchurchill.hillsdale.edu/fake-churchill-quote/)]
:::
::::

## A sketch: Transparency Certified

<https://transparency-certified.github.io/>

[![Transparency Certified](images/trace.png)](https://transparency-certified.github.io/)


## Work in progress

- Working with [cascad](https://www.cascad.tech/), several [INEXDA](https://inexda.org) members, and others
- Relying on external certification of data inputs (data catalogs with metadata, checksums)

## Who is this person? (3)


::::{.columns}  

::: {.column width="50%"}

![](images/alp-simsek-yale-cropped.png)

::: 
::: {.column width="50%"}

:::
::::

## Who is this person? (3)


::::{.columns}  

::: {.column width="50%"}

![](images/alp-simsek-yale.png)

::: 
::: {.column width="50%"}

[Alp Simsek](https://som.yale.edu/faculty-research/faculty-directory/alp-simsek), one of ...
:::
::::


## Transparency is the norm


::::{.columns}  

::: {.column width="50%"}

![](images/Gemini_Generated_Image_bj8lf3bj8lf3bj8l.png)

::: 
::: {.column width="50%"}

[nearly 5,000 authors](https://aeadataeditor.github.io/aea-cumulative-summary/impacts_of_aea_data_editing.html#authors-reached) who have had [their work](https://doi.org/10.3886/E159301V1) verified by the AEA Data Editor and team.

:::
::::

## You can do it, too!

::::{.columns}
::: {.column width="20%"}
:::
::: {.column width="60%"}
![You can do it, too!](images/Gemini_Generated_Image_wdh8jvwdh8jvwdh8.png)
:::
::: {.column width="20%"}
:::
::::




