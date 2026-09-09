# Compute figure for trends in README length
# Notes on what was applied per your answers:
#   - Searched recursively under each 1*/2* numbered subdir, keeping only the shallowest readme-named file (PDF/MD/TXT; DOCX excluded),
#     with name matching broadened to catch read_me, read-me, Read Me, README_new, etc.
#   - 7 numbered subdirs had no qualifying readme (docx-only, or an unsupported format like .rtf/.html, or nothing at all) and were
#     omitted: aearep-8329/251583, aearep-8541/240508-author-provided, aearep-8902, aearep-8928, aearep-8934, aearep-8948, aearep-9133.
#   - Excluded macOS AppleDouble sidecar files (._README.md) that showed up alongside real readmes.
#   - pages is blank for .md/.txt readmes (11 txt, 8 md); PDF pages come from pdfinfo, word counts from pdftotext (naive whitespace split)
#     or plain-text read for md/txt.
#   - aearep dirs with multiple numbered subdirectories (e.g. 8329, 8541, 8673, 8869) each get their own row.


# Read the "readme_page_word_counts.csv", average by 20 aearep-* numbers in existing order (just chunk each group of 20, based on row number) and do a histogram of the word counts, and of the page numbers. label each data point with the lowest aearep-* number (strip the aearep- prefix)

library(ggplot2)

# --- Load and chunk -----------------------------------------------------
readmes <- read.csv(here::here("presentation",'readme_page_word_counts.csv'),
                     stringsAsFactors = FALSE) |>
            # drop if aearep-1636 or aearep-4802
            subset(!(aearep %in% c("aearep-1636", "aearep-4802")))

# aearep number without the prefix, as an integer
readmes$aearep_num <- as.integer(sub("^aearep-", "", readmes$aearep))

# chunk each group of 20 rows, in existing order
readmes$chunk <- ((seq_len(nrow(readmes)) - 1) %/% 20) + 1

chunks <- do.call(rbind, lapply(split(readmes, readmes$chunk), function(d) {
  data.frame(
    chunk      = d$chunk[1],
    label      = as.character(min(d$aearep_num)),
    n          = nrow(d),
    mean_words = mean(d$words, na.rm = TRUE),
    mean_pages = mean(d$pages, na.rm = TRUE),
    n_pages    = sum(!is.na(d$pages))
  )
}))
# flag any trailing partial group so it is not read as comparable
chunks$label <- ifelse(chunks$n < 20, paste0(chunks$label, "\n(n=", chunks$n, ")"),
                       chunks$label)
chunks$label <- factor(chunks$label, levels = chunks$label[order(chunks$chunk)])

# long form so both measures share one figure
plotdata <- rbind(
  data.frame(label = chunks$label, chunk = chunks$chunk,
             measure = "Mean words per README", value = chunks$mean_words),
  data.frame(label = chunks$label, chunk = chunks$chunk,
             measure = "Mean pages per README (PDF only)", value = chunks$mean_pages)
)
plotdata$measure <- factor(plotdata$measure,
                           levels = c("Mean words per README",
                                      "Mean pages per README (PDF only)"))

# --- Figure -------------------------------------------------------------
fig <- ggplot(plotdata, aes(x = label, y = value, fill = measure)) +
  geom_col(width = 0.7, na.rm = TRUE) +
  geom_text(aes(label = round(value, 1)), vjust = -0.5,
            size = 3.2, colour = "grey25", na.rm = TRUE) +
  geom_text(data = subset(plotdata, is.na(value)),
            aes(y = 0, label = "no PDF readmes"), vjust = -0.5,
            size = 3, colour = "grey55", inherit.aes = TRUE) +
  facet_wrap(~ measure, ncol = 1, scales = "free_y") +
  scale_fill_manual(values = c("Mean words per README"            = "#eb7826",
                               "Mean pages per README (PDF only)" = "#5a9dd6"),
                    guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title    = "README length over time",
    subtitle = "Averages over successive groups of 20 replication packages, in submission order",
    x = "in order of receipt",
    y = NULL
  ) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor   = element_blank(),
    panel.grid.major.y = element_line(colour = "grey90"),
    strip.text         = element_text(hjust = 0, face = "bold", colour = "grey20"),
    plot.title         = element_text(face = "bold"),
    plot.subtitle      = element_text(colour = "grey35"),
    axis.title.x       = element_text(colour = "grey35", margin = margin(t = 8))
  )

ggsave(here::here("presentation", "images", "length-of-readmes.png"), fig, width = 9, height = 6, dpi = 200, bg = "white")

#print(chunks)
