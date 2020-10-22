# An R script that uses `knitr::spin()` to create multiple different
# output reports based on `spin_example.R` and save them to `outputs/`

# Check required packages -----------------------------------------------------
if (!require("knitr")) {
  stop("The knitr package is needed.")
}


# Produce a default html output with knitr::spin() ----------------------------
knitr::spin("src/spin_example.R")
file.rename("spin_example.html", "outputs/ex_01_spin_default.html")



# Just spin() to Rmd, do not render to html -----------------------------------
knitr::spin("src/spin_example.R", knit = FALSE)

# Now create an ugly but minimalish HTML output from the Rmd ------------------
knitr::knit2html(
  input = "src/spin_example.Rmd",
  output = "outputs/ex_02_spin_minimalish.html",
  extensions = "fenced_code",
  options = "base64_images",
  stylesheet = ""
)


# Produce html output with knit and custom css, with external dependency ------
# Note that the content of the external resource (@import row 153 of the css)
# is *not* pasted into the HTML output, the import is pasted as-is:
knitr::spin("src/spin_example.R", knit = FALSE)
knitr::knit2html(
  input = "src/spin_example.Rmd",
  output = "outputs/ex_03_spin_air_css.html",
  extensions = "fenced_code",
  options = "base64_images",
  stylesheet = "css/air.css"
)


# Produce html output with knit and custom css, /wo external dependency -------
# Full credit for the CSS used goes to: 
# https://github.com/markdowncss/air
knitr::spin("src/spin_example.R", knit = FALSE)
knitr::knit2html(
  input = "src/spin_example.Rmd",
  output = "outputs/ex_04_spin_air_css_light.html",
  extensions = "fenced_code",
  options = "base64_images",
  stylesheet = "css/air_light.css"
)

# Cleanup ---------------------------------------------------------------------
file.remove("src/spin_example.Rmd", "spin_example.md")
unlink("figure/", recursive = TRUE)

