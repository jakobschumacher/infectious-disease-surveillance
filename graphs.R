
pacman::p_load(dplyr, plotly, ggplot2, purrr)
create_surveillance_plot <- function(highlight = "none", output_type = "ggplot", language = "en") {

  # Data preparation with language selection
  if (language == "de") {
    stage <- c("2\nEreignis",
               "3\nSammeln",
               "4\nKlassifizieren",
               "5\nDaten",
               "6\nAnalysieren",
               "7\nVermitteln",
               "8\nHandeln")

    hoverinfo <- c(
      "Stufe 2: Definition der Ereignisse",
      "Stufe 3: Sammlung der Ereignisse",
      "Stufe 4: Klassifizierung der gesammelten Informationen",
      "Stufe 5: Datenmanagement und Verarbeitung",
      "Stufe 6: Analyse und Bewertung der Daten",
      "Stufe 7: Kommunikation der Ergebnisse",
      "Stufe 8: Maßnahmen basierend auf Überwachungsinformationen"
    )
    center_text <- "1 \nZiele der\nSurveillance"
  } else {
    stage <- c("2\nEvent",
               "3\nCollect",
               "4\nClassify",
               "5\nData",
               "6\nAnalyse",
               "7\nCommunicate",
               "8\nAct")

    hoverinfo <- c(
      "Stage 2: Define the Events",
      "Stage 3: Collect the events",
      "Stage 4: Classify collected information",
      "Stage 5: Data management and processing",
      "Stage 6: Analysis and assessment of data",
      "Stage 7: Communication of findings",
      "Stage 8: Action based on surveillance information"
    )
    center_text <- "Stage 1: \n Objectives of\nSurveillance"
  }

  base_colors <- c('#1b9e77','#d95f02','#7570b3','#e7298a','#66a61e','#e6ab02','#a6761d')
  grey_color <- "#e3e3e3"
  center_color <- if (highlight == "Stage 1") "#cc3dac" else grey_color

  # Create the color palette for the pie slices
  colors <- if (highlight == "none") {
    base_colors
  } else {
    highlight_index <- match(highlight, paste0("Stage ", 2:8)) # Match the stage index
    ifelse(1:7 == highlight_index, base_colors, grey_color)
  }

  # Create dataframe
  graphdata <- data.frame(stage = stage, hoverinfo = hoverinfo, size = rep(1, 7), colors = colors) |>
    dplyr::mutate(
      cumulative = cumsum(size),
      midpoint = cumulative - size / 2
    )

  if (output_type == "ggplot") {
    # ggplot2 version
    plot <- ggplot2::ggplot(dplyr::arrange(graphdata, dplyr::desc(stage)), ggplot2::aes(x = "", y = size, fill = stage)) +
      ggplot2::geom_col(width = 0.5, color = "white") +  
      ggplot2::geom_text(ggplot2::aes(y = midpoint, label = stage), color = "white", size = 6) +  
      ggplot2::coord_polar(theta = "y") +  
      ggplot2::scale_fill_manual(values = colors) +
      ggplot2::theme_void() +
      ggplot2::theme(
        legend.position = "none",
        plot.margin = ggplot2::margin(0,0,0,0)
      ) +
      ggplot2::annotate("point", x = 0, y = 0, size = 120, color = center_color, shape = 21, fill = center_color) +
      ggplot2::annotate("text", x = 0, y = 0, label = center_text, size = 6, hjust = 0.5, colour = "white") 

    return(plot)

  } else if (output_type == "plotly") {
    # Plotly version
    plot <- plotly::plot_ly(
      data = graphdata,
      labels = ~stage,
      values = ~size,
      text = ~stage,
      pull = 0.02,
      marker = list(colors = colors),
      hoverinfo = 'text',
      textinfo = 'label',
      textfont = list(family = 'Arial, sans-serif', size = 12, color = "#fff"),
      insidetextorientation = 'horizontal',
      hovertext = hoverinfo,
      hoverlabel = list(font = list(size = 12), namelength = -1, padding = list(l = 30, r = 30, t = 30, b = 30))
    ) |>
      plotly::add_pie(hole = 0.6, direction = "clockwise", rotation = -25) |>
      plotly::layout(
        showlegend = FALSE,
        xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
        yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
        margin = list(l = 50, r = 50, t = 50, b = 50),
        annotations = list(
          list(
            text = center_text,
            x = 0.5,
            y = 0.5,
            font = list(size = 28, color = center_color),
            showarrow = FALSE
          )
        )
      )

    return(plot)
  } else {
    stop("Invalid output_type. Please use 'ggplot' or 'plotly'.")
  }
}


generate_surveillance_plots <- function(highlights = c("none", paste0("Stage ", 1:7)), languages = c("de", "en"), output_dir = "img/surveillance_plots", width = 12, height = 12) {

  
  # Ensure the output directory exists
  dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)
  
  # Generate all combinations of highlights and languages
  params <- expand.grid(highlight = highlights, language = languages)
  
  # Function to create and save a single plot
  create_and_save_plot <- function(highlight, language) {
    # Create the plot
    plot <- create_surveillance_plot(highlight = highlight, output_type = "ggplot", language = language)
    
    # Reduce plot margins by modifying the theme
    plot <- plot + theme(plot.margin = margin(0,0,0,0)) # Adjust margins as needed (top, right, bottom, left)
    
    # Define file name
    file_name <- paste0(output_dir, "/surveillance_", language, "_", tolower(gsub(" ", "_", highlight)), ".png")
    # Save the plot
    ggsave(filename = file_name, plot = plot, width = width, height = height)
  }
  
  # Apply the function to all parameter combinations
  params %>%
    pmap(~ create_and_save_plot(highlight = ..1, language = ..2))
  
  cat("All plots created and saved in the directory:", output_dir, "\n")
}

# Call the function with custom width and height
generate_surveillance_plots()

