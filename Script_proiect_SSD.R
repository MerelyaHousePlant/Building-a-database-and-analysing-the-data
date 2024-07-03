install.packages("lubridate")
install.packages("pdftools")
install.packages("readr")
install.packages("plyr")

id<-1:2000
prenume_barbati <- readLines("prenume_barbati.txt")
prenume_femei <- readLines('prenume_femei.txt')
nume_romanesti <- readLines('nume_romanesti.txt')
dom <- sample(1:2, size=500, replace=TRUE, prob=c(0.5,0.5))
genuri <- factor(dom, labels=c("F","M"))

library(RODBC)
library(plyr)
library(lubridate)
dbhandle <- odbcDriverConnect('driver={SQL Server};server=DESKTOP-TTIFB45;database=Proiect_SSD;trusted_connection=true')
query_functii <- sqlQuery(dbhandle, 'select * from Functii')
query_sucursale <- sqlQuery(dbhandle, 'select * from Sucursale')
odbcClose(dbhandle)
dom <- sample(1:8, size=2000, replace=TRUE, prob=c(0.2,0.1,0.1,0.1,0.1,0.1,0.1,0.1))
sucursale <- query_sucursale$id_sucursala
sucursale_generate <- factor(sucursale[dom], levels = sucursale)
table(sucursale_generate)
n_elements <- sum(table(query_functii$id_functie))
equal_probabilities <- rep(1/n_elements, n_elements)
dom <- sample(1:n_elements, size = 2000, replace = TRUE, prob = equal_probabilities)
functii <- query_functii$id_functie
functii_generate <- factor(dom, levels = 1:n_elements, labels = functii)
n_elements <- length(functii_generate) 
salariu_mediu_values <- numeric(n_elements)  

dbhandle <- odbcDriverConnect('driver={SQL Server};server=DESKTOP-TTIFB45;database=Proiect_SSD;trusted_connection=true')

for (i in 1:n_elements) {
  sql_query <- paste("SELECT ROUND(salariu_baza_brut_max + ((salariu_baza_brut_max - salariu_baza_brut_min) * RAND()), 0) as salariu_brut",
                     "FROM functii",
                     "WHERE id_functie =", functii_generate[i])
  
  # Execute SQL query
  result <- sqlQuery(dbhandle, sql_query)
  
  avg_salary <- result
  salariu_mediu_values[i] <- round(avg_salary - (35 * avg_salary / 100) - (10 * (avg_salary - (35 * avg_salary / 100)) / 100),0)
}

odbcClose(dbhandle)

n_elements <- length(nume_romanesti)
equal_probabilities <- rep(1/n_elements, n_elements)
dom <- sample(1:n_elements, size=500, replace=TRUE, prob=equal_probabilities)
nume_generate <- nume_romanesti[dom]

prenume_generate <- ifelse(genuri == "F", sample(prenume_femei, size = 500, replace = TRUE), sample(prenume_barbati, size = 500, replace = TRUE))
email_domains <- sample(c("@gmail.com", "@yahoo.com"), size = 500, replace = TRUE, prob = c(0.2, 0.8))
emails_generate <- paste0(prenume_generate, ".", nume_generate, email_domains)

numere_telefon_generate<- character(2000)

for (i in 1:2000) {
  random_digits <- sample(0:9, size = 8, replace = TRUE)
  numere_telefon <- paste0("07", paste0(random_digits, collapse = ""))
  numere_telefon_generate[i] <- numere_telefon
}

date_angajati <- data.frame(
  id = id,
  nume_generate = nume_generate,
  prenume_generate = prenume_generate,
  genuri = genuri,
  emails_generate = emails_generate,
  numere_telefon_generate = numere_telefon_generate,
  sucursale_generate = sucursale_generate,
  functii_generate = functii_generate
)

date_angajati$salariu_mediu_values <- unlist(salariu_mediu_values)

write.csv(date_angajati, "date_angajati.csv", row.names = FALSE)

dbhandle <- odbcDriverConnect('driver={SQL Server};server=DESKTOP-TTIFB45;database=Proiect_SSD;trusted_connection=true')

for (i in 1:nrow(date_angajati)) {
  query <- paste("INSERT INTO Angajati (gender, nume, prenume, email, telefon, id_sucursala, id_functie, salariu) VALUES (",
                 "'", date_angajati$genuri[i], "', ",
                 "'", date_angajati$nume_generate[i], "', ",
                 "'", date_angajati$prenume_generate[i], "', ",
                 "'", date_angajati$emails_generate[i], "', ",
                 "'", date_angajati$numere_telefon_generate[i], "', ",
                 date_angajati$sucursale_generate[i], ", ",
                 date_angajati$functii_generate[i], ", ",
                 date_angajati$salariu_mediu_values[i], ")",
                 sep="")
  
  odbcQuery(dbhandle, query)
}

odbcClose(dbhandle)


#pdf scrapping -----------------------------------------------------------
library(pdftools)
library(readr)

text <- pdf_text('fisa-isfc-dep-BC.pdf')
data <- pdf_data('fisa-isfc-dep-BC.pdf')


# Prelucrare date achizitii pentru export-ul catre baza de date -----------------
library(readxl)
library(lubridate)
library(plyr)
library(dplyr)

date_achizitii <- read_excel("Anexa_Achizitii3.xlsx")
date_achizitii$Data_Începere <- as.Date((date_achizitii$Data_Începere), format = "%d.%m.%Y")
num_nulls <- sum(is.na(date_achizitii$Data_Începere))

validare_stadiu_executie <- function(stadiu_executie) {
  stadiu_executie <- ifelse(grepl("%", stadiu_executie), as.numeric(gsub("%", "", stadiu_executie)), as.numeric(stadiu_executie))
  
  if (is.na(stadiu_executie)) {
    print("format invalid")
    return(NULL)
  }
  
  return(ifelse(stadiu_executie > 1, stadiu_executie / 100, stadiu_executie))
}

date_achizitii$`Stadiu execuţie (%)` <- sapply(date_achizitii$`Stadiu execuţie (%)`, validare_stadiu_executie)

curatare_numere <- function(string_numeric) {
  if (grepl(",", string_numeric)) {
    cleaned_string <- gsub("\\.", "", string_numeric)
    cleaned_string <- gsub(",", ".", cleaned_string)
    
    cleaned_numeric <- as.numeric(cleaned_string)
    
    if (!is.na(cleaned_numeric)) {
      return(cleaned_numeric)
    } else {
      return(NULL)
    }
  } else {
    numeric_result <- as.numeric(string_numeric)
    
    if (!is.na(numeric_result)) {
      return(numeric_result)
    } else {
      return(NULL)
    }
  }
}
#Real usage:
date_achizitii$`Valoare (lei, fără TVA)` <- sapply(date_achizitii$`Valoare (lei, fără TVA)`, curatare_numere)

clean_and_convert_date <- function(date_strings) {
  date_pattern <- "\\b\\d{2}\\.\\d{2}\\.\\d{4}\\b"
  valid_dates <- regmatches(date_strings, regexpr(date_pattern, date_strings, perl = TRUE))
  valid_dates <- trimws(valid_dates)
  converted_dates <- as.Date(valid_dates, format = "%d.%m.%Y", tryFormats = c("%Y-%m-%d", "%d.%m.%Y"))
  return(converted_dates)
}

calculate_data_finala <- function(data_initiala, data_finala) {
  #data_initiala <- clean_and_convert_date(data_initiala)
  data_finala <- tolower(data_finala)
  is_luni <- grepl("luni", data_finala)
  is_zile <- grepl("zile", data_finala)
  if (!is_luni && !is_zile) {
    return(data_finala)
  }
  num <- as.numeric(gsub("\\D", "", data_finala))
  data_initiala <- as.Date(data_initiala, format = "%d.%m.%Y", tryFormats = c("%Y-%m-%d", "%d.%m.%Y"))
  result_date <- ifelse(is_luni, as.character(data_initiala + months(num)),
                        ifelse(is_zile, as.character(data_initiala + days(num)), as.character(data_finala)))
  return(result_date)
}

# Test
calculate_data_finala('17.01.2012', '13 zile' )
calculate_data_finala(date_achizitii$Data_Începere[1], date_achizitii$`Dată finalizare/Timp necesar`[1])


date_achizitii$`Dată finalizare/Timp necesar` <- mapply(calculate_data_finala,
                                                        date_achizitii$Data_Începere,
                                                        date_achizitii$`Dată finalizare/Timp necesar`)

date_achizitii <- date_achizitii %>%
  mutate(`Dată finalizare/Timp necesar` = case_when(
  grepl("\\.", `Dată finalizare/Timp necesar`) ~ dmy(`Dată finalizare/Timp necesar`),  # If the format is day.month.year
    grepl("/", `Dată finalizare/Timp necesar`) ~ dmy(`Dată finalizare/Timp necesar`),  # If the format is day/month/year
   grepl("-", `Dată finalizare/Timp necesar`) ~ ymd(`Dată finalizare/Timp necesar`),  # If the format is year-month-day
    TRUE ~ as.Date(`Dată finalizare/Timp necesar`, format = "%d.%m.%Y", quiet = TRUE)
 ))

last_dplyr_warnings()

date_achizitii$`Dată finalizare/Timp necesar` <- as.Date((date_achizitii$`Dată finalizare/Timp necesar`), format = "%d.%m.%Y")

print(date_achizitii$`Dată finalizare/Timp necesar` - date_achizitii$Data_Începere)

date_achizitii$`Stadiu execuţie (%)` <- as.numeric(gsub("%", "", date_achizitii$`Stadiu execuţie (%)` ))

dbhandle <- odbcDriverConnect('driver={SQL Server};server=DESKTOP-TTIFB45;database=Proiect_SSD;trusted_connection=true')

if (is.null(dbhandle)) {
  stop("Database connection failed.")
}

furnizorPatterns <- date_achizitii$`Denumire furnizor / prestator / executant`
furnizori <- numeric(length(furnizorPatterns))
for (i in seq_along(furnizorPatterns)) {
  furnizorPattern <- paste0("'", furnizorPatterns[i], "'")
  query <- paste("select dbo.RETURN_FURNIZOR_ID(", furnizorPattern, ")", sep = "")
  result <- sqlQuery(dbhandle, query)
  furnizori[i] <- result
  num_nulls <- sum(is.na(furnizori))
  num_nulls
}

odbcClose(dbhandle)

dbhandle <- odbcDriverConnect('driver={SQL Server};server=DESKTOP-TTIFB45;database=Proiect_SSD;trusted_connection=true')
for (i in 1:nrow(date_achizitii)) {
  id_sucursala_query <- paste("SELECT id_sucursala FROM sucursale WHERE denumire_sucursala = '", date_achizitii$Sucursala[i], "'", sep="")
  id_sucursala_fetch <- as.numeric(sqlQuery(dbhandle, id_sucursala_query))

  
  query <- paste("INSERT INTO Achizitii (id_sucursala, id_furnizor, data_achizitie, data_finalizare, obiect, valoare, stadiu_executie, tip_procedura) VALUES (",
                 id_sucursala_fetch, ", ",
                 furnizori[i], ", ",
                 "'", date_achizitii$Data_Începere[i], "', ",
                 "'", date_achizitii$`Dată finalizare/Timp necesar`[i], "', ",
                 "'", date_achizitii$Obiect[i], "', ", 
                 "'", date_achizitii$`Valoare (lei, fără TVA)`[i], "', ",
                 "'", date_achizitii$`Stadiu execuţie (%)`[i], "', ",
                 "'", date_achizitii$`Tipul procedurii aplicate pt. atribuire`[i], "')",
                 sep="")

  tryCatch({
    odbcQuery(dbhandle, query)
  }, error = function(e) {
    cat("Error: ", e$message, "\n")
  })
}

odbcClose(dbhandle)
warnings()

date_achizitii <- na.omit(date_achizitii)
date_achizitii$`Valoare (lei, fără TVA)` <- as.numeric(gsub(",", ".", date_achizitii$`Valoare (lei, fără TVA)`))
summary(date_achizitii$`Valoare (lei, fără TVA)`)
summary(date_achizitii$`Valoare (lei, fără TVA)`[date_achizitii$Sucursala == 'Bucuresti'])
summary(date_achizitii$`Valoare (lei, fără TVA)`[date_achizitii$Sucursala == 'Craiova'])
summary(date_achizitii$`Valoare (lei, fără TVA)`[date_achizitii$Sucursala == 'Timisoara'])
summary(date_achizitii$`Valoare (lei, fără TVA)`[date_achizitii$Sucursala == 'Brasov'])
summary(date_achizitii$`Valoare (lei, fără TVA)`[date_achizitii$Sucursala == 'Iasi'])
summary(date_achizitii$`Valoare (lei, fără TVA)`[date_achizitii$Sucursala == 'Galati'])
summary(date_achizitii$`Valoare (lei, fără TVA)`[date_achizitii$Sucursala == 'Constanta'])

orase <- c('Bucuresti','Craiova','Timisoara','Brasov','Iasi','Galati','Constanta')
colors <- rainbow(length(orase))
boxplots_list <- list()

windows()
par(mfrow = c(1, 7))
for (i in seq_along(orase)) {
  oras <- orase[i]
  color <- colors[i]
  subset_data <- date_achizitii$`Valoare (lei, fără TVA)`[date_achizitii$Sucursala == oras]
  boxplots_list[[oras]] <- boxplot(subset_data, main = oras, col = color)
}

par(mfrow = c(1, 1))

par(mfrow = c(1, 1))
for (oras in orase) {
  outliers <- boxplots_list[[oras]]$out
  numeric_dates <- date_achizitii$Data_Începere[date_achizitii$Sucursala == oras]
  formatted_dates <- format(as.Date(as.character(numeric_dates), origin = "1970-01-01"), "%d %b %Y")
  
  cat("Sucursala:", oras, "\n")
  cat("Outliers însoțiți de data în care s au produs:\n")
  for (i in seq_along(outliers)) {
    cat("  Outlier:", outliers[i], " | Date:", formatted_dates[i], "\n")
  }
  cat("\n")
}

windows()
par(mfrow = c(1, 7))
colors <- rainbow(length(orase))
density_plots <- list()

for (i in seq_along(orase)) {
  oras <- orase[i]
  color <- colors[i]
  
  subset_data <- date_achizitii$`Valoare (lei, fără TVA)`[!is.na(date_achizitii$`Valoare (lei, fără TVA)`) & date_achizitii$Sucursala == oras]
  density_plots[[oras]] <- density(subset_data)
  plot(density_plots[[oras]], main = oras, col = color, xlab = "Value", ylab = "Density")
}

par(mfrow = c(1, 1))


windows()
par(mfrow = c(1, 7))
colors <- rainbow(length(orase))
hist_plots <- list()

for (i in seq_along(orase)) {
  oras <- orase[i]
  color <- colors[i]
  subset_data <- date_achizitii$`Valoare (lei, fără TVA)`[date_achizitii$Sucursala == oras]
  hist(subset_data, col = color, main = oras, xlab = "Value", ylab = "Frequency")
}

par(mfrow = c(1, 1))


obiective <- date_achizitii$Obiect
proceduri <- date_achizitii$`Tipul procedurii aplicate pt. atribuire`
furnizori <- date_achizitii$`Denumire furnizor / prestator / executant`

writeLines(obiective, "obiective.txt")
writeLines(proceduri, "proceduri.txt")
writeLines(furnizori, "furnizori.txt")